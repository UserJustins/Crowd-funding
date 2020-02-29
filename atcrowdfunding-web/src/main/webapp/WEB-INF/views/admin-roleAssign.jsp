<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <%@ include file="/WEB-INF/include/head.jsp"%>

<script type="text/javascript">
    //用户的ID通过请求参数带到该页面
    window.adminId = "${param.id}";//用户的id
$(function () {

    //添加角色
    $("#leftToRightBtn").click(function(){
        var assignRole = $("#leftAssignRoleList option:selected");
        if (assignRole.length == 0){
            layer.msg("请在左边  {未分配角色列表}  选择要添加的角色",{icon:5,time:3000})
            return false;
        }
        /*  给后台传参roleID：数组的形式
            1、获取即将从左边未分配角色转到右边已分配的角色的value值，也就是ID封装成Array返回
            2、将AdminId追加
            3、将roleID传给后台，
                规则：数组中最后一个是AdminId，其余都是此次添加的角色ID
                ["3", "4", "5", "1" ]
         */
        //1、获取此次分配角色的id
        var roleID = assignRole.map(function(){
            return $(this).val();
        }).get();
        //2、追加AdminId
        roleID.push(adminId);

        //将左边选中的值追加到右边
        $("#rightAssignRoleList").append(assignRole);

        $.ajax({
            url:"${APP_PATH}/admin/assignRole",
            type:"POST",
            data: {
                "ids":roleID
            },
            success:function(response){

                if(response=="success"){
                    layer.msg("分配成功",{icon:1,time:3000})
                }

            }
        });


    });
    //撤销角色
    $("#rightToLeftBtn").click(function(){
        var deleteRole = $("#rightAssignRoleList option:selected");
        if (deleteRole.length == 0){
            layer.msg("请在右边   {已分配角色列表}  选择要删除的角色",{icon:5,time:3000})
            return false;
        }
        //同理
        var roleID = deleteRole.map(function(){
            return $(this).val();
        }).get();
        //2、追加AdminId
        roleID.push(adminId);
        $("#leftAssignRoleList").append(deleteRole);

        $.ajax({
            url:"${APP_PATH}/admin/delAssignRole",
            type:"POST",
            data: {
                "ids":roleID
            },
            success:function(response){

                if(response=="success"){
                    layer.msg("撤销成功",{icon:1,time:3000})
                }

            }
        });



    });
})

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
                <li class="active">分配角色</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-body">
                    <form role="form" class="form-inline">
                        <div class="form-group">
                            <label >未分配角色列表</label><br>

                            <select id="leftAssignRoleList" class="form-control" multiple size="10" style="width:300px;overflow-y:auto;">
                                <c:forEach items="${ADMIN_NOT_ASSIGN_ROLE}" var="notAssign">
                                    <option value="${notAssign.id}">${notAssign.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <ul>
                                <li id="leftToRightBtn" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                                <br>
                                <li id="rightToLeftBtn" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                            </ul>
                        </div>
                        <div class="form-group" style="margin-left:40px;">
                            <label >已分配角色列表</label><br>

                            <select id="rightAssignRoleList" class="form-control" multiple size="10" style="width:300px;overflow-y:auto;">
                                <c:forEach items="${ADMIN_IS_ASSIGN_ROLE}" var="isAssign">
                                    <option value="${isAssign.id}">${isAssign.name}</option>
                                </c:forEach>

                            </select>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
