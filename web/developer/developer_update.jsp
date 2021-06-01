<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%
    String error = request.getParameter("error");
    String status =request.getParameter("status");
    String developer = session.getAttribute("username").toString();
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db1","root","");
        Statement st = con.createStatement();
        st.executeUpdate("update request set status ='"+status+"' where error ='"+error+"' ");
        st.executeUpdate("update request set developer ='"+developer+"' where error ='"+error+"' ");
        out.println("Data is successfully Chnaged!");  
        response.sendRedirect("developer_home.jsp");
    }
    catch(Exception e){
        out.print(e);   
    }
%>
