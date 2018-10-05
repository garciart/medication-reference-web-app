<%-- 
    Document   : desktopConDetails
    Created on : Jul 14, 2017, 4:33:18 PM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Quick EMR | Medication Details</title>
        <jsp:include page="masters/desktopHead.jsp" />
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
            <a href="${pageContext.request.contextPath}/desktopHome.jsp" title="Return to Home Page"><h1>Quick Electronic Medical Reference</h1></a>
            <h2>Condition Details</h2>
            <form action="${pageContext.request.contextPath}/desktopHome.jsp">
                <input type="submit" value="Home" />
            </form>
        </header>
        <main>
            <!-- Get data from model and display on page -->
            <c:if test="${!((fn:escapeXml(param.conID)).matches('[0-9]+'))}">
                <c:redirect url="/desktopHome.jsp"/>
            </c:if>
            <jsp:useBean id="dataAccess" class="com.quickemr.models.DataAccess">
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
                            <td><h2><a href="desktopDetails.jsp?medID=${m.medID}" title="${m.GName}">
                                ${m.GName}<span class="listAKA"> aka </span>${m.BName}
                            </a></h2></td>
                        </tr>
                    </c:forEach>
                    </table>
                </td></tr>
            </table>
        </main>
        <footer>
            <jsp:include page="masters/desktopFooter.jsp" />
        </footer>
    </body>
</html>
