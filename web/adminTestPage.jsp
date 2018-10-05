<%-- 
    Document   : adminTestPage
    Created on : Jun 28, 2017, 4:46:46 PM
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
            <h2>Admin Menu</h2>
        </header>
        <main>
            <h2>Welcome, ${sessionScope['userName']}!</h2>
            <div style="text-align: left; width: 100%;">
                <hr>
                <h2>If you can read this, you have User privileges!</h2>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                <jsp:useBean id="utilities" class="com.quickemr.models.Utilities">
                    <jsp:setProperty name="utilities" property="*" />
                </jsp:useBean>
                <jsp:useBean id="dataAccess" class="com.quickemr.models.DataAccess">
                    <jsp:setProperty name="dataAccess" property="*" />
                </jsp:useBean>
                <c:if test="${sessionScope['role'] == 'Editor' || sessionScope['role'] == 'Administrator'}">
                    <hr>
                    <h2>If you can read this, you have Editor privileges!</h2>
                    <c:set var="u" value="${dataAccess.selectUser(sessionScope['userName'])}" />
                    <p>${u.userID}</p>
                    <p>${u.userName}</p>
                    <p>${u.role}</p>
                    <p>${u.salt}</p>
                    <p>${u.passwordHash}</p>
                    <p>${u.lockedOut == 1 ? "Yes" : "No"}</p>
                    <p>${u.lastLogin}</p>
                </c:if>
                <c:if test="${sessionScope['role'] == 'Administrator'}">
                    <hr>
                    <h2>If you can read this, you have Administrator privileges!</h2>
                    <p><b>Event Log:</b></p>
                    <c:set var="events" value="${utilities.readEventLog()}" />
                    <c:forEach items="${events}" var="e">
                        <p>${e}<p>
                    </c:forEach>
                    <p><b>Users:</b></p>
                    <c:set var="users" value="${dataAccess.selectAllUsers()}" />
                    <table>
                        <c:forEach items="${users}" var="u">
                            <tr>
                                <td>${u.userID}</td>
                                <td>${u.userName}</td>
                                <td>${u.role}</td>
                                <td>${u.salt}</td>
                                <td>${u.passwordHash}</td>
                                <td>${u.lockedOut}</td>
                                <td>${u.lastLogin}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:if>
            </div>
        </main>
        <footer>
            <jsp:include page="masters/adminFooter.jsp" />
        </footer>
    </body>
</html>
