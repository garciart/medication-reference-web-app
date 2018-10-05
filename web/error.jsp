<%-- 
    Document   : error
    Created on : Jun 25, 2017, 6:00:50 PM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@ page isErrorPage="true" contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>QMR | Error Page</title>
        <jsp:include page="masters/desktopHead.jsp" />
    </head>
    <body>
        <header>
            <h1>Oops! Something went wrong!</h1>
            <img src="${pageContext.request.contextPath}/error.gif" alt="Oops! Something went wrong!" />
        </header>
        <main>
            <h2>We're sorry, but the following error has occurred:</h2>
            <h2 class="errorText">${pageContext.exception.getMessage()}</h2>
            <jsp:useBean id="utilities" class="com.quickmeds.models.Utilities">
                <jsp:setProperty name="utilities" property="*" />
            </jsp:useBean>
            ${utilities.logEvent(pageContext.exception)}
            <h2>We've been notified and we're working on it. Meantime, if you have any questions, contact us at <a href="mailto:rgarcia92@student.umuc.edu">rgarcia92@student.umuc.edu</a>.</h2>
        </main>
        <footer>
            <jsp:include page="masters/desktopFooter.jsp" />
        </footer>
    </body>
</html>
