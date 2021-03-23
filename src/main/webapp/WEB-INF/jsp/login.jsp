<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@ page session="true" %>
<html lang="en">
<head>
	<%@ page contentType="text/html;charset=utf-8" %>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
	<style><%@include file="/WEB-INF/css/main.css"%></style>


	<title>Авторизация</title>
</head>
<body>
	<div class="container">
		<nav class="navbar navbar-expand-md navbar-light bg-light">
			<a href="#" class="navbar-brand">КИНТОТЕАТР</a>
			<button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
				<span class="navbar-toggler-icon"></span>
			</button>
		</nav>
		<div class="row" style="margin-top: 100px">
			<div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
				<div class="d-flex justify-content-center h-100">
					<div class="card">
						<div class="card-header">
							<h3>Авторизация</h3>
						</div>
						<div class="card-body">
							<form:form method="POST" action="${contextPath}/login" modelAttribute="loginForm">
								<div class="input-group form-group">
									<div class="input-group-prepend">
										<span class="input-group-text"><i class="fas fa-user"></i></span>
									</div>
									<spring:bind path="username">
										<form:input path="username" type="text" class="form-control ${error ? 'is-invalid' : ''}" placeholder="username"></form:input>
									</spring:bind>
								</div>
								<div class="input-group form-group">
									<div class="input-group-prepend">
										<span class="input-group-text"><i class="fas fa-key"></i></span>
									</div>
									<spring:bind path="password">
										<form:input path="password" type="password" class="form-control ${error ? 'is-invalid' : ''}" placeholder="password"></form:input>
									</spring:bind>

								</div>
								<c:if test="${error}">
									<div class="alert alert-danger alert-dismissible fade show">Неверный юзернейм или пароль.</div>
								</c:if>
								<button class="btn btn-danger recordsColor justify-content-center" type="submit">Войти</button>
							</form:form>
						</div>
					</div>
                </div>
                <div class="d-flex justify-content-center h-100">
                    <a href="${pageContext.request.contextPath}/register">Ещё нет аккаунта? Нажми сюда</a>
                </div>
			</div>
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</body>

</html>
