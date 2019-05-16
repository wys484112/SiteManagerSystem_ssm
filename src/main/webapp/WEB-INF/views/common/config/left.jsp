<%@ page pageEncoding="utf-8"%>
<%--shiro 标签 --%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
 	String test=request.getParameter("leftindex");
 %> 

<div id="one" class="col-md-2">
	<ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">					
	  
	  <shiro:hasPermission name="/site/index.shtml">
	  <li class="${param.leftindex == 1 ? "active" : " " }  dropdown">
	      <a href="<%=basePath%>/site/index.shtml">
	    	 <i class="glyphicon glyphicon-chevron-right"></i>工地列表
	      </a>
	  </li>
	  </shiro:hasPermission>
	  <shiro:hasPermission name="/site/allocation.shtml">
	  <li class="${param.leftindex == 2 ? "active" : " " }  dropdown">
	      <a href="<%=basePath%>/site/allocation.shtml">
	    	 <i class="glyphicon glyphicon-chevron-right"></i>工地分配
	      </a>
	  </li>
	  </shiro:hasPermission>		
	  <li class="${param.leftindex == 3 ? "active" : " " }  dropdown">
	      <a href="<%=basePath%>/site/fileupload.shtml">
	    	 <i class="glyphicon glyphicon-chevron-right"></i>工地图片上传
	      </a>
	  </li>			  
	</ul>
</div>
