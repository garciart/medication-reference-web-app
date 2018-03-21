<%-- 
    Document   : updateDatabase
    Created on : Jul 4, 2017, 10:04:49 PM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quick EMR | Admin Menu</title>
        <jsp:include page="masters/adminHead.jsp" />
    </head>
    <body>
        <!-- This needs to stay here since you cannot redirect from an included file -->
        <!-- Redirect if mobile -->
        <c:set var="browser" value="${header['User-Agent']}" scope="session" />
        <c:if test = "${fn:containsIgnoreCase(browser, 'mobi')}">
            <c:redirect url="/mobileHome.jsp"/>
        </c:if>
        <!-- Redirect if not authenticated -->
        <c:if test="${sessionScope['loggedIn'] != true && sessionScope['role'] != 'Administrator'}">
            <c:redirect url="/login.jsp" />
        </c:if>
        <noscript>
            <p class="warningText">(Javascript disabled. Please enable Javascript for full functionality)</p>
        </noscript>
        <header>
            <a href="${pageContext.request.contextPath}/desktopHome.jsp" title="Return to Home Page"><h1>Quick Electronic Medical Reference</h1></a>
            <h2>Update Database</h2>
        </header>
        <main style="text-align: left; width: 100%;">
            <form action="adminMenu.jsp" method="post" style="display: inline;">
                <input type="submit" value="Return to Administration Menu" />
            </form>&nbsp;or&nbsp;
            <form action="logout.jsp" method="post" style="display: inline;">
                <input type="submit" value="Log Out" />
            </form>
            <br><br>
            <hr>
            <h3>Choose the database to upload, then upload the file:</h3>
            <form action="adminUpdateDatabase.jsp" method="post" enctype="multipart/form-data">
                <p><input type="file" name="file" size="50" /></p>
                <p><input type="submit" value="Upload File" onclick="return confirm('Are you sure you want to replace the database?');" /></p>
            </form>
            <span style="color: red;">
                <h3>Invalid database</h3>
            </span>
        </main>
        <footer>
            <jsp:include page="masters/adminFooter.jsp" />
        </footer>
    </body>
</html>
