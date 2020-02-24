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
				  <li class="active">修改页面</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form action="${APP_PATH }/admin/doEdit" method="POST" role="form">
					<input type="hidden" name="id"value="${admin.id }"/>
					
					<input type="hidden" name="pageNum" value="${param.pageNum }"/>
					
				  <div class="form-group">
					<label>登陆账号</label>
					<input type="text" class="form-control"  name="loginacct" value="${admin.loginacct }">
				  </div>
				  <div class="form-group">
					<label>用户名称</label>
					<input type="text" class="form-control" name="username" value="${admin.username }">
				  </div>
				  <div class="form-group">
					<label for="exampleInputEmail1">邮箱地址</label>
					<input type="email" class="form-control" id="exampleInputEmail1" name="email" value="${admin.email }">
					<p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
				  </div>
				  <button type="submit" class="btn btn-success"><i class="glyphicon glyphicon-edit"></i> 修改</button>
				  <button type="reset" id="resetBtn" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>
    
  </body>
</html>
