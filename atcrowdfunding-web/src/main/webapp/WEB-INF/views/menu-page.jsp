<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
 <head>
<%@ include file="/WEB-INF/include/head.jsp" %>
<link rel="stylesheet" href="${APP_PATH}/static/ztree/zTreeStyle.css">
<script src="${APP_PATH}/static/ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	initWholeTree();
	//保存
	saveMenu();
	//更新
	editMenu();



	
	
});
//===============初始化树形菜单========START===================
//初始化树形菜单
/**
 *
 * 1.简单的数据模式：后台直接给自关联的全部数据，不需要封装子节点
 * 2.页面添加一个数据表之外的根节点名称
 * 3.页面默认打开所有的节点
 * 4.添加节点的图标addDiyDom
 *
 * */
function initWholeTree(){
	var setting = {
		data: {
			simpleData: {
				enable: true,//开启简单模式，后台不需要封装子节点，给前台全表数据即可
				idKey: "id",
				pIdKey: "pid",
			},
			key:{
				//很重要，跳转的话，点击之后页面跳转了按钮组就出不来
				"url":"notExistsProperty"//不让节点进行跳转
			}
		},
		view: {
			addDiyDom: function(treeId, treeNode){
				//treeNode:setting.treeId + "_" + 内部计数
				//将id="treeDemo_序号_icon"的标签的class属性删除
				$("#"+treeNode.tId+"_ico").removeClass();
				//在id="treeDemo_序号_span"的标签前添加一个<span>标签，属性class值为treeNode.icon
				//treeNode.icon就是TMenu中每个节点都封装了一个icon属性
				$("#"+treeNode.tId+"_span").before("<span class='"+treeNode.icon+"'></span>")
			},
			addHoverDom: function(treeId, treeNode){
				var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
				if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
				var s = '<span id="btnGroup'+treeNode.tId+'">';
				if ( treeNode.level == 0 ) {
					s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="showAddModal('+treeNode.id+');" ><i class="fa fa-fw fa-plus rbg "></i></a>';
				} else if ( treeNode.level == 1 ) {
					s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="showEditModal('+treeNode.id+')"><i class="fa fa-fw fa-edit rbg "></i></a>';
					if (treeNode.children.length == 0) {
						s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="showDelConfirmModal('+treeNode.id+')" ><i class="fa fa-fw fa-times rbg "></i></a>';
					}
					s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="showAddModal('+treeNode.id+');"><i class="fa fa-fw fa-plus rbg "></i></a>';
				} else if ( treeNode.level == 2 ) {
					s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="showEditModal('+treeNode.id+')"><i class="fa fa-fw fa-edit rbg "></i></a>';
					s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="showDelConfirmModal('+treeNode.id+')"><i class="fa fa-fw fa-times rbg "></i></a>';
				}

				s += '</span>';
				aObj.after(s);
			},
			removeHoverDom: function(treeId, treeNode){
				$("#btnGroup"+treeNode.tId).unbind().remove();
			}

		},
	};

	$.ajax({
		url:"${APP_PATH}/menu/search",
		dataType:"json",
		success:function(response){
			var zNodes =response;
			//添加一个数据表之外的最根节点
			zNodes.push({id:'0',name:'系统菜单ROOT',icon:'glyphicon glyphicon-list'})
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			//zTree的方法支持展开各个节点
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");//容器的id名
			treeObj.expandAll(true);
		}
	});
}



// =================================在点击添加按钮时执行这个函数，打开模态框并保存=======================
function showAddModal(id) {
    
    // 打开模态框
    $("#menuAddModal").modal("show");

    // 将当前节点的id存入全局变量
    window.menuId = id;//数据请求要带上
}
function saveMenu(){
	$("#menuAddBtn").click(function(){
		//alert("nihao");
		//获取要提交的数据
		var name = $("#menuAddModal [name='name']").val();
		var url = $("#menuAddModal [name='url']").val();
		var icon = $("#menuAddModal [name='icon']:checked").val();
		if(name ==null || name ==""){
			layer.msg("请填写菜单的名称");
			return;
		}
		if(url ==null || url ==""){
			layer.msg("请填写菜单对应的url地址")
			return;
		}
		if(icon==undefined){
			layer.msg("请选择图标")
			return;
		}
		//异步的发送请求
		$.ajax({
			url:"${APP_PATH}/menu/save",
			type:"POST",
			data:{
				name:name,
				url:url,
				icon:icon,
				pid:window.menuId //在加载模态框的时候赋值给了全员变量
			},
			success:function(response){
				console.log(response);
				if(response == "success"){
					layer.msg("保存成功")
					initWholeTree();
				}
			}
			
		});
		//关闭模态框
		$("#menuAddModal").modal("hide");
	});
}

//=================================在点击添加按钮时执行这个函数，打开模态框并保存  END=======================
//=================================在点击编辑按钮时执行这个函数，打开模态框并更新  START=======================
function showEditModal(id) {
    // 打开编辑模态框
    $("#menuEditModal").modal("show");
    
    // 将当前节点的id存入全局变量
    window.menuId = id;//数据请求要带上

    $.ajax({
		url:"${APP_PATH}/menu/get",
		type:"POST",
		data:{
			id:menuId 
		},
		success:function(resp){
			//返回一个Menu
			var name = resp.name;
			var url = resp.url;
			var icon = resp.icon;
			//回显数据
			$("#menuEditModal [name='name']").val(name);
			$("#menuEditModal [name='url']").val(url);
			$("#menuEditModal [name='icon'][value='"+icon+"']").attr("checked",true);
		}
		
	});
}
function editMenu(){
	$("#menuEditBtn").click(function(){
		//获取要提交的数据
		var name = $("#menuEditModal [name='name']").val();
		var url = $("#menuEditModal [name='url']").val();
		var icon = $("#menuEditModal [name='icon']:checked").val();
		if(name ==null || name ==""){
			layer.msg("更新菜单的名称必填");
			return;
		}
		if(url ==null || url ==""){
			layer.msg("更新菜单对应的url地址必填")
			return;
		}
		
		$.ajax({
			url:"${APP_PATH}/menu/modify",
			type:"POST",
			data:{
				name:name,
				url:url,
				icon:icon,
				id:window.menuId

			},
			success:function(response){
				console.log(response);
				if(response == "success"){
					layer.msg("更新成功")
					initWholeTree();
				}
			}
			
		});
		//关闭模态框
		$("#menuEditModal").modal("hide");
	});
}
//=================================在点击编辑按钮时执行这个函数，打开模态框并更新  END=======================
function showDelConfirmModal(id){
	//询问用户是否要真的删除
	var confirmResult = confirm("你确定要删除的信息吗？");
	//用户点击取消就结束函数
	if(!confirmResult){
		return;
	}
	$.ajax({
		url:"${APP_PATH}/menu/remove",
		type:"POST",
		data:{
			id:id
		},
		success:function(response){
			console.log(response);
			if(response == "success"){
				layer.msg("删除成功")
				initWholeTree();
			}
		}
		
	});
}
</script>
</head>

  <body>
<%@ include file="/WEB-INF/include/navigation.jsp" %>
    
    <div class="container-fluid">
      <div class="row">
        <%@ include file="/WEB-INF/include/sidebar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
         	<div class="panel panel-default">
              <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 权限菜单列表 <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
                  <ul id="treeDemo" class="ztree"></ul>
			  </div>
			</div>
			<!-- 增加模态框 START-->
			<div id="menuAddModal" class="modal fade in" tabindex="-1" role="dialog">
			    <div class="modal-dialog" role="document">
			        <div class="modal-content">
			            <div class="modal-header">
			                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			                    <span aria-hidden="true">×</span>
			                </button>
			                <h4 class="modal-title">尚筹网系统弹窗</h4>
			            </div>
			            <form>
			                <div class="modal-body">
			                        请输入节点名称：<input type="text" name="name"><br>
			                        请输入URL地址：<input type="text" name="url"><br>
								<input type="radio" name="icon" value="glyphicon glyphicon-th-list">           <i class="glyphicon glyphicon-th-list"></i>
								<input type="radio" name="icon" value="glyphicon glyphicon-dashboard">         <i class="glyphicon glyphicon-dashboard"></i>
								<input type="radio" name="icon" value="glyphicon glyphicon glyphicon-tasks">   <i class="glyphicon glyphicon glyphicon-tasks"></i>
								<input type="radio" name="icon" value="glyphicon glyphicon-user">              <i class="glyphicon glyphicon-user"></i>
								<input type="radio" name="icon" value="glyphicon glyphicon-king">              <i class="glyphicon glyphicon-king"></i>
								<input type="radio" name="icon" value="glyphicon glyphicon-lock">              <i class="glyphicon glyphicon-lock"></i>
								<input type="radio" name="icon" value="glyphicon glyphicon-ok">                <i class="glyphicon glyphicon-ok"></i>
								<input type="radio" name="icon" value="glyphicon glyphicon-check">             <i class="glyphicon glyphicon-check"></i>
								<input type="radio" name="icon" value="glyphicon glyphicon-th-large">          <i class="glyphicon glyphicon-th-large"></i><br>
								<input type="radio" name="icon" value="glyphicon glyphicon-picture">           <i class="glyphicon glyphicon-picture"></i>
								<input type="radio" name="icon" value="glyphicon glyphicon-equalizer">         <i class="glyphicon glyphicon-equalizer"></i>
								<input type="radio" name="icon" value="glyphicon glyphicon-random">            <i class="glyphicon glyphicon-random"></i>
								<input type="radio" name="icon" value="glyphicon glyphicon-hdd">               <i class="glyphicon glyphicon-hdd"></i>
								<input type="radio" name="icon" value="glyphicon glyphicon-comment">           <i class="glyphicon glyphicon-comment"></i>
								<input type="radio" name="icon" value="glyphicon glyphicon-list">              <i class="glyphicon glyphicon-list"></i>
								<input type="radio" name="icon" value="glyphicon glyphicon-tags">              <i class="glyphicon glyphicon-tags"></i>
								<input type="radio" name="icon" value="glyphicon glyphicon-list-alt">          <i class="glyphicon glyphicon-list-alt"></i>
								<br/>
			                </div>
			                <div class="modal-footer">
			                    <button id="menuAddBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 保存</button>
			                    <button id="menuAddResetBtn" type="reset" class="btn btn-primary"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
			                </div>
			            </form>
			        </div>
			    </div>
			</div>
			<!-- 增加模态框 END-->
			<!-- 更新模态框 END-->
			<div id="menuEditModal" class="modal fade" tabindex="-1" role="dialog">
			    <div class="modal-dialog" role="document">
			        <div class="modal-content">
			            <div class="modal-header">
			                <button type="button" class="close" data-dismiss="modal"
			                    aria-label="Close">
			                    <span aria-hidden="true">&times;</span>
			                </button>
			                <h4 class="modal-title">系统菜单修改弹窗</h4>
			            </div>
			            <form>
			                <div class="modal-body">
			                    请输入节点名称：<input type="text" name="name" /><br /> 请输入URL地址：<input
			                        type="text" name="url" /><br />
								<input type="radio" name="icon"
									   value="glyphicon glyphicon-th-list" /> <i
									class="glyphicon glyphicon-th-list"></i> <input type="radio"
																					name="icon" value="glyphicon glyphicon-dashboard" /> <i
									class="glyphicon glyphicon-dashboard"></i> <input type="radio"
																					  name="icon" value="glyphicon glyphicon glyphicon-tasks" /> <i
									class="glyphicon glyphicon glyphicon-tasks"></i> <input
									type="radio" name="icon" value="glyphicon glyphicon-user" /> <i
									class="glyphicon glyphicon-user"></i> <input type="radio"
																				 name="icon" value="glyphicon glyphicon-king" /> <i
									class="glyphicon glyphicon-king"></i> <input type="radio"
																				 name="icon" value="glyphicon glyphicon-lock" /> <i
									class="glyphicon glyphicon-lock"></i> <input type="radio"
																				 name="icon" value="glyphicon glyphicon-ok" /> <i
									class="glyphicon glyphicon-ok"></i> <input type="radio"
																			   name="icon" value="glyphicon glyphicon-check" /> <i
									class="glyphicon glyphicon-check"></i> <input type="radio"
																				  name="icon" value="glyphicon glyphicon-th-large" /> <i
									class="glyphicon glyphicon-th-large"></i><br /> <input
									type="radio" name="icon" value="glyphicon glyphicon-picture" /> <i
									class="glyphicon glyphicon-picture"></i> <input type="radio"
																					name="icon" value="glyphicon glyphicon-equalizer" /> <i
									class="glyphicon glyphicon-equalizer"></i> <input type="radio"
																					  name="icon" value="glyphicon glyphicon-random" /> <i
									class="glyphicon glyphicon-random"></i> <input type="radio"
																				   name="icon" value="glyphicon glyphicon-hdd" /> <i
									class="glyphicon glyphicon-hdd"></i> <input type="radio"
																				name="icon" value="glyphicon glyphicon-comment" /> <i
									class="glyphicon glyphicon-comment"></i> <input type="radio"
																					name="icon" value="glyphicon glyphicon-list" /> <i
									class="glyphicon glyphicon-list"></i> <input type="radio"
																				 name="icon" value="glyphicon glyphicon-tags" /> <i
									class="glyphicon glyphicon-tags"></i> <input type="radio"
																				 name="icon" value="glyphicon glyphicon-list-alt" /> <i
									class="glyphicon glyphicon-list-alt"></i> <br />

			                </div>
			                <div class="modal-footer">
			                    <button id="menuEditBtn" type="button" class="btn btn-success">
			                        <i class="glyphicon glyphicon-refresh"></i> 更新
			                    </button>
			                </div>
			            </form>
			        </div>
			    </div>
			</div>
			<!-- 更新模态框 END-->
			
			
        </div>
      </div>
    </div>
    
  </body>
</html>
