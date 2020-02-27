<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<%@ include file="/WEB-INF/include/head.jsp" %>
<link rel="stylesheet" href="${APP_PATH}/static/css/pagination.css" />
<script type="text/javascript" src="${APP_PATH}/static/script/jquery.pagination.js"></script>
<script type="text/javascript">
$(function() {

	$("#saveRole").click(function(){
		var roleName = $("#roleName").val();
		if (roleName == ""){
			alert("请填写！再进行保存")
			return;
		}
		$.ajax({
			url:"${APP_PATH}/role/save",
			type:"POST",
			data:{
				"name":roleName
			},
			success:function(result){
				if(result=="success"){
					alert("保存成功")
					$('#addModal').modal('hide');
					window.location.href="${APP_PATH}/role/keySearch";
				}
				if(result=="fail"){
					$('#addModal').modal('hide');
					alert("保存失败！请联系管理员")
				}

			}
		});
});

})

/**
 * 修改的JS操作
 * @param id
 * @param name
 */
	function toEdit(id,name){
		$('#editModal').modal('show');
		$("#editRoleName").val(name);
		$("#editRoleBtn").click(function(){
			if($("#editRoleName").val()==name){
				alert("你尚未作出任何的改变，请确认你要修改的值")
				return;
			}
			var newName = $("#editRoleName").val();
			$.ajax({
				url:"${APP_PATH}/role/doEdit",
				type:"POST",
				data:{
					"name":newName,
					"id" : id,
				},
				success:function(result){
					if(result=="success"){
						alert("修改成功")
						$('#editModal').modal('hide');
						window.location.href="${APP_PATH}/role/keySearch";
					}
					if(result=="fail"){
						$('#editModal').modal('hide');
						alert("修改失败！请联系管理员")
					}

				}
			});
		});
	}

/**
 * 单条删除操作
 * @param id
 */
//=========================================单条记录删除=======================================================
function singleRemoveRole(id){
	var confirmResult = confirm("你确定要删除该信息吗？");
	if(!confirmResult){
		return;
	}
	//发送ajax请求
	var ids = [];
	ids.push(id);
	removeAjax(ids);
}
//封住批量和单个删除的Ajax函数
function removeAjax(IdArray){
	$.ajax({
		url:"${APP_PATH}/role/remove",
		type:"POST",
		data: {
			"ids":IdArray
		},
		success:function(response){
			console.log(response);
			if(response="success"){
				alert("删除成功");
				window.location.href = "${APP_PATH}/role/keySearch";
			}else{
				alert("删除失败")
			}

		},
		error:function(response){
			console.log(response);
		}
	});
}
</script>
</head>

  <body>
<%@ include file="/WEB-INF/include/navigation.jsp" %>
    <!-- 新增模态框start -->
    <div id="addModal" class="modal fade" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">新增角色操作</h4>
	      </div>
	      <div class="modal-body">
	        <!-- 数据展示 -->

			  <div class="form-group">
				<label>添加角色</label>
				<input name="name" type="text" class="form-control" id="roleName" placeholder="请输入新的角色名称">
			  </div>
	        	
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button id="saveRole" type="button" class="btn btn-primary">保存</button>
		      </div>
	      </div>
	    </div>
	  </div>
	</div><!-- 修改模态框start -->
    <div id="editModal" class="modal fade" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">修改角色操作</h4>
	      </div>
	      <div class="modal-body">
	        <!-- 数据展示 -->

			  <div class="form-group">
				<label>修改角色</label>
				<input name="name" type="text" class="form-control" id="editRoleName" placeholder="请输入新的角色名称">
			  </div>

		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button id="editRoleBtn" type="button" class="btn btn-primary">修改</button>
		      </div>

	        <!-- 数据展示============================================= -->

	      </div>
	    </div>
	  </div>
	</div>
    <!-- 修改模态框end -->
    <div class="container-fluid">
      <div class="row">
        <%@ include file="/WEB-INF/include/sidebar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
         	<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
<form action="${APP_PATH}/role/keySearch" method="POST" class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input name="keyword"  class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button type="submit" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button data-toggle="modal" data-target="#addModal" type="button" class="btn btn-primary" style="float:right;" >
<i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="45">序号</th>
                  <th>名称</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>

              <c:forEach items="${PAGE_INFO_KEY.list}" var="role" varStatus="code">
                <tr>
                  <td align="center">${code.count }</td>
                  <td>${role.name}</td>
                  <td>
				      <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
				      <button type="button" class="btn btn-primary btn-xs"
							  onclick="toEdit('${role.id}','${role.name}');"><i class=" glyphicon glyphicon-pencil"></i></button>
					  <button type="button" class="btn btn-danger btn-xs"
							  onclick="singleRemoveRole('${role.id}');"><i class=" glyphicon glyphicon-remove"></i></button>
				  </td>
                </tr>
              </c:forEach>
               
              </tbody>
			  <tfoot>
			  <tr>
				  <td colspan="6" align="center">
					  <div id="Pagination">
						  <nav aria-label="Page navigation">
							  <ul class="pagination">
								  <li>
									  <a href="${APP_PATH}/role/keySearch?pageNum=1&keyword=${param.keyword}"><span>首页</span></a>
								  </li>
								  <%--上一页按钮控制--%>
								  <c:choose>
									  <%--如果是上一页--%>
									  <c:when test="${PAGE_INFO_KEY.isFirstPage}">
										  <li class="disabled"><span>上一页</span></li>
									  </c:when>
									  <c:when test="${!PAGE_INFO_KEY.isFirstPage}">
										  <li>
											  <a href="${APP_PATH}/role/keySearch?pageNum=${PAGE_INFO_KEY.prePage}&keyword=${param.keyword}">上一页</a>
										  </li>
									  </c:when>
								  </c:choose>

								  <c:forEach items="${PAGE_INFO_KEY.navigatepageNums}" var="num">
									  <%--
                                          ${PAGE_INFO_KEY.pageNum == num ? 'active' : ''}
                                          pageNum属性：当前页
                                          高亮显示
                                      --%>
									  <li class="${PAGE_INFO_KEY.pageNum == num ? 'active' : ''} " >
										  <a href="${APP_PATH}/role/keySearch?pageNum=${num}&keyword=${param.keyword}">${num}</a>
									  </li>

								  </c:forEach>
								  <%--下一页按钮控制--%>
								  <c:choose>
									  <%--如果是最后一页--%>
									  <c:when test="${PAGE_INFO_KEY.isLastPage}">
										  <li class="disabled"><span>下一页</span></li>
									  </c:when>
									  <c:when test="${!PAGE_INFO_KEY.isLastPage}">
										  <li>
											  <a href="${APP_PATH}/role/keySearch?pageNum=${PAGE_INFO_KEY.nextPage}&keyword=${param.keyword}">下一页</a>
										  </li>
									  </c:when>
								  </c:choose>
								  <li>
									  <a href="${APP_PATH}/role/keySearch?pageNum=${PAGE_INFO_KEY.lastPage}&keyword=${param.keyword}"><span>末页</span></a>
								  </li>
							  </ul>
						  </nav>
					  </div>
				  </td>
			  </tr>

			  </tfoot>
            </table>
          </div>
			  </div>
			</div>
        </div>
      </div>
    </div>
    
  </body>
</html>
