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
	<script>
        function changeTicket(value) {
            document.getElementById("chosenTicket").value = value;
        }
	</script>
	<title>Билеты</title>
</head>
<body>
<form:form action="/cart/removeTicket" method="post">
	<input id="chosenTicket" name="chosenTicket" style="display: none"/>
	<div class="modal fade" id="removeTicketModal" tabindex="-1" role="dialog" aria-labelledby="removeTicketModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="removeTicketModalLabel">Подтверждение удаления</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					Вы действительно хотите удалить данный билет из корзины?
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
					<button type="submit" class="btn btn-danger">Удалить</button>
				</div>
			</div>
		</div>
	</div>
</form:form>

<form:form action="/cart/pay" method="post">
	<%--<input id="chosenTicket" name="chosenTicket" style="display: none"/>--%>
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
					Вы действительно хотите преобрести билеты на общую сумму ${sumPrice}грн?
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
					<button type="submit" class="btn btn-success">Преобрести</button>
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
					<a href="${pageContext.request.contextPath}/welcome" class="nav-item nav-link">
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
					<a href="${pageContext.request.contextPath}/cart/${sessionScope.user.id}" class="nav-item nav-link active">
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
		<h1>ВАША КОРЗИНА
			<c:if test="${haveTickets}">
				, сумма: ${sumPrice}грн.
				<button type="button" class="btn btn-primary" data-toggle="modal"
						data-target="#payModal">Оплатить</button>
			</c:if>
		</h1>
		<c:if test="${haveTickets}">
			<table class="table table-hover">
				<thead>
				<tr>
					<th>#</th>
					<th>Фильм</th>
					<th>Дата</th>
					<th>Время</th>
					<th>Ряд</th>
					<th>Место</th>
					<th>Цена</th>
					<th>Удалить</th>
				</tr>
				</thead>
				<tbody>

				<c:forEach items="${tickets}" var="ticket">
					<tr class="table-row">
						<td><c:out value="${ticket.id}"/></td>
						<td><c:out value="${ticket.session.film.name}"/></td>
						<td><fmt:formatDate type="date" value="${ticket.session.startDateTime}"/></td>
						<td><fmt:formatDate type="time" value="${ticket.session.startDateTime}" timeStyle="short"/></td>
						<td><c:out value="${ticket.place.row}"/></td>
						<td><c:out value="${ticket.place.num}"/></td>
						<td><c:out value="${ticket.session.price}"/>грн</td>
						<td>
							<button onclick="changeTicket(${ticket.id})" data-toggle="modal"
									data-target="#removeTicketModal">
								<i class="far fa-trash-alt"></i>
							</button>

						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
		<c:if test="${not haveTickets}">
			<div class="container">
				<div class="row justify-content-center">
					<div class="d-flex justify-content-center">
						<i class="fas fa-magic"></i>&nbsp;Ваша корзина пуста.
					</div>
				</div>
			</div>
		</c:if>
	</div>


	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</body>

</html>
