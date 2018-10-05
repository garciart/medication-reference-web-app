<%-- 
    Document   : mobileKeypad
    Created on : Jun 17, 2017, 12:05:57 PM
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
            <h2>${param.button == 1 ? "<h1>Medication Listing</h1>" : "<h1>Condition Listing</h1>"}</h2>
        </header>
        <main>
            <form action="${pageContext.request.contextPath}/mobileResults.jsp" method="post">
                <table class="keypad">
                    <tr>
                        <!-- h1 only renders properly with css -->
                        <!-- Add flag to key value -->
                        <td class="keys"><button type="submit" name="button" value="${(param.button * 10) + 1}">A B C</button></td>
                        <td class="keys"><button type="submit" name="button" value="${(param.button * 10) + 2}">D E F</button></td>
                        <td class="keys"><button type="submit" name="button" value="${(param.button * 10) + 3}">G H I</button></td>
                    </tr>
                    <tr>
                        <td class="keys"><button type="submit" name="button" value="${(param.button * 10) + 4}">J K L</button></td>
                        <td class="keys"><button type="submit" name="button" value="${(param.button * 10) + 5}">M N O</button></td>
                        <td class="keys"><button type="submit" name="button" value="${(param.button * 10) + 6}">P Q R</button></td>
                    </tr>
                    <tr>
                        <td class="keys"><button type="submit" name="button" value="${(param.button * 10) + 7}">S T U</button></td>
                        <td class="keys"><button type="submit" name="button" value="${(param.button * 10) + 8}">V W X</button></td>
                        <td class="keys"><button type="submit" name="button" value="${(param.button * 10) + 9}">Y Z</button></td>
                    </tr>
                </table>
            </form>
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