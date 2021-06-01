<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*"%>
<%
    String error = request.getParameter("error");
    String desc = request.getParameter("desc");
    String tester = session.getAttribute("username").toString();
    if(error.length()==0 || desc.length()==0){
        response.sendRedirect("tester_home.jsp");
    }
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db1","root","");
        Statement st = con.createStatement();
        st.executeUpdate("insert into request (Error,description,status,tester)values('"+error+"','"+desc+"','Not fixed','"+tester+"')");
        out.println("Data is successfully inserted!");  
        response.sendRedirect("tester_home.jsp");
    }
    catch(Exception e){
        out.print(e);   
    }
%>

