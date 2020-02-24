<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="keys" content="">
<meta name="author" content="">
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.min.css">
<link rel="stylesheet" href="${APP_PATH}/static/css/login.css">
<style>
</style>
</head>
<body>
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<div>
					<a class="navbar-brand" href="index.html" style="font-size: 32px;">尚筹网-创意产品众筹平台</a>
				</div>
			</div>
		</div>
	</nav>

	<div class="container">

		<form class="form-signin" role="form" action="${APP_PATH}/admin/doLogin" method="post">
			<h2 class="form-signin-heading">
				<i class="glyphicon glyphicon-log-in"></i> 管理员登录
			</h2>
			<p>${message}</p>
			<div class="form-group has-success has-feedback">
				<input value="tom" type="text" name="loginAcct" class="form-control" id="inputSuccess4"
					placeholder="请输入登录账号" autofocus> <span
					class="glyphicon glyphicon-user form-control-feedback"></span>
			</div>
			<div class="form-group has-success has-feedback">
				<input type="text" name="userpswd"class="form-control"
					placeholder="请输入登录密码" style="margin-top: 10px;"  value="234456"> <span
					class="glyphicon glyphicon-lock form-control-feedback"></span>
			</div>
			<button type="submit" class="btn btn-lg btn-success btn-block">登录</button>

		</form>
	</div>
	<script src="${APP_PATH}/static/jquery/jquery-2.1.1.min.js"></script>
	<script src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>
	<script>
		/*function dologin() {
			var type = $(":selected").val();
			if (type == "user") {
				window.location.href = "main.html";
			} else {
				window.location.href = "index.html";
			}
		}*/
	</script>
</body>
</html>