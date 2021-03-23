<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@ page session="true" %>

<html lang="en">
<head>
    <%@ page contentType="text/html;charset=utf-8" %>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
          integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <style>
        <%@include file="/WEB-INF/css/main.css" %>
    </style>

    <script>
        function changePlace(value) {
            document.getElementById("chosenPlace").value = value;
        }
    </script>

    <title>Сеанс№${session.id}</title>
</head>
<body>

<form:form action="/session" method="post">
    <input id="chosenPlace" name="chosenPlace" style="display: none"/>
    <input id="sessionId" name="chosenSession" style="display: none" value="${session.id}"/>
    <div class="modal fade" id="payModal" tabindex="-1" role="dialog" aria-labelledby="payModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="payModalLabel">Подтверждение покупки</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Стоимость данного места составляет ${session.price}грн. Вы уверены, что хотите добавить место в корзину?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
                    <button type="submit" class="btn btn-warning">Добавить</button>
                </div>
            </div>
        </div>
    </div>
</form:form>

<div class="container">
    <nav class="navbar navbar-expand-md navbar-light bg-light">
        <a href="${pageContext.request.contextPath}/welcome" class="navbar-brand">КИНТОТЕАТР</a>
        <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarCollapse">
            <div class="navbar-nav">
                <a href="${pageContext.request.contextPath}/welcome" class="nav-item nav-link active">
                    <i class="fas fa-home"></i> Главная
                </a>
                <a href="${pageContext.request.contextPath}/personal/${sessionScope.user.id}" class="nav-item nav-link">
                    <i class="fas fa-ticket-alt"></i> Мои билеты
                </a>
                <c:if test="${sessionScope.user.role.name eq 'ROLE_ADMIN' or sessionScope.user.role.name eq 'ROLE_MODERATOR'}">
                    <a href="${pageContext.request.contextPath}/admin/films" class="nav-item nav-link">
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
        <button class="btn btn-outline-dark" type="button" name="back" onclick="history.back()">
            назад
        </button>
        ПРОСМОТР СЕАНСА №${session.id}
    </h1>
    <div class="card" style="margin-bottom: 100px">
        <div class="card-header">
            Информация о сеансе
        </div>
        <div class="card-body">
            <p class="card-text">Дата: <fmt:formatDate type="date" value="${session.startDateTime}"/></p>
            <p class="card-text">Время: <fmt:formatDate type="time" value="${session.startDateTime}"
                                                        timeStyle="short"/></p>
            <p class="card-text">Цена: ${session.price}грн.</p>
        </div>
        <div class="card">
            <div class="card-header">
                Информация о фильме
            </div>
            <div class="card-body">
                <h5 class="card-title">${session.film.name}</h5>
                <p class="card-text">${session.film.description}</p>
                <p class="card-text">Длительность: ${session.film.duration}мин.</p>
            </div>
        </div>
        <div class="list-group">
            <button type="button" class="list-group-item list-group-item-action active">
                Места
            </button>
            <div class="container">
                <div class="container" style="padding-bottom: 15px; padding-top: 15px;">
                    <c:if test="${addedToCart}">
                        <div class="alert alert-warning" role="alert">
                            Билет добавлен в вашу корзину на 10 минут, в это время место будет отображаться как недоступное для других пользователей.
                        </div>
                    </c:if>
                    <div class="row justify-content-center">
                        <div class="d-flex justify-content-center">
                            Экран
                        </div>
                    </div>

                    <c:forEach items="${places}" var="place" varStatus="loop">
                        <c:if test="${(loop.index)%5 eq 0}">
                            <div class="row justify-content-center">
                                <div class="d-flex justify-content-center">
                        </c:if>
                        <div class="col">

                            <c:if test="${place.enabled}">
                                <button type="button" onclick="changePlace(${place.place.id})" data-toggle="modal"
                                        data-target="#payModal" class="btn btn-primary"/>
                            </c:if>
                            <c:if test="${not place.enabled}">
                                <c:if test="${place.status eq 'IN_CART'}">
                                    <button type="button" class="btn btn-warning" disabled/>
                                </c:if>
                                <c:if test="${place.status eq 'BUSY'}">
                                    <button type="button" class="btn btn-dark" disabled/>
                                </c:if>

                            </c:if>
                        </div>
                        <c:if test="${(loop.index + 1)%5 eq 0}">
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>

                </div>
            </div>
        </div>
        <ul class="list-group">
            <li class="list-group-item d-flex justify-content-between align-items-center">
                Свободно
                <span class="badge badge-primary badge-pill">цвет</span>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center">
                В корзине
                <span class="badge badge-warning badge-pill">цвет</span>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center">
                Занято
                <span class="badge badge-dark badge-pill">цвет</span>
            </li>
        </ul>
    </div>


    <!-- Modal -->

</div>


<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>

</body>

</html>
