<%-- 
    Document   : desktopFooter
    Created on : Jul 1, 2017, 6:58:35 PM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@ page import="java.time.LocalDate" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<hr>
<p>Quick Medication Reference (QMR)</p>
<p>Copyright &copy; <% out.println((LocalDate.now().getYear() == 2017) ? "2017" : "2017 - " + String.valueOf(LocalDate.now().getYear())); %> Robert Garcia - All Rights Reserved</p>
<div class="loginKey"><a href="${pageContext.request.contextPath}/login.jsp" title="Login"><img src="${pageContext.request.contextPath}/login-key.png" alt="Login"/></a></div>