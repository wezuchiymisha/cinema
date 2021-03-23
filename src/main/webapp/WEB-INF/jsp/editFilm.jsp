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
	<title>Фильм</title>
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
					<a href="${pageContext.request.contextPath}/welcome" class="nav-item nav-link">
						<i class="fas fa-home"></i> Главная
					</a>
					<a href="${pageContext.request.contextPath}/personal/${sessionScope.user.id}" class="nav-item nav-link">
						<i class="fas fa-ticket-alt"></i> Мои билеты
					</a>
					<c:if test="${sessionScope.user.role.name eq 'ROLE_ADMIN' or sessionScope.user.role.name eq 'ROLE_MODERATOR'}">
						<a href="${pageContext.request.contextPath}/admin/films" class="nav-item nav-link active">
							<i class="fas fa-film"></i> Фильмы
						</a>
					</c:if>
					<a href="${pageContext.request.contextPath}/cart/${sessionScope.user.id}" class="nav-item nav-link">
						<i class="fas fa-shopping-cart"></i> Корзина
					</a>
				</div>
				<div class="navbar-nav ml-auto">
					<span class="navbar-text"><c:out value="${sessionScope.user.username}"/></span>
					<a href="${pageContext.request.contextPath}/logout" class="nav-item nav-link">
						<i class="fas fa-sign-out-alt"></i> Выйти
					</a>
				</div>
			</div>
		</nav>
		<h1>
			ФИЛЬМ
		</h1>
		<form:form method="post" action="${contextPath}/admin/film" modelAttribute="filmForm">
			<input id="isEdit" name="isEdit" style="display: none" value="${isEdit}"/>
			<input id="filmId" name="filmId" style="display: none" value="${filmId}"/>
			<div class="input-group form-group">
				<div class="input-group-prepend">
					<span class="input-group-text"><i class="fas fa-film"></i></span>
				</div>
				<spring:bind path="name">
					<form:input path="name" type="text" class="form-control ${error ? 'is-invalid' : ''}" placeholder="Название"></form:input>
				</spring:bind>
			</div>
			<div class="input-group form-group">
				<div class="input-group-prepend">
					<span class="input-group-text"><i class="fas fa-file-signature"></i></span>
				</div>
				<spring:bind path="description">
					<form:input path="description" type="text" class="form-control ${error ? 'is-invalid' : ''}" placeholder="Описание"></form:input>
				</spring:bind>
			</div>
			<div class="input-group form-group">
				<div class="input-group-prepend">
					<span class="input-group-text"><i class="fas fa-clock"></i></span>
				</div>
				<spring:bind path="duration">
					<form:input path="duration" type="text" class="form-control ${error ? 'is-invalid' : ''}" placeholder="Длительность"></form:input>
				</spring:bind>
			</div>
			<button type="button" class="btn btn-secondary" onclick="window.location='${pageContext.request.contextPath}/admin/films';">Отмена</button>
			<button type="submit" class="btn btn-primary">Сохранить</button>
		</form:form>
	</div>


	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</body>

</html>
