<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.removeAttribute("username_test");
    session.invalidate();
    response.sendRedirect("../indexpage.jsp");
%>
