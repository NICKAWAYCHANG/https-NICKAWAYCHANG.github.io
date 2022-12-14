<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
			<!DOCTYPE html>
			<html lang="en">

			<head>
				<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
				<meta charset="UTF-8">
				<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
				<title>Spring Boot WebSocket Chat Application | CalliCoder</title>
				<link rel="stylesheet" href="css/Ws.css" />
			</head>

			<body background="test1.jpg"
				style="background-position: center; background-repeat: no-repeat; background-size: cover;">
				<noscript>
					<h2>Sorry! Your browser doesn't support Javascript</h2>
				</noscript>
				<div id="123">
					<canvas id="canvas1"></canvas>
				</div>
				<div id="username-page">
					<div class="username-page-container">
						<h1 class="title">Hi 先生/小姐 您好</h1>
						<form id="usernameForm" name="usernameForm">
							<div class="form-group">
								<input readonly type="text" id="name" value="${member.name}" autocomplete="off"
									class="form-control" />
							</div>
							<div class="form-group">
								<button type="submit" class="accent username-submit">Start
									Chatting</button>
							</div>
						</form>
					</div>
				</div>

				<div id="chat-page" class="hidden">
					<div class="chat-container">
						<div class="chat-header">
							<h2>即時客服</h2>
						</div>
						<div class="connecting">Connecting...</div>
						<ul id="messageArea">

						</ul>
						<form id="messageForm" name="messageForm" nameForm="messageForm">
							<div class="form-group">
								<div class="input-group clearfix">
									<input type="text" id="message" placeholder="Type a message..." autocomplete="off"
										class="form-control" />
									<button type="submit" class="primary">Send</button>
								</div>
							</div>
						</form>
					</div>
				</div>

				<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
				<script defer src="js/Ws.js"></script>
				<script src="${contextRoot}/js/jquery-3.6.1.min.js"></script>
				<script>
					$(document).ready(function () {
						console.log($("#name").val())
						if ($("#name").val() == "") {
							window.location.href = "${contextRoot}/login";
							return;
						}
					})

		//  			window.onload = function() {
		//  				console.log($("#name").val())
		// 				if($("#name").val()==""){
		//  					window.location.href="${contextRoot}/login";
		//  					return ;
		//  			}
		//  		}
				</script>
			</body>

			</html>