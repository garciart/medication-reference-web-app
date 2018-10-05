<%-- 
    Document   : adminEditMedication
    Created on : Jul 4, 2017, 9:58:43 PM
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
            <h2>Edit Medication</h2>
        </header>
        <main>
            <c:catch var="catchException">
            <h2>Welcome, ${sessionScope['userName']}!</h2>
            <div style="text-align: left; width: 100%;">
                <form action="adminListMedications.jsp" method="post" style="display: inline;">
                    <input type="submit" value="Return to Medications Administration Menu" />
                </form>&nbsp;or&nbsp;
                <form action="logout.jsp" method="post" style="display: inline;">
                    <input type="submit" value="Log Out" />
                </form>
                <br><br>
                <c:if test="${!((fn:escapeXml(param.medID)).matches('[0-9]+'))}">
                    <c:redirect url="/adminListMedications.jsp"/>
                </c:if>
                <span style="color: red;">
                    <c:if test="${not empty fn:escapeXml(param.errorMessage)}">
                        <h3>${fn:escapeXml(param.errorMessage)}</h3>
                    </c:if>
                </span>
                <!-- Get data from model and display on page -->
                <jsp:useBean id="dataAccess" class="com.quickmeds.models.DataAccess">
                    <jsp:setProperty name="dataAccess" property="*" />
                </jsp:useBean>
                <c:set var="m" value="${dataAccess.selectMedicationDetails(fn:escapeXml(param.medID))}" />
                <c:set var="cons" value='${dataAccess.selectAllConditions()}' />
                <form action="${pageContext.request.contextPath}/adminUpdateMedication.jsp" method="post">
                    <input type="hidden" name="medID" value="${param.medID}" />
                    <table class="list">
                        <tr><td class="detailsTD" style="width:20em;"><h2><label for="GName">Generic Name*:</label></h2></td>
                            <td><h2><input type="text" id="GName" name="GName" value="${m.GName}" maxlength="50"></h2></td></tr>
                        <tr><td class="detailsTD"><h2><label for="BName">Brand Name*:</label></h2></td>
                            <td><h2><input type="text" id="BName" name="BName" value="${m.BName}" maxlength="50"></h2></td></tr>
                        <tr><td class="detailsTD"><h2><label for="action">Action*:</label></h2></td>
                            <td><h2><input type="text" id="action" name="action" value="${m.action}" maxlength="50"></h2></td></tr>
                        <tr>
                            <td class="detailsTD"><h2>Conditions:</h2></td>
                            <td>
                                <h2>
                                    <label>
                                        <select name="cond1">
                                            <option value=""></option>
                                            <c:forEach items="${cons}" var="c">
                                                <option value="${c.conID}" ${c.condition == fn:substringAfter(m.cond1, ',') ?
                                                'selected' : ''}>${c.condition}</option>
                                            </c:forEach>
                                        </select>&nbsp*
                                    </label>
                                </h2><h2>
                                <label>
                                    <select name="cond2">
                                        <option value=""></option>
                                        <c:forEach items="${cons}" var="c">
                                            <option value="${c.conID}" ${c.condition == fn:substringAfter(m.cond2, ',') ?
                                            'selected' : ''}>${c.condition}</option>
                                        </c:forEach>
                                    </select>
                                </label>
                            </h2><h2>
                                <label>
                                    <select name="cond3">
                                        <option value=""></option>
                                        <c:forEach items="${cons}" var="c">
                                            <option value="${c.conID}" ${c.condition == fn:substringAfter(m.cond3, ',') ?
                                            'selected' : ''}>${c.condition}</option>
                                        </c:forEach>
                                    </select>
                                </label>
                            </h2>
                            </td>
                        </tr>
                        <tr><td class="detailsTD"><h2>Blood Thinner*:</h2></td>
                            <td style="font-size: initial;">
                                <h2><label><input type="radio" name="BTFlag" value="1" ${m.BTFlag== 1 ? 'checked' : ''}>Yes</label></h2>
                                <h2><label><input type="radio" name="BTFlag" value="0" ${m.BTFlag !=1 ? 'checked' : ''}>No</label></h2>
                            </td>
                        </tr>
                        <tr><td class="detailsTD"><h2><label for="DEA">DEA Schedule*:</label></h2></td>
                            <td><h2><input type="number" id="DEA" name="DEA" value="${m.DEA}" min="0" max="5"></h2></td></tr>
                        <tr><td class="detailsTD"><h2><label for="side_Effects">Overdosages*:</label></h2></td>
                            <td><h2><textarea id="side_Effects" name="side_Effects" maxlength="512" rows="4" style="width:100%;">${m.side_Effects}</textarea></h2></td></tr>
                        <tr><td class="detailsTD"><h2><label for="interactions">Interactions*:</label></h2></td>
                            <td><h2><textarea id="interactions" name="interactions" maxlength="512" rows="4" style="width:100%;">${m.interactions}</textarea></h2></td></tr>
                        <tr><td class="detailsTD"><h2><label for="warnings">Warnings*:</label></h2></td>
                            <td><h2><textarea id="warnings" name="warnings" maxlength="512" rows="4" style="width:100%;">${m.warnings}</textarea></h2></td></tr>
                    </table>
                    <p><b>* - Required Fields</b></p>
                    <p style="text-align: center;">
                        <input type="submit" name="submit" value="Update" style="display: inline;">&nbsp;or
                        <input type="submit" name="submit" value="Delete" style="display: inline;" onclick="return confirm('Are you sure you want to delete this item?');">
                    </p>
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