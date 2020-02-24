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
	//删除
	
	
	
	
});
//===============初始化树形菜单，自定义图标========START===================
//初始化树形菜单
function initWholeTree(){
	var setting = {	
			"view":{
				"addDiyDom": showMyIcon, //自定义图标
				"addHoverDom":addHoverDom,//鼠标放上面添加节点
				"removeHoverDom":removeHoverDom //鼠标移除删除节点
			},
	
			"data":{
				"key":{
					"url":"notExistsProperty"//不让节点进行跳转
				}
			}
	};
	/* 
		var zNodes =[
			{ id:1, pId:0, name:"父节点 1", open:true},
			{ id:11, pId:1, name:"叶子节点 1-1"},
			{ id:12, pId:1, name:"叶子节点 1-2"},
			{ id:13, pId:1, name:"叶子节点 1-3"},
			{ id:2, pId:0, name:"父节点 2", open:true},
			{ id:21, pId:2, name:"叶子节点 2-1"},
			{ id:22, pId:2, name:"叶子节点 2-2"},
			{ id:23, pId:2, name:"叶子节点 2-3"},
			{ id:3, pId:0, name:"父节点 3", open:true},
			{ id:31, pId:3, name:"叶子节点 3-1"},
			{ id:32, pId:3, name:"叶子节点 3-2"},
			{ id:33, pId:3, name:"叶子节点 3-3"}
		];
	
	*/
	$.ajax({
		url:"${APP_PATH}/menu/search",
		dataType:"json",
		success:function(response){
			var zNodes =response;
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		}
	});
}
//自定义图标,由setting.view.addDiyDom属性引用，负责显示自定义的图标
function showMyIcon(treeId,treeNode){
	//console.log(treeNode);
	var currentNodeId = treeNode.tId;        		//获取当前节点的ID
	var newClass = treeNode.icon;            		//获取新的class值用于替换
	var targetSpanId = currentNodeId + "_ico";      //在当前节点id之后附加“_ico”,得到符合目标span的id
	//将span的旧的class移除，替换成新的Class
	$("#"+targetSpanId).removeClass().addClass(newClass);
}
//===============初始化树形菜单，自定义图标========END===================

// 在鼠标移入节点范围时添加自定义控件
function addHoverDom(treeId, treeNode) {
    
    // 在执行添加前，先进行判断，如果已经添加过，就停止执行
    // 组装按钮组所在的span标签的id
    var btnGrpSpanId = treeNode.tId + "_btnGrp";
    
    var btnGrpSpanLength = $("#"+btnGrpSpanId).length;
    
    if(btnGrpSpanLength > 0) {
        return ;
    }
    
    // 由于按钮组是放在当前节点中的超链接（a标签）后面，所以先定位到a标签
    // 按id生成规则组装a标签的id
    var anchorId = treeNode.tId + "_a";
    
    // 调用已封装函数生成按钮组
    var $btnGrpSpan = generateBtnGrp(treeNode);
    
    // 在a标签后面追加按钮组
    $("#"+anchorId).after($btnGrpSpan);
    
}

// 在鼠标移出节点范围时删除自定义控件
function removeHoverDom(treeId, treeNode) {
    
    // 组装按钮组所在的span标签的id
    var btnGrpSpanId = treeNode.tId + "_btnGrp";
    
    // 删除对应的元素
    $("#"+btnGrpSpanId).remove();
}
	
	
/* 
	level为1：
		只能添加
	level为2：
		有子节点：增改
		无子节点：增改删
	level为3：
		改删，人为的不让在添加了，只能是三级
	将每个按钮的HTML的代码声明称变量
*/
//专门生成按钮组的函数
function generateBtnGrp(treeNode){
	// 获取当前节点在数据库中的id值
    // Menu实体类中的属性，都可以通过treeNode以“.属性名”的方式直接访问
    var menuId = treeNode.id
	//声明三种按钮
	var addBtn = "<a onclick='showAddModal(this)' id='"+menuId+"' class='btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' title='添加子节点'>&nbsp;&nbsp;<i class='fa fa-fw fa-plus rbg'></i></a>";
    var editBtn = "<a onclick='showEditModal(this)' id='"+menuId+"' class='btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' title='编辑节点'>&nbsp;&nbsp;<i class='fa fa-fw fa-edit rbg'></i></a>";
    var removeBtn = "<a onclick='showConfirmModal(this)' id='"+menuId+"' class='btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' title='删除节点'>&nbsp;&nbsp;<i class='fa fa-fw fa-times rbg'></i></a>";
	//获取节点ID
	var treeNodeId = treeNode.tId;
	//获取当前节点的等级
	var level = treeNode.level;
	//组装成符合所在span的id
	var btnGrpSpanId = treeNodeId + "_btnGrp";
	//生成span标签对应的jQuery对象
	var $span = $("<span id = '"+btnGrpSpanId+"'></span>");
	
	//根据level等级进行判断
	if(level == 0){//只能添加
		$span.append(addBtn);
	}
	if(level == 1){
		//看看有没有子节点
		if(treeNode.children.length>0){//增改
			$span.append(addBtn+"  "+editBtn);
		}else{//增改删
			$span.append(addBtn+"  "+editBtn+"  "+removeBtn);
		}
	}
	if(level == 2){//改删
		$span.append(editBtn+"  "+removeBtn);
	}
	return $span;
}
// =================================在点击添加按钮时执行这个函数，打开模态框并保存=======================
function showAddModal(currentBtn) {
    
    // 打开模态框
    $("#menuAddModal").modal("show");
    
    // 将当前节点的id存入全局变量
    window.menuId = currentBtn.id;//数据请求要带上
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
function showEditModal(currentBtn) {
    // 打开编辑模态框
    $("#menuEditModal").modal("show");
    
    // 将当前节点的id存入全局变量
    window.menuId = currentBtn.id;//数据请求要带上
    window.pId = currentBtn.tId;//数据请求要带上
    
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
				id:window.menuId, 
				pid:window.pId
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
function showConfirmModal(currentBtn){
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
			id:currentBtn.id
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
			                <h4 class="modal-title">尚筹网系统弹窗</h4>
			            </div>
			            <form>
			                <div class="modal-body">
			                    请输入节点名称：<input type="text" name="name" /><br /> 请输入URL地址：<input
			                        type="text" name="url" /><br /> <input type="radio" name="icon"
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
