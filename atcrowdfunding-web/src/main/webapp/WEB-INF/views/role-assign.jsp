<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <%@ include file="/WEB-INF/include/head.jsp"%>
    <link rel="stylesheet" href="${APP_PATH}/static/ztree/zTreeStyle.css">
    <script src="${APP_PATH}/static/ztree/jquery.ztree.all-3.5.min.js"></script>
    <script type="text/javascript">
        //用户的ID通过请求参数带到该页面
        window.adminId = "${param.id}";//用户的id
        $(function () {
            initWholeTree();
        })
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
                        url:"notExistsProperty",//不让节点进行跳转
                        name:"title"

                    },

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

                },
                check: {
                    enable: true
                },
            };

            $.ajax({
                url:"${APP_PATH}/jurisdiction/search",
                dataType:"json",
                success:function(response){
                    var zNodes =response;
                    $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                    //zTree的方法支持展开各个节点
                    var treeObj = $.fn.zTree.getZTreeObj("treeDemo");//容器的id名
                    treeObj.expandAll(true);
                    var nodes = treeObj.getCheckedNodes(true);
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
            <ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">分配权限</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 权限分配列表 <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
