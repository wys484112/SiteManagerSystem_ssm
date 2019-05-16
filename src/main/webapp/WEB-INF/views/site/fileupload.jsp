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
				var load;
				so.id('upLoadSubmit').ajaxForm({
			    	success:function (result){
			    		layer.close(load);
			    		if(result && result.status != 200){
			    			return layer.msg(result.message,function(){}),!1;
			    		}else{
				    		layer.msg('操作成功！');
				    		$("form :file").val('');
			    		}
			    	},
			    	beforeSubmit:function(){
			    		//判断参数	
			    		load = layer.load('正在提交！！！');
			    	},
			    	dataType:"json",
			    	clearForm:false
				});
				
			});
		
		</script>			
	</head>
<body>  
    <center>  
        <form  action="${pageContext.request.contextPath}/site/threefile.shtml" method="post"  
            enctype="multipart/form-data" id="upLoadSubmit">  
            <input type="file" name="file" /><br /> 
            <input type="file" name="file" /><br /> 
            <input type="file" name="file" /><br /> 
            <input type="submit" value="上传" />  
        </form>  
        <h5>上传结果：</h5>  
  
        <c:forEach items="${fileList}" var="imagename">  
                <img alt="上传结果：" src="${imagename}" /> <br/>  
        </c:forEach>  
        <img alt="上传结果：" src="E:\upload\源文件.png" /> <br/>  
        
    </center>  
</body>  
</html>  