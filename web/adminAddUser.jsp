<%-- 
    Document   : adminAddUser
    Created on : Jul 4, 2017, 10:04:33 PM
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
        <c:if test="${sessionScope['loggedIn'] != true || sessionScope['role'] != 'Administrator'}">
            <c:redirect url="/login.jsp" />
        </c:if>
        <noscript>
            <p class="warningText">(Javascript disabled. Please enable Javascript for full functionality)</p>
        </noscript>
        <header>
            <a href="${pageContext.request.contextPath}/desktopHome.jsp" title="Return to Home Page"><h1>Quick Electronic Medical Reference</h1></a>
            <h2>Add User</h2>
        </header>
        <main>
            <c:catch var="catchException">
            <h2>Welcome, ${sessionScope['userName']}!</h2>
            <div style="text-align: left; width: 100%;">
                <form action="adminListUsers.jsp" method="post" style="display: inline;">
                    <input type="submit" value="Return to User Administration Menu" />
                </form>&nbsp;or&nbsp;
                <form action="logout.jsp" method="post" style="display: inline;">
                    <input type="submit" value="Log Out" />
                </form>
                <br><br>
                <span style="color: red;">
                    <c:if test="${not empty fn:escapeXml(param.errorMessage)}">
                        <h3>${fn:escapeXml(param.errorMessage)}</h3>
                    </c:if>
                </span>
                <jsp:useBean id="dataAccess" class="com.quickemr.models.DataAccess">
                    <jsp:setProperty name="dataAccess" property="*" />
                </jsp:useBean>
                <c:set var="roles" value='${dataAccess.selectAllRoles()}' />
                <form action="${pageContext.request.contextPath}/adminCreateUser.jsp" method="post">
                    <table class="list">
                        <tr><td class="detailsTD" style="width:20em;"><h2><label for="userName">User Name*:</label></h2></td>
                            <td><h2><input type="text" id="userName" name="userName" maxlength="50"></h2></td></tr>
                        <tr>
                            <td class="detailsTD"><h2><label for="roleID">Roles*:</label></h2></td>
                            <td>
                                <h2>
                                    <select id="roleID" name="roleID">
                                        <option value="" selected></option>
                                        <c:forEach items="${roles}" var="r">
                                            <option value="${r.roleID}">${r.role}</option>
                                        </c:forEach>
                                    </select>
                                </h2>
                            </td>
                        </tr> 
                    </table>
                    <p style="text-align: center;"><input type="submit" value="Add to Database" /></p>
                </form>
            </div>
            </c:catch>
            <p>${catchException == null ? '' : catchException.message}</p>
        </main>
        <footer>
            <jsp:include page="masters/adminFooter.jsp" />
        </footer>
    </body>
</html>
