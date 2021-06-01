<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.removeAttribute("username_dev");
    session.invalidate();
    response.sendRedirect("../indexpage.jsp");
%>

