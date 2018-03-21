<%-- 
    Document   : adminMenu
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
                <form action="logout.jsp" method="post">
                    <input type="submit" value="Log Out" />
                </form>
                <br><br>
                <hr>
                <h2>User Functions:</h2>
                <form action="${pageContext.request.contextPath}/adminEditProfile.jsp" method="post">
                    <p><input type="submit" value="View and Edit Profile" /></p>
                </form>
                <jsp:useBean id="utilities" class="com.quickemr.models.Utilities">
                    <jsp:setProperty name="utilities" property="*" />
                </jsp:useBean>
                <jsp:useBean id="dataAccess" class="com.quickemr.models.DataAccess">
                    <jsp:setProperty name="dataAccess" property="*" />
                </jsp:useBean>
                <c:if test="${sessionScope['role'] == 'Editor' || sessionScope['role'] == 'Administrator'}">
                    <hr>
                    <h2>Editor Functions:</h2>
                    <form action="${pageContext.request.contextPath}/adminListMedications.jsp" method="post">
                        <p><input type="submit" value="Medications Administration" /></p>
                    </form>
                    <form action="${pageContext.request.contextPath}/adminListConditions.jsp" method="post">
                        <p><input type="submit" value="Conditions Administration" /></p>
                    </form>
                </c:if>
                <c:if test="${sessionScope['role'] == 'Administrator'}">
                    <hr>
                    <h2>Administrator Functions:</h2>
                    <form action="${pageContext.request.contextPath}/adminListUsers.jsp" method="post">
                        <p><input type="submit" value="Users Administration" /></p>
                    </form>
                    <form action="${pageContext.request.contextPath}/adminUpdateDatabase.jsp" method="post">
                        <p><input type="submit" value="Full Database Update" /></p>
                    </form>
                    <form action="${pageContext.request.contextPath}/adminEventLog.jsp" method="post">
                        <p><input type="submit" value="View Event Log" /></p>
                    </form>
                    <span style="color: red;">
                        <c:if test="${not empty fn:escapeXml(param.errorMessage)}">
                            <h3>${fn:escapeXml(param.errorMessage)}</h3>
                        </c:if>
                    </span>
                </c:if>
            </div>
        </main>
        <footer>
            <jsp:include page="masters/adminFooter.jsp" />
        </footer>
    </body>
</html>
