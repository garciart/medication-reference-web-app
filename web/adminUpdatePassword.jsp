<%-- 
    Document   : adminUpdatePassword
    Created on : Jul 4, 2017, 7:35:30 PM
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
        <c:if test="${sessionScope['loggedIn'] != true}">
            <c:redirect url="/login.jsp" />
        </c:if>
        <noscript>
            <p class="warningText">(Javascript disabled. Please enable Javascript for full functionality)</p>
        </noscript>
        <header>
            <a href="${pageContext.request.contextPath}/desktopHome.jsp" title="Return to Home Page"><h1>Quick Medication Reference</h1></a>
            <h2>Change Password</h2>
        </header>
        <main>
            <c:catch var ="catchException">
            <c:if test="${empty fn:escapeXml(param.oldPassword) or empty fn:escapeXml(param.newPassword)}">
                <c:redirect url="adminEditProfile.jsp" >
                    <c:param name="errorMessage" value="Please enter your old password and a new password" />
                </c:redirect>
            </c:if>
            <c:if test="${not empty fn:escapeXml(param.oldPassword) and not empty fn:escapeXml(param.newPassword)}">
                <jsp:useBean id="utilities" class="com.quickmeds.models.Utilities">
                    <jsp:setProperty name="utilities" property="*" />
                </jsp:useBean>
                <jsp:useBean id="dataAccess" class="com.quickmeds.models.DataAccess">
                    <jsp:setProperty name="dataAccess" property="*" />
                </jsp:useBean>
                <!-- Authenticate user and set session variables -->
                <c:choose>
                    <c:when test="${utilities.authenticate(fn:escapeXml(param.userName), fn:escapeXml(param.oldPassword))}">
                        <c:choose>
                            <c:when test="${utilities.changePassword(fn:escapeXml(param.userName), fn:escapeXml(param.newPassword))}">
                                <c:redirect url="adminEditProfile.jsp" >
                                    <c:param name="errorMessage" value="Password Changed!" />
                                </c:redirect>
                            </c:when>
                            <c:otherwise>
                                <c:redirect url="adminEditProfile.jsp" >
                                    <c:param name="errorMessage" value="Unable to change password" />
                                </c:redirect>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <c:redirect url="adminEditProfile.jsp" >
                            <c:param name="errorMessage" value="Invalid old password" />
                        </c:redirect>
                    </c:otherwise>
                </c:choose>
            </c:if>
            </c:catch>
            <p>${catchException == null ? '' : catchException.message}</p>
        </main>
        <footer>
            <jsp:include page="masters/adminFooter.jsp" />
        </footer>
    </body>
</html>
