<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*,java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>
<%
    String error = request.getParameter("error");
    String update = request.getParameter("update");
    String status =request.getParameter("status");
    String tester = session.getAttribute("username_test").toString();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm");
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db1","root","");
        Statement st = con.createStatement();
        
        if(update.equals("Close")){
            st.executeUpdate("update request set status='Closed' where error='"+error+"'");
            st.executeUpdate("update request set status_code =4 where error ='"+error+"' ");
            st.executeUpdate("insert into log_details (error,log)values('"+error+"',' Bug Closed by "+tester+" on "+LocalDateTime.now().format(formatter)+"')");
            out.println("Data is successfully Changed!"); 
        }   
        else if(update.equals("Remove")){
            st.executeUpdate("delete from request where error='"+error+"'");
            out.println("Data is successfully Changed!");
        }
        else if(update.equals("Reopen")){
            st.executeUpdate("update request set status='Re Open' where error='"+error+"'");
            st.executeUpdate("update request set status_code =2 where error ='"+error+"' ");
            st.executeUpdate("insert into log_details (error,log)values('"+error+"',' Bug Reopen by "+tester+" on "+LocalDateTime.now().format(formatter)+"')");
            out.println("Data is successfully Changed!");
        } 
        response.sendRedirect("tester_home.jsp");
    }
    catch(Exception e){
        out.print(e);   
    }
%>