<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%> 
<%--shiro 标签 --%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>

<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<%--不知道这里的basePath 设置没用 --%>
		<base href="<%=basePath%>"/>
		<title>照片上传</title>
	   	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link   rel="shortcut icon" href="<%=basePath%>/favicon.ico" />
		<link href="<%=basePath%>/js/common/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet"/>
		<link href="<%=basePath%>/css/common/base.css" rel="stylesheet"/>
		<script  src="<%=basePath%>/js/common/jquery/jquery1.8.3.min.js"></script>
		<script  src="<%=basePath%>/js/common/layer/layer.js"></script>
		<script  src="<%=basePath%>/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script  src="<%=basePath%>/js/shiro.demo.js"></script>	
		<script src="<%=basePath%>/js/common/jquery/jquery.form-2.82.js"></script>
		<script >
			so.init(function(){		
				so.checkBoxInit('#checkAll','[check=box]');
				<shiro:hasPermission name="/site/deleteSiteById.shtml">
				//全选
				so.id('deleteAll').on('click',function(){
					var checkeds = $('[check=box]:checked');
					if(!checkeds.length){
						return layer.msg('请选择要删除的选项。',so.default),!0;
					}
					var array = [];
					checkeds.each(function(){
						array.push(this.value);
					});
					return deleteById(array);
				});
				</shiro:hasPermission>
				});
			<shiro:hasPermission name="/site/deleteSiteById.shtml">
			<%--根据ID数组删除角色--%>
			function deleteById(ids){
				var index = layer.confirm("确定这"+ ids.length +"个权限？",function(){
					var load = layer.load();
					$.post('<%=basePath%>/site/deleteSiteById.shtml',{ids:ids.join(',')},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg(result.resultMsg);
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
					layer.close(index);
				});
			}
			</shiro:hasPermission>
			<shiro:hasPermission name="/site/addSite.shtml">
			<%--添加权限--%>
			function addPermission(){
				var name = $('#name').val(),
					url  = $('#url').val();
				if($.trim(name) == ''){
					return layer.msg('权限名称不能为空。',so.default),!1;
				}
				if($.trim(url) == ''){
					return layer.msg('权限Url不能为空。',so.default),!1;
				}
				<%--loding--%>
				var load = layer.load();
				$.post('<%=basePath%>/site/addSite.shtml',{name:name,url:url},function(result){
					layer.close(load);
					if(result && result.status != 200){
						return layer.msg(result.message,so.default),!1;
					}
					layer.msg('添加成功。');
					setTimeout(function(){
						$('#formId').submit();
					},1000);
				},'json');
			}
			</shiro:hasPermission>		
		</script>			
	</head>
	<body data-target="#one" data-spy="scroll">
		<%--引入头部<@_top.top 3/>--%>
		<jsp:include page="../common/config/top.jsp" flush="true">
		<jsp:param name="index" value="4"/>
		
		</jsp:include>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<%--引入左侧菜单--%>
				<jsp:include page="../common/config/left.jsp" flush="true">
				<jsp:param name="leftindex" value="1"/>
				
				</jsp:include>					
				<div class="col-md-10">
					<h2>工地列表</h2>
					<hr>
					<form method="post" action="" id="formId" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent}" 
					        			name="findContent" id="findContent" placeholder="输入工地名称">
					      </div>
					     <span class=""> <%--pull-right --%>
				         	<button type="submit" class="btn btn-primary">查询</button>
				         	<shiro:hasPermission name="/site/addSite.shtml">
				         		<a class="btn btn-success" onclick="$('#addPermission').modal();">增加工地</a>
				         	</shiro:hasPermission>
				         	<shiro:hasPermission name="/site/deleteSiteById.shtml">
				         		<button type="button" id="deleteAll" class="btn  btn-danger">Delete</button>
				         	</shiro:hasPermission>
				         </span>    
				        </div>
					<hr>
					<table class="table table-bordered">
						<tr>
							<th><input type="checkbox" id="checkAll"/></th>
							<th>权限名称</th>
							<th>角色类型</th>
							<th>操作</th>
						</tr>
						<c:choose>
							<c:when test="${page != null && fn:length(page.list) gt 0}">
								<c:forEach items="${page.list}" var="it">
								<tr>
									<td><input value="${it.id}" check='box' type="checkbox" /></td>
									<td>${it.name}</td>
									<td>${it.url}</td>
									<td>
										<shiro:hasPermission name="/site/deleteSiteById.shtml">
											<i class="glyphicon glyphicon-remove"></i><a href="javascript:deleteById([${it.id}]);">删除</a>
										</shiro:hasPermission>
									</td>
								</tr>								
								</c:forEach>
							
							</c:when>
							<c:otherwise>
							<tr>
								<td class="text-center danger" colspan="4">没有找到角色</td>
							</tr>							
							</c:otherwise>
						</c:choose>					
					</table>
					<c:if test="${page != null && fn:length(page.list) gt 0}">
						<div class="pagination pull-right">
							${page.pageHtml}
						</div>
					</c:if>
					</form>
				</div>
			</div>
			
			<shiro:hasPermission name="/site/addSite.shtml">
			<%--弹框--%>
			<div class="modal fade" id="addPermission" tabindex="-1" role="dialog" aria-labelledby="addPermissionLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="addPermissionLabel">添加权限</h4>
			      </div>
			      <div class="modal-body">
			        <form id="boxRoleForm">
			          <div class="form-group">
			            <label for="recipient-name" class="control-label">权限名称:</label>
			            <input type="text" class="form-control" name="name" id="name" placeholder="请输入权限名称"/>
			          </div>
			          <div class="form-group">
			            <label for="recipient-name" class="control-label">权限URL地址:</label>
			            <input type="text" class="form-control" id="url" name="url"  placeholder="请输入权限URL地址">
			          </div>
			        </form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			        <button type="button" onclick="addPermission();" class="btn btn-primary">Save</button>
			      </div>
			    </div>
			  </div>
			</div>
			<%--/弹框--%>
			</shiro:hasPermission>			
		</div>
	</body>  
</html>  