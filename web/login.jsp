<%-- 
    Document   : login
    Created on : Jun 28, 2017, 2:52:37 PM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>QMR | Login Page</title>
        <jsp:include page="masters/desktopHead.jsp" />
    </head>
    <body>
        <!-- This needs to stay here since you cannot redirect from an included file -->
        <!-- Redirect if mobile -->
        <c:set var="browser" value="${header['User-Agent']}" scope="session" />
        <c:if test = "${fn:containsIgnoreCase(browser, 'mobi')}">
            <c:redirect url="/mobileHome.jsp"/>
        </c:if>
        <noscript>
            <p class="warningText">(Javascript disabled. Please enable Javascript for full functionality)</p>
        </noscript>
        <script>
            if (!window.confirm(
                    "* * * * * * * * * * * * * * * W A R N I N G * * * * * * * * * * * * * * *\n" +
                    "This computer system is for authorized use only. Use of this system\n" +
                    "constitutes consent to monitoring at all times. If monitoring of this\n"+
                    "systems reveals violations of security regulations or unauthorized use,\n" +
                    "your priviledges will be immediately terminated. Do you wish to continue?\n" +
                    "* * * * * * * * * * * * * * * W A R N I N G * * * * * * * * * * * * * * *")) { 
                window.location.replace("${pageContext.request.contextPath}/desktopHome.jsp");
            }
        </script>
        <header>
            <a href="${pageContext.request.contextPath}/desktopHome.jsp" title="Return to Home Page"><h1>Quick Medication Reference</h1></a>
            <h2>Login Page</h2>
        </header>
        <main>
            <form action="${pageContext.request.contextPath}/loginAuthenticate.jsp" method="post">
                <h3><label for="userName">Username: </label><input id="userName" type="text" name="userName" required /></h3>
                <h3><label for="pword">Password: </label><input id="pword" type="password" name="pword" required /></h3>
                <input type="submit" />
            </form>
            <span style="color: red;">
                <c:if test="${not empty fn:escapeXml(param.errorMessage)}">
                    <h3>${fn:escapeXml(param.errorMessage)}</h3>
                </c:if>
            </span>
        </main>
        <footer>
            <jsp:include page="masters/desktopFooter.jsp" />
        </footer>
    </body>
</html>
