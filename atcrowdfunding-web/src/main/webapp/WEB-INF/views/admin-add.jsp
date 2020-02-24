<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
  <head>
	<%@ include file="/WEB-INF/include/head.jsp" %>
  </head>

  <body>
<%@ include file="/WEB-INF/include/navigation.jsp" %>
    
    <div class="container-fluid">
      <div class="row">
        <%@ include file="/WEB-INF/include/sidebar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
         	
				<ol class="breadcrumb">
				  <li><a href="${APP_PATH }/admin/keySearch">数据列表</a></li>
				  <li class="active">新增页面</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form role="form" action="${APP_PATH}/admin/doAdd" method="POST">
				  <div class="form-group">
					<label>登陆账号</label>
					<input name="loginacct" type="text" class="form-control"  placeholder="请输入登陆账号">
				  </div>
				  <div class="form-group">
					<label>用户名称</label>
					<input name="username" type="text" class="form-control"  placeholder="请输入用户名称">
				  </div>
				  <div class="form-group">
					<label for="exampleInputEmail1">邮箱地址</label>
					<input name="email" type="email" class="form-control" id="exampleInputEmail1" placeholder="请输入邮箱地址">
					<p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
				  </div>
				  <button type="submit" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
				  <button type="reset" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
				</form>
			  </div>
			</div>
      
        </div>
      </div>
    </div>
    
  </body>
</html>
