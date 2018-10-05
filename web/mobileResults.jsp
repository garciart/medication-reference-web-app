<%-- 
    Document   : mobileResults
    Created on : Jun 17, 2017, 12:08:34 PM
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
        <title>Quick Electronic Medical Reference</title>
        <link href="${pageContext.request.contextPath}/css/mobileStyle.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <!-- Redirect if mobile -->
        <c:set var="browser" value="${header['User-Agent']}" scope="session" />
        <c:if test = "${!fn:containsIgnoreCase(browser, 'mobi')}">
            <c:redirect url="/desktopHome.jsp"/>
        </c:if>
        <header>
            <a href="${pageContext.request.contextPath}/mobileHome.jsp" title="Return to Home Page"><h1>Quick Electronic Medical Reference</h1></a>
        </header>
        <main>
            <!-- Get data from model and display on page -->
            <jsp:useBean id="dataAccess" class="com.quickemr.models.DataAccess">
                <jsp:setProperty name="dataAccess" property="*" />
            </jsp:useBean>
            <table class="list">
            <c:if test = "${param.button < 20}">
                <c:set var="meds" value='${dataAccess.selectAllMedications(param.button - 10)}' />
                <thead>
                    <tr class="listTitleRow">
                        <td><h2>NAME:</h2></td>
                        <td><h2>CONDITION:</h2></td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${meds}" var="m">
                    <!-- Highlight blood thinners in red -->
                    <tr style="${m.BTFlag == 1 ? 'background-color: red; color: white' : ''}">
                        <td><h2><a href="mobileMedDetails.jsp?medID=${m.medID}" title="${m.GName}">
                            ${m.GName}<span class="listAKA"> aka </span>${m.BName}
                        </a></h2></td>
                        <td>
                            <h2>${m.cond1}</h2>
                            <h2>${m.cond2 != null ? m.cond2 : ''}</h2>
                            <h2>${m.cond3 != null ? m.cond3 : ''}</h2>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </c:if>
            <c:if test = "${param.button >= 20}">
                <c:set var="cons" value='${dataAccess.selectAllConditions(param.button - 20)}' />
                <thead>
                    <tr class="listTitleRow">
                        <td><h2>CONDITION:</h2></td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${cons}" var="cn">
                        <tr>
                            <td><h2><a href="mobileConDetails.jsp?conID=${cn.conID}" title="${cn.condition}">
                                ${cn.condition}
                            </a></h2></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </c:if>
            </table>
        </main>
        <footer class="backFooter">
            <button class="backButton" onclick="goBack()">Go Back</button>
            <script>
                /* Use history function instead of a redirect */
                function goBack() {
                    window.history.back();
                }
            </script>
        </footer>
    </body>
</html>