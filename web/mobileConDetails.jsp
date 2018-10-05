<%-- 
    Document   : mobileConDetails
    Created on : Jun 21, 2017, 12:14:33 PM
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
        <title>Quick Medication Reference</title>
        <link href="${pageContext.request.contextPath}/css/mobileStyle.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <!-- Redirect if mobile -->
        <c:set var="browser" value="${header['User-Agent']}" scope="session" />
        <c:if test = "${!fn:containsIgnoreCase(browser, 'mobi')}">
            <c:redirect url="/desktopHome.jsp"/>
        </c:if>
        <header>
            <a href="${pageContext.request.contextPath}/mobileHome.jsp" title="Return to Home Page"><h1>Quick Medication Reference</h1></a>
        </header>
        <main>
            <h1>Condition Details Page</h1>
            <!-- Get data from model and display on page -->
            <c:if test="${!((fn:escapeXml(param.conID)).matches('[0-9]+'))}">
                <c:redirect url="/mobileHome.jsp"/>
            </c:if>
            <jsp:useBean id="dataAccess" class="com.quickmeds.models.DataAccess">
                <jsp:setProperty name="dataAccess" property="*" />
            </jsp:useBean>
            <c:set var="c" value='${dataAccess.selectConditionDetails(param.conID)}' />
            <c:set var="meds" value='${dataAccess.selectMedicationsInCondition(param.conID)}' />
            <table class="list">
                <tr><td class="detailsTD"><h2>Condition:</h2></td></tr>
                <tr><td><h2>${c.condition}</h2></td></tr>
                <tr><td class="detailsTD"><h2>Description:</h2></td></tr>
                <tr><td><h2>${c.description}</h2></td></tr>
                <tr><td class="detailsTD"><h2>Medications:</h2></td></tr>
                <tr><td>
                    <table class="list">
                    <c:forEach items="${meds}" var="m">
                        <tr>
                            <td><h2><a href="mobileMedDetails.jsp?medID=${m.medID}" title="${m.GName}">
                                ${m.GName}<span class="listAKA"> aka </span>${m.BName}
                            </a></h2></td>
                        </tr>
                    </c:forEach>
                    </table>
                </td></tr>
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
