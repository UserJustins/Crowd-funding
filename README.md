# Crowd-funding
## 一、项目进度条
### 1.权限管理用户模块已经完成
## 二、知识点
### 1.分页使用mybatis的PageHelper插件
### 2.前端的分页导航
### 3.页面复选框全选全不选以及批量删除
```js
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<%@ include file="/WEB-INF/include/head.jsp"%>

<script type="text/javascript">
	$(function(){

		//=====================================全选和全不选============================================
		//全选和全不选
		$("#summaryBox").click(function(){
			//1.获取当前的#summaryBox的勾选 状态
			//var sumStatus = this.checked;
			//2.获取.itemBox，并将#summaryBox的状态赋值给它
			//attr函数设置的属性在页面中只能使用一次，因此要使用prop属性
			$(".itemBox").prop("checked",this.checked);

		});

		//======================================批量删除===========================================
		//批量删除的操作$("#batchRemove").click
		$("#batchRemove").click(function(){
			var adminIds = [];//勾选记录的ID
			var loginAccts = [];//勾选记录的账号
			//获取被勾选记录的ID 选择器 input标签下type为“checkbox'并且name属性等于CheckBoxName，还要被选中
			$("input:checkbox[name=checkBoxName]:checked").each(function(){
				//现在的this是一个DOM，需要转换成jQuery
				adminIds.push($(this).val());
				//获取勾选的账户名称
				/*
                    <td>
                        <input class="itemBox" type="checkbox" name="checkBoxName" value="<%--${admin.id}--%>">
					</td>
					<td><%--${admin.loginAcct}--%></td>

				*/
				var loginAcct = $(this)			//input标签
						.parent("td")	//input的父级
						.next()
						.text();
				loginAccts.push(loginAcct);
			});
			//检查有没有勾选复选框就点击了批量删除
			if(adminIds.length==0){
				alert("请选择至少一条数据");
				return;
			}
			//询问用户是否要真的删除
			var confirmResult = confirm("你确定要删除[ "+loginAccts+" ]的信息吗？");
			//用户点击取消就结束函数
			if(!confirmResult){
				return;
			}
			//发送ajax请求
			removeAjax(adminIds);
		});

	})






	//=========================================单条记录删除=======================================================
	function singleRemove(id){
		alert(id)
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
			url:"${APP_PATH}/admin/remove",
			type:"POST",
			data: {
				"ids":IdArray
			},
			success:function(response){
				console.log(response);
				if(response="true"){
					alert("删除成功");
				}
				window.location.href = "${APP_PATH}/admin/keySearch";
			},
			error:function(response){
				console.log(response);
			}
		});
	}
</script>
</head>

<body>
	<%@ include file="/WEB-INF/include/navigation.jsp"%>

	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/include/sidebar.jsp"%>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="glyphicon glyphicon-th"></i> 数据列表
						</h3>
					</div>
					<div class="panel-body">
						<form action="${APP_PATH}/admin/keySearch" method="POST" class="form-inline" role="form" style="float: left;">
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input name="keyword" class="form-control has-success" type="text"
										placeholder="请输入查询条件" value="${param.keyword}">
								</div>
							</div>
							<button type="submit" class="btn btn-warning">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<button id="batchRemove" type="button" class="btn btn-danger"
							style="float: right; margin-left: 10px;">
							<i class=" glyphicon glyphicon-remove"></i> 批量删除
						</button>
						<button type="button" class="btn btn-primary"
							style="float: right;" onclick="window.location.href='${APP_PATH}/admin/add'">
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>

									<tr>
										<th width="45">序号</th>
										<th width="30"><input id="summaryBox"type="checkbox"></th>
										<th>账号</th>
										<th>名称</th>
										<th>邮箱地址</th>
										<th width="100">操作</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach items="${PAGE_INFO_KEY.list}" var="admin"
										varStatus="myCode">

										<tr>
											<td>${myCode.count}</td>
											<td><input class="itemBox" type="checkbox" name="checkBoxName" value="${admin.id}"></td>
											<td>${admin.loginacct}</td>
											<td>${admin.username}</td>
											<td>${admin.email}</td>
											<td>
												<button type="button" class="btn btn-success btn-xs">
													<i class=" glyphicon glyphicon-check"></i>
												</button>
												<a  class="btn btn-primary btn-xs"
													href="${APP_PATH }/admin/edit?id=${admin.id}&pageNum=${PAGE_INFO_KEY.pageNum}">
													<i class=" glyphicon glyphicon-pencil"></i>
												</a>
												<button type="button" class="btn btn-danger btn-xs" onclick="singleRemove(${admin.id})">
													<i class=" glyphicon glyphicon-remove"></i>
												</button>
											</td>
										</tr>
									</c:forEach>


								</tbody>
								<%--
									分页导航条
									分页的每一个按钮带keyword属性：&keyword=${param.keyword}
									因为分页按钮点击时，还需要回显查询框中的关键字
								--%>
								<tfoot>
									<tr>
										<td colspan="6" align="center">
											<div id="Pagination">
												<nav aria-label="Page navigation">
													<ul class="pagination">
														<li>
															<a href="${APP_PATH}/admin/keySearch?pageNum=1&keyword=${param.keyword}"><span>首页</span></a>
														</li>
														<%--上一页按钮控制--%>
														<c:choose>
															<%--如果是上一页--%>
															<c:when test="${PAGE_INFO_KEY.isFirstPage}">
																<li class="disabled"><span>上一页</span></li>
															</c:when>
															<c:when test="${!PAGE_INFO_KEY.isFirstPage}">
																<li>
																	<a href="${APP_PATH}/admin/keySearch?pageNum=${PAGE_INFO_KEY.prePage}&keyword=${param.keyword}">上一页</a>
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
																<a href="${APP_PATH}/admin/keySearch?pageNum=${num}&keyword=${param.keyword}">${num}</a>
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
																	<a href="${APP_PATH}/admin/keySearch?pageNum=${PAGE_INFO_KEY.nextPage}&keyword=${param.keyword}">下一页</a>
																</li>
															</c:when>
														</c:choose>
														<li>
															<a href="${APP_PATH}/admin/keySearch?pageNum=${PAGE_INFO_KEY.lastPage}&keyword=${param.keyword}"><span>末页</span></a>
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

```
## 三.常见问题
## 1.SpringMVC可以接受数组类型的参数
## 2.Mapper接口数组类型的参数最好使用@Param标注一下
## 3.试图用BootStrap的模态框做删除的提示框，发现很难获取到table中的数据
