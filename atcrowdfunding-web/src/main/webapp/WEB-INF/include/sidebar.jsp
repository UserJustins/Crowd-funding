<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="col-sm-3 col-md-2 sidebar">
	<div class="tree">
		<ul style="padding-left: 0px;" class="list-group">
			<c:forEach items="${sessionScope.ARRT_MENU_IN_SESSION}" var="parent">
				<li class="list-group-item tree-closed">
				<span><i class="${parent.icon}"></i> ${parent.name}
					<c:if test="${not empty parent.children}">
						<span class="badge" style="float: right">${parent.children.size()}</span>
					</c:if>
				</span>
				<c:if test="${not empty parent.children}">
					<ul style="margin-top: 10px; display: none;width: 300px">
						<c:forEach items="${parent.children}" var="children">
							<li style="height: 30px;"><a href="${APP_PATH}/${children.url}"><i
									class="${children.icon}"></i> ${children.name}</a></li>
						</c:forEach>
					</ul>
				</c:if>
				</li>





			</c:forEach>




		</ul>
	</div>
</div>