<%-- 
    Document   : adminEditProfile
    Created on : Jul 4, 2017, 5:27:15 PM
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
        <c:if test="${sessionScope['loggedIn'] != true}">
            <c:redirect url="/login.jsp" />
        </c:if>
        <noscript>
            <p class="warningText">(Javascript disabled. Please enable Javascript for full functionality)</p>
        </noscript>
        <header>
            <a href="${pageContext.request.contextPath}/desktopHome.jsp" title="Return to Home Page"><h1>Quick Electronic Medical Reference</h1></a>
            <h2>View and Edit Profile</h2>
        </header>
        <main>
            <c:catch var="catchException">
            <h2>Welcome, ${sessionScope['userName']}!</h2>
            <div style="text-align: left; width: 100%;">
                <form action="adminMenu.jsp" method="post" style="display: inline;">
                    <input type="submit" value="Return to Administration Menu" />
                </form>&nbsp;or&nbsp;
                <form action="logout.jsp" method="post" style="display: inline;">
                    <input type="submit" value="Log Out" />
                </form>
                <br><br>
                <hr>
                <h2>User Information:</h2>
                <jsp:useBean id="dataAccess" class="com.quickemr.models.DataAccess">
                    <jsp:setProperty name="dataAccess" property="*" />
                </jsp:useBean>
                <c:set var="u" value="${dataAccess.selectUser(sessionScope['userName'])}" />
                <table>
                    <tr><td><b>User Name:</b></td><td>${u.userName}</td></tr>
                    <tr><td><b>Role:</b></td><td>${u.role}</td></tr>
                    <tr><td><b>Locked Out:</b></td><td>${u.lockedOut == 1 ? "Yes" : "No"}</td></tr>
                    <tr><td><b>Last Login:</b></td><td>${u.lastLogin}</td></tr>
                </table>
                <hr>
                <h2>Change Password:</h2>
                <form action="${pageContext.request.contextPath}/adminUpdatePassword.jsp" method="post">
                    <h3><label for="oldPassword">Old Password:</label></h3>
                    <input id="oldPassword" type="password" name="oldPassword" required />
                    <h3><label for="newPassword">New Password:</label></h3>
                    <input id="newPassword" type="password" name="newPassword" required />
                    <label><input type="hidden" name="userName" value="${u.userName}" required /></label>
                    <p><input type="submit" /></p>
                </form>
                <span style="color: red;">
                    <c:if test="${not empty fn:escapeXml(param.errorMessage)}">
                        <h3>${fn:escapeXml(param.errorMessage)}</h3>
                    </c:if>
                </span>
            </div>
            </c:catch>
            <p>${catchException == null ? '' : catchException.message}</p>
        </main>
        <footer>
            <jsp:include page="masters/adminFooter.jsp" />
        </footer>
    </body>
</html>