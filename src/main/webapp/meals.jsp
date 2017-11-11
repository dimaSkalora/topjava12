<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import ="java.util.List"%>
<%@ page import="ru.javawebinar.topjava.model.Meal" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.Month" %>
<%@ page import="ru.javawebinar.topjava.model.MealWithExceed" %>
<%@ page import="java.time.LocalTime" %>
<%@ page import="ru.javawebinar.topjava.util.MealsUtil" %>

<%
    List<Meal> meals = Arrays.asList(
            new Meal(LocalDateTime.of(2015, Month.MAY, 30, 10, 0), "Завтрак", 500),
            new Meal(LocalDateTime.of(2015, Month.MAY, 30, 13, 0), "Обед", 1000),
            new Meal(LocalDateTime.of(2015, Month.MAY, 30, 20, 0), "Ужин", 500),
            new Meal(LocalDateTime.of(2015, Month.MAY, 31, 10, 0), "Завтрак", 1000),
            new Meal(LocalDateTime.of(2015, Month.MAY, 31, 13, 0), "Обед", 500),
            new Meal(LocalDateTime.of(2015, Month.MAY, 31, 20, 0), "Ужин", 510)
    );
    request.setAttribute("meals",meals);
%>

<%
    List<MealWithExceed> mealsWithExceeded = MealsUtil.getFilteredWithExceeded(meals, LocalTime.of(7, 0), LocalTime.of(12, 0), 2000);
    request.setAttribute("mealsWithExceeded",mealsWithExceeded);
%>

<html>
<head>
    <title>Meals</title>
</head>
<body>
<h1>Список еды</h1>
    <table border="1" cellspacing="0" cellpadding="8">
        <tr>
            <td>DateTime</td>
            <td>Description</td>
            <td>Calories</td>
        </tr>
        <c:forEach var="mwe" items="${mealsWithExceeded}">
            <c:if test="${mwe.exceed}">
                <tr style="color: green">
                    <td>${mwe.dateTime}</td>
                    <td>${mwe.description}</td>
                    <td>${mwe.calories}</td>
                </tr>
            </c:if>
            <c:if test="${!mwe.exceed}">
                <tr style="color: red">
                    <td>${mwe.dateTime}</td>
                    <td>${mwe.description}</td>
                    <td>${mwe.calories}</td>
                </tr>
            </c:if>
        </c:forEach>
    </table>
</body>
</html>
