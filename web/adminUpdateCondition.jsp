<%-- 
    Document   : adminUpdateCondition
    Created on : Jul 8, 2017, 5:52:48 PM
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
        <c:if test="${sessionScope['loggedIn'] != true && (sessionScope['role'] != 'Editor' || sessionScope['role'] != 'Administrator')}">
            <c:redirect url="/login.jsp" />
        </c:if>
        <noscript>
            <p class="warningText">(Javascript disabled. Please enable Javascript for full functionality)</p>
        </noscript>
        <header>
            <a href="${pageContext.request.contextPath}/desktopHome.jsp" title="Return to Home Page"><h1>Quick Medication Reference</h1></a>
            <h2>Update Condition</h2>
        </header>
        <main>
            <c:catch var="catchException">
            <jsp:useBean id="dataAccess" class="com.quickmeds.models.DataAccess">
                <jsp:setProperty name="dataAccess" property="*" />
            </jsp:useBean>
            <div style="text-align: left; width: 100%;">
                <c:if test="${param.submit == 'Delete'}">
                    <c:choose>
                        <c:when test="${dataAccess.deleteCondition(fn:escapeXml(param.conID))}">
                            <c:redirect url="adminListConditions.jsp" >
                                <c:param name="errorMessage" value="Condition deleted" />
                            </c:redirect>
                        </c:when>
                        <c:otherwise>
                            <c:redirect url="adminEditCondition.jsp?conID=${param.conID}" >
                                <c:param name="errorMessage" value="Unable to delete condition" />
                            </c:redirect>
                        </c:otherwise>
                    </c:choose>
                </c:if>
                <c:if test="${empty fn:escapeXml(param.condition) or
                              empty fn:escapeXml(param.description)}">
                    <c:redirect url="adminEditCondition.jsp?conID=${param.conID}" >
                        <c:param name="errorMessage" value="All fields must be filled in" />
                    </c:redirect>
                </c:if>
                <c:choose>
                    <c:when test="${dataAccess.updateCondition(fn:escapeXml(param.conID),
                                    fn:escapeXml(param.condition),
                                    fn:escapeXml(param.description))}">
                        <c:redirect url="adminEditCondition.jsp?conID=${param.conID}" >
                            <c:param name="errorMessage" value="Condition Updated!" />
                        </c:redirect>
                    </c:when>
                    <c:otherwise>
                        <c:redirect url="adminEditCondition.jsp?conID=${param.conID}" >
                            <c:param name="errorMessage" value="Unable to update condition" />
                        </c:redirect>
                    </c:otherwise>
                </c:choose>
            </div>
            </c:catch>
            <p>${catchException == null ? '' : catchException.message}</p>
        </main>
        <footer>
            <jsp:include page="masters/adminFooter.jsp" />
        </footer>
    </body>
</html>

