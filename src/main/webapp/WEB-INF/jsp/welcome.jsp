<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@ page session="true" %>
<html lang="en">
<head>
	<%@ page contentType="text/html;charset=utf-8" %>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
	<style><%@include file="/WEB-INF/css/main.css"%></style>

	<script>
		$(document).ready(function($) {
			$(".table-row").click(function() {
				window.document.location = $(this).data("href");
			});
		});

	</script>
	<title>Главная страница</title>
</head>
<body>
	<div class="container">
		<nav class="navbar navbar-expand-md navbar-light bg-light">
			<a href="${pageContext.request.contextPath}/welcome" class="navbar-brand">КИНТОТЕАТР</a>
			<button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarCollapse">
				<div class="navbar-nav">
					<a href="${pageContext.request.contextPath}/welcome" class="nav-item nav-link active">Главная</a>
					<a href="${pageContext.request.contextPath}/personal/${sessionScope.user.id}" class="nav-item nav-link">Мои билеты</a>
                    <c:if test="${sessionScope.user.role.name eq 'ROLE_ADMIN' or sessionScope.user.role.name eq 'ROLE_MODERATOR'}">
                        <a href="${pageContext.request.contextPath}/admin/films" class="nav-item nav-link">Фильмы</a>
                    </c:if>
				</div>
				<div class="navbar-nav ml-auto">
					<span class="navbar-text"><c:out value="${sessionScope.user.username}"/></span>
					<a href="${pageContext.request.contextPath}/logout" class="nav-item nav-link">Logout</a>
				</div>
			</div>
		</nav>
		<h1>ВЫБЕРИТЕ СЕАНС</h1>
		<%--@elvariable id="sessions" type="com.potopahin.cinema.entity.Session"--%>
		<form:form modelAttribute="sessions" action="/welcome" method="post">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>#</th>
						<th>Фильм</th>
						<th>Дата</th>
						<th>Время</th>
						<th>Длительность, мин</th>
						<th>Цена</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${sessions}" var="session">
						<tr class="table-row" onclick="window.location='${pageContext.request.contextPath}/session/${session.id}';">
							<td><c:out value="${session.id}"/></td>
							<td><c:out value="${session.film.name}"/></td>
							<td><fmt:formatDate type="date" value="${session.startDateTime}"/></td>
							<td><fmt:formatDate type="time" value="${session.startDateTime}" timeStyle="short"/></td>
							<td><c:out value="${session.film.duration}"/></td>
							<td><c:out value="${session.price}"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form:form>
	</div>


	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</body>

</html>
