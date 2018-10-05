<%-- 
    Document   : adminUpdateMedication
    Created on : Jul 8, 2017, 2:48:40 PM
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
            <h2>Update Medication</h2>
        </header>
        <main>
            <c:catch var="catchException">
            <jsp:useBean id="dataAccess" class="com.quickmeds.models.DataAccess">
                <jsp:setProperty name="dataAccess" property="*" />
            </jsp:useBean>
            <div style="text-align: left; width: 100%;">
                <c:if test="${param.submit == 'Delete'}">
                    <c:choose>
                        <c:when test="${dataAccess.deleteMedication(fn:escapeXml(param.medID))}">
                            <c:redirect url="adminListMedications.jsp" >
                                <c:param name="errorMessage" value="Medication deleted" />
                            </c:redirect>
                        </c:when>
                        <c:otherwise>
                            <c:redirect url="adminEditMedication.jsp?medID=${param.medID}" >
                                <c:param name="errorMessage" value="Unable to delete medication" />
                            </c:redirect>
                        </c:otherwise>
                    </c:choose>
                </c:if>
                <c:if test="${empty fn:escapeXml(param.GName) or
                              empty fn:escapeXml(param.BName) or
                              empty fn:escapeXml(param.action) or
                              empty fn:escapeXml(param.cond1) or
                              empty fn:escapeXml(param.BTFlag) or
                              empty fn:escapeXml(param.DEA) or
                              empty fn:escapeXml(param.side_Effects) or
                              empty fn:escapeXml(param.interactions) or
                              empty fn:escapeXml(param.warnings)}">
                    <c:redirect url="adminEditMedication.jsp?medID=${param.medID}" >
                        <c:param name="errorMessage" value="Required fields (*) must be filled in" />
                    </c:redirect>
                </c:if>
                <c:if test="${empty fn:escapeXml(param.cond1)}">
                    <c:redirect url="adminEditMedication.jsp?medID=${param.medID}" >
                        <c:param name="errorMessage" value="Primary condition required" />
                    </c:redirect>
                </c:if>
                <c:if test="${empty fn:escapeXml(param.cond2) and not empty fn:escapeXml(param.cond3)}">
                    <c:redirect url="adminEditMedication.jsp?medID=${param.medID}" >
                        <c:param name="errorMessage" value="Secondary condition required" />
                    </c:redirect>
                </c:if>
                <c:if test="${not empty fn:escapeXml(param.cond2) and
                              (fn:escapeXml(param.cond2) == fn:escapeXml(param.cond1) or fn:escapeXml(param.cond2) == fn:escapeXml(param.cond3)) or
                              not empty fn:escapeXml(param.cond3) and
                              (fn:escapeXml(param.cond3) == fn:escapeXml(param.cond1) or fn:escapeXml(param.cond3) == fn:escapeXml(param.cond2))}">
                    <c:redirect url="adminEditMedication.jsp?medID=${param.medID}" >
                        <c:param name="errorMessage" value="Duplicate conditions" />
                    </c:redirect>
                </c:if>
                <c:if test="${!dataAccess.updateMedication(fn:escapeXml(param.medID),
                                    fn:escapeXml(param.GName),
                                    fn:escapeXml(param.BName),
                                    fn:escapeXml(param.action),
                                    fn:escapeXml(param.DEA),
                                    fn:escapeXml(param.BTFlag),
                                    fn:escapeXml(param.side_Effects),
                                    fn:escapeXml(param.interactions),
                                    fn:escapeXml(param.warnings))}">
                    <c:redirect url="adminEditMedication.jsp?medID=${param.medID}" >
                        <c:param name="errorMessage" value="Unable to update medication" />
                    </c:redirect>
                </c:if>
                <c:if test="${!dataAccess.deleteFromMedConTable(fn:escapeXml(param.medID))}">
                    <c:redirect url="adminEditMedication.jsp?medID=${param.medID}" >
                        <c:param name="errorMessage" value="Unable to reset conditions" />
                    </c:redirect>
                </c:if>
                <c:if test="${!dataAccess.updateMedConTable(fn:escapeXml(param.medID), fn:escapeXml(param.cond1))}">
                    <c:redirect url="adminEditMedication.jsp?medID=${param.medID}" >
                        <c:param name="errorMessage" value="Could not update primary condition" />
                    </c:redirect>
                </c:if>
                <c:if test="${not empty fn:escapeXml(param.cond2) and !dataAccess.updateMedConTable(fn:escapeXml(param.medID), fn:escapeXml(param.cond2))}">
                    <c:redirect url="adminEditMedication.jsp?medID=${param.medID}" >
                        <c:param name="errorMessage" value="Could not update secondary condition" />
                    </c:redirect>
                </c:if>
                <c:if test="${not empty fn:escapeXml(param.cond3) and !dataAccess.updateMedConTable(fn:escapeXml(param.medID), fn:escapeXml(param.cond3))}">
                    <c:redirect url="adminEditMedication.jsp?medID=${param.medID}" >
                        <c:param name="errorMessage" value="Could not update tertiary condition" />
                    </c:redirect>
                </c:if>
                <c:redirect url="adminEditMedication.jsp?medID=${param.medID}" >
                    <c:param name="errorMessage" value="Medication Updated!" />
                </c:redirect>
            </div>
            </c:catch>
            <p>${catchException == null ? '' : catchException.message}</p>
        </main>
        <footer>
            <jsp:include page="masters/adminFooter.jsp" />
        </footer>
    </body>
</html>
