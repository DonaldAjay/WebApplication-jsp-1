<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*"%>
<%
    String error = request.getParameter("error");
    String update = request.getParameter("update");
    String status =request.getParameter("status");
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db1","root","");
        Statement st = con.createStatement();
        
        if(update.equals("Close")){
//            st.executeUpdate("insert into closed_error (error,status) values ('"+error+"','FIXED and CLOSED')");
//            st.executeUpdate("delete from request where error='"+error+"'");
            st.executeUpdate("update request set status='Closed' where error='"+error+"'");
            st.executeUpdate("update request set status_code =4 where error ='"+error+"' ");
            out.println("Data is successfully Changed!"); 
        }   
        else if(update.equals("Remove")){
            st.executeUpdate("delete from request where error='"+error+"'");
            out.println("Data is successfully Changed!");
        }
        else if(update.equals("Reopen")){
            st.executeUpdate("update request set status='Re Open' where error='"+error+"'");
            st.executeUpdate("update request set status_code =2 where error ='"+error+"' ");
            out.println("Data is successfully Changed!");
        } 
        response.sendRedirect("tester_home.jsp");
    }
    catch(Exception e){
        out.print(e);   
    }
%>