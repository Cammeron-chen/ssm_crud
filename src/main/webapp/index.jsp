<%--
  Created by IntelliJ IDEA.
  User: JackPi
  Date: 2019/1/28 0028
  Time: 21:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<jsp:forward page="/emp"></jsp:forward>
<html>
<head>
    <title>首页</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <%--引入bootstarp页面--%>
    <link type="text/css" href="static/bootstrap-3.3.7-dist/css/bootstrap.css">
    <%--引入jquery--%>
    <script type="text/javascript" src="static/js/jquery-3.3.1.min.js" ></script>
    <script type="text/javascript" src="static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>
<button class="btn btn-success"> ok</button>

</body>
</html>

