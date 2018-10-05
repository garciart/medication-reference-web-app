<%-- 
    Document   : desktopHome
    Created on : Jun 17, 2017, 8:14:06 AM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Quick Medication Reference</title>
        <jsp:include page="masters/desktopHead.jsp" />
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
        <noscript>
            <p class="warningText">(Javascript disabled. Please enable Javascript for full functionality)</p>
        </noscript>
        <header>
            <a href="${pageContext.request.contextPath}/desktopHome.jsp" title="Return to Home Page"><h1>Quick Medication Reference</h1></a>
            <h2>Desktop View - Current as of 2017</h2>
        </header>
        <main style="text-align: left; width: 100%;">
            <div class="searchBox"><b>Search: <input class="search" type="search" placeholder="Search" data-column="all" /></b></div>
            <!-- Get data from model and display on page -->
            <jsp:useBean id="dataAccess" class="com.quickmeds.models.DataAccess">
                <jsp:setProperty name="dataAccess" property="*" />
            </jsp:useBean>
            <c:set var="meds" value='${dataAccess.selectMedicationsByGenericName()}' />
            <table id="desktopTable" class="list tablesorter">
                <thead>
                    <tr class="listTitleRow">
                        <td><h2>GENERIC NAME <img src="up-down-arrow.png" alt="<>" /></h2></td>
                        <td><h2>BRAND NAME <img src="up-down-arrow.png" alt="<>" /></h2></td>
                        <td><h2>CONDITION</h2></td>
                    </tr>
                </thead>
                <tbody>
                    <!-- Highlight blood thinners in red -->
                    <c:forEach items="${meds}" var="m">
                    <tr style="${m.BTFlag == 1 ? 'background-color: red; color: white' : ''}">
                        <td><h2><a href="desktopDetails.jsp?medID=${m.medID}" title="${m.GName}" style="${m.BTFlag == 1 ? 'color: white' : ''}">${m.GName}</a></h2></td>
                        <td><h2><a href="desktopDetails.jsp?medID=${m.medID}" title="${m.GName}" style="${m.BTFlag == 1 ? 'color: white' : ''}">${m.BName}</a></h2></td>
                        <td>
                            <h2>${m.cond1}</h2>
                            <h2>${m.cond2 != null ? m.cond2 : ''}</h2>
                            <h2>${m.cond3 != null ? m.cond3 : ''}</h2>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </main>
        <footer>
            <jsp:include page="masters/desktopFooter.jsp" />
        </footer>
    </body>
</html>
