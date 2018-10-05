<%-- 
    Document   : adminUpdateUser
    Created on : Jul 11, 2017, 12:48:03 PM
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
        <title>QMR | Admin Menu</title>
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
            <a href="${pageContext.request.contextPath}/desktopHome.jsp" title="Return to Home Page"><h1>Quick Medication Reference</h1></a>
            <h2>Update User</h2>
        </header>
        <main>
            <c:catch var="catchException">
            <jsp:useBean id="dataAccess" class="com.quickmeds.models.DataAccess">
                <jsp:setProperty name="dataAccess" property="*" />
            </jsp:useBean>
            <jsp:useBean id="utilities" class="com.quickmeds.models.Utilities">
                <jsp:setProperty name="utilities" property="*" />
            </jsp:useBean>
            <div style="text-align: left; width: 100%;">
                <form action="adminListUsers.jsp" method="post" style="display: inline;">
                    <input type="submit" value="Return to User Administration Menu" />
                </form>&nbsp;or&nbsp;
                <form action="logout.jsp" method="post" style="display: inline;">
                    <input type="submit" value="Log Out" />
                </form>
                <br><br>
                <hr>
                <c:if test="${param.submit == 'Delete User'}">
                    <c:choose>
                        <c:when test="${dataAccess.deleteUser(fn:escapeXml(param.userID), fn:escapeXml(sessionScope['userID']))}">
                            <c:redirect url="adminEditUser.jsp?userName=${param.userName}" >
                                <c:param name="errorMessage" value="User deleted" />
                            </c:redirect>
                        </c:when>
                        <c:otherwise>
                            <c:redirect url="adminEditUser.jsp?userName=${param.userName}" >
                                <c:param name="errorMessage" value="Unable to delete user" />
                            </c:redirect>
                        </c:otherwise>
                    </c:choose>
                </c:if>
                <c:if test="${param.submit == 'Reset Password'}">
                    <c:choose>
                        <c:when test="${utilities.changePassword(fn:escapeXml(param.userName), 'P@ssw0rd')}">
                            <c:redirect url="adminEditUser.jsp?userName=${param.userName}" >
                                <c:param name="errorMessage" value="Password Changed!" />
                            </c:redirect>
                        </c:when>
                        <c:otherwise>
                            <c:redirect url="adminEditUser.jsp?userName=${param.userName}" >
                                <c:param name="errorMessage" value="Unable to change password" />
                            </c:redirect>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </div>
            </c:catch>
            <p>${catchException == null ? '' : catchException.message}</p>
        </main>
        <footer>
            <jsp:include page="masters/adminFooter.jsp" />
        </footer>
    </body>
</html>
