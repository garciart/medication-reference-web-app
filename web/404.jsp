<%-- 
    Document   : 404
    Created on : Jun 26, 2017, 2:21:47 PM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@ page isErrorPage="true" contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>QMR | Error Page</title>
        <link href="${pageContext.request.contextPath}/css/desktopStyle.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <header>
            <h1>Oops! That page does not exist!</h1>
            <img src="${pageContext.request.contextPath}/error.gif" alt="Oops! That page does not exist!" />
        </header>
        <main>
        <h2>We're sorry, but that page does not exist</h2>
        <h2><a href="desktopHome.jsp" title="Home Page">Click here to return to the home page.</a></h2>
        </main>
        <footer>
            <jsp:include page="masters/desktopFooter.jsp" />
        </footer>
    </body>
</html>
