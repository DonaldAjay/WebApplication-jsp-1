<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*,java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>
<%
    String error = request.getParameter("error");
    String status =request.getParameter("status");
    String developer = session.getAttribute("username_dev").toString();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db1","root","");
        Statement st = con.createStatement();
        st.executeUpdate("update request set status ='"+status+"' where error ='"+error+"' ");
        st.executeUpdate("update request set developer ='"+developer+"' where error ='"+error+"' ");
        st.executeUpdate("update request set status_code =3 where error ='"+error+"' ");
        st.executeUpdate("insert into log_details (error,log)values('"+error+"',' Bug - "+status+" by "+developer+" on "+LocalDateTime.now().format(formatter)+"')");
        out.println("Data is successfully Chnaged!");  
        response.sendRedirect("developer_home.jsp");
    }
    catch(Exception e){
        out.print(e);   
    }
%>
