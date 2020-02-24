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
	//layer.msg("Hello layer");
	//====================================分页==========================================
	var initPagination = function() {
		//总的记录数
		var totalResult = ${ROLE_INFO.total};
		var pageSize = ${ROLE_INFO.pageSize};
		var currentPage = ${ROLE_INFO.pageNum-1};
		// 创建分页
		$("#Pagination").pagination(totalResult, {
			num_edge_entries: 2, //边缘页数
			num_display_entries: 3, //主体页数
			callback: pageselectCallback,
			items_per_page:pageSize, 		//每页显示1项
			current_page: currentPage,		//当前页
			prev_text:"上一页",				
			next_text:"下一页"
		});
	 }();
	//回调函数 页面点击“上一页” “下一页” “页面”的时候调用
	 function pageselectCallback(pageIndex, jq) {
			var pageNum = pageIndex+1;
			window.location.href="${APP_PATH}/role/search?pageNum="+pageNum+"&keyword=${param.keyword}";
			return false;
	}
	//====================================分页导航条= END=========================================
	//====================================开启新增的模态框=========================================
	$("#showModal").click(function(){
		//开启模态框
		$('#addModal').modal('show');
	});
	//=====================================保存新增的角色============================================
	$("#saveRole").click(function(){
		var data = $("#roleName").val();
		$.ajax({
			url:"${APP_PATH}/role/save",
			type:"POST",
			data:{
				"name":data
			},
			success:function(res){
				if(res=="success"){
					$('#addModal').modal('hide');
					window.location.href="${APP_PATH}/role/search";
				}
				if(res=="falid"){
					
				}
				
			}
		});
	});	
	
	//=====================================全选和全不选============================================
	//全选和全不选
	/* $("#summaryBox").click(function(){
		//1.获取当前的#summaryBox的勾选 状态
		//var sumStatus = this.checked;
		//2.获取.itemBox，并将#summaryBox的状态赋值给它
		//attr函数设置的属性在页面中只能使用一次，因此要使用prop属性
		$(".itemBox").prop("checked",this.checked);
		
	}); */
	
	
//封住批量和单个删除的Ajax函数
})
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
	        <form role="form" action="${APP_PATH}/admin/doAdd" method="POST">
			  <div class="form-group">
				<label for="exampleInputPassword1">添加角色</label>
				<input name="roleName" type="text" class="form-control" id="roleName" placeholder="请输入新的角色名称">
			  </div>
	        	
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button id="saveRole" type="button" class="btn btn-primary">保存</button>
		      </div>
	        </form>
	        <!-- 数据展示============================================= -->
			
	      </div>
	    </div>
	  </div>
	</div>
    <!-- 新增模态框end -->
    <div class="container-fluid">
      <div class="row">
        <%@ include file="/WEB-INF/include/sidebar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
         	<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
<form action="${APP_PATH}/role/search" method="POST" class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input name="keyword"  class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button type="submit" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button id="showModal" type="button" class="btn btn-primary" style="float:right;" >
<i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="45">序号</th>
				  <th width="30"><input type="checkbox"></th>
                  <th>名称</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
              <c:forEach items="${ROLE_INFO.list}" var="role" varStatus="code">
                <tr>
                  <td align="center">${code.count }</td>
				  <td><input type="checkbox"></td>
                  <td>${role.name }</td>
                  <td>
				      <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
				      <button type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
					  <button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>
				  </td>
                </tr>
              </c:forEach>
               
              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="6" align="center">
						<div id="Pagination" class="pagination">
											
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
