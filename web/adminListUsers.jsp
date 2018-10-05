<%-- 
    Document   : adminListUser
    Created on : Jul 4, 2017, 10:00:01 PM
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
        <link type="text/css" href="${pageContext.request.contextPath}/css/theme.blue.css" rel="stylesheet"/>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.tablesorter.combined.js"></script>
        <script id="js">
            $(function() {
                $("#desktopTable").tablesorter({
                    sortList:[[0,0]],
                    widgets: ["filter"],
                    widgetOptions : {
                        filter_external : '.search',
                        filter_columnFilters: false,
                        filter_saveFilters : false,
                        filter_reset: '.reset'
                    }
                });
            });
        </script>
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
            <a href="${pageContext.request.contextPath}/desktopHome.jsp" title="Return to Home Page"><h1>Quick Medication Reference</h1></a>
            <h2>User Administration</h2>
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
            <form action="adminAddUser.jsp" method="post" style="display: inline;">
                <input type="submit" value="Add User" />
            </form>
            <br><br>
            <div class="searchBox"><b>Search: <input class="search" type="search" placeholder="Search" data-column="all" /></b></div>
            <!-- Get data from model and display on page -->
            <jsp:useBean id="dataAccess" class="com.quickmeds.models.DataAccess">
                <jsp:setProperty name="dataAccess" property="*" />
            </jsp:useBean>
            <c:set var="users" value="${dataAccess.selectAllUsers()}" />
            <table id="desktopTable" class="list tablesorter">
                <thead>
                    <tr class="listTitleRow">
                        <td><h4>User ID <img src="up-down-arrow.png" alt="<>" /></h4></td>
                        <td><h4>User Name <img src="up-down-arrow.png" alt="<>" /></h4></td>
                        <td><h4>Role <img src="up-down-arrow.png" alt="<>" /></h4></td>
                        <td><h4>Locked Out <img src="up-down-arrow.png" alt="<>" /></h4></td>
                        <td nowrap><h4>Last Login <img src="up-down-arrow.png" alt="<>" /></h4></td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${users}" var="u">
                        <tr>
                            <td><h4><a href="adminEditUser.jsp?userName=${u.userName}">${u.userID}</a></h4></td>
                            <td><h4><a href="adminEditUser.jsp?userName=${u.userName}">${u.userName}</a></h4></td>
                            <td><h4><a href="adminEditUser.jsp?userName=${u.userName}">${u.role}</a></h4></td>
                            <td><h4><a href="adminEditUser.jsp?userName=${u.userName}">${u.lockedOut == 1 ? "Yes" : "No"}</a></h4></td>
                            <td nowrap><h4><a href="adminEditUser.jsp?userName=${u.userName}">${u.lastLogin}</a></h4></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </main>
        <footer>
            <jsp:include page="masters/adminFooter.jsp" />
        </footer>
    </body>
</html>
