<%-- 
    Document   : adminListMedications
    Created on : Jul 4, 2017, 9:58:10 PM
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
        <c:if test="${sessionScope['loggedIn'] != true && (sessionScope['role'] != 'Editor' || sessionScope['role'] != 'Administrator')}">
            <c:redirect url="/login.jsp" />
        </c:if>
        <noscript>
            <p class="warningText">(Javascript disabled. Please enable Javascript for full functionality)</p>
        </noscript>
        <header>
            <a href="${pageContext.request.contextPath}/desktopHome.jsp" title="Return to Home Page"><h1>Quick Electronic Medical Reference</h1></a>
            <h2>Medications Administration</h2>
        </header>
        <main>
            <div style="text-align: left; width: 100%;">
                <form action="adminMenu.jsp" method="post" style="display: inline;">
                    <input type="submit" value="Return Administration Menu" />
                </form>&nbsp;or&nbsp;
                <form action="logout.jsp" method="post" style="display: inline;">
                    <input type="submit" value="Log Out" />
                </form>
                <br><br>
                <hr>
                <form action="adminAddMedication.jsp" method="post" style="display: inline;">
                    <input type="submit" value="Add Medication" />
                </form>
                <br><br>
                <div class="searchBox"><b>Search: <input class="search" type="search" placeholder="Search" data-column="all" /></b></div>
                <span style="color: red;">
                    <c:if test="${not empty fn:escapeXml(param.errorMessage)}">
                        <h3>${fn:escapeXml(param.errorMessage)}</h3>
                    </c:if>
                </span>
                <!-- Get data from model and display on page -->
                <jsp:useBean id="dataAccess" class="com.quickemr.models.DataAccess">
                    <jsp:setProperty name="dataAccess" property="*" />
                </jsp:useBean>
                <c:set var="meds" value='${dataAccess.selectMedicationsByGenericName()}' />
                <table id="desktopTable" class="list tablesorter">
                    <thead>
                        <tr class="listTitleRow">
                            <td><h2>GENERIC NAME <img src="up-down-arrow.png" alt="<>" /></h2></td>
                            <td><h2>BRAND NAME <img src="up-down-arrow.png" alt="<>" /></h2></td>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Highlight blood thinners in red -->
                        <c:forEach items="${meds}" var="m">
                        <tr>
                            <td><h2><a href="adminEditMedication.jsp?medID=${m.medID}" title="${m.GName}">${m.GName}</a></h2></td>
                            <td><h2><a href="adminEditMedication.jsp?medID=${m.medID}" title="${m.GName}">${m.BName}</a></h2></td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
        <footer>
            <jsp:include page="masters/adminFooter.jsp" />
        </footer>
    </body>
</html>

