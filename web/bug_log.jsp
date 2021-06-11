<%@page language="java" import="java.sql.*" pageEncoding="UTF-8"%>
<%
    
    String error = request.getParameter("error");
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db1","root","");
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("select * from log_details where error ='"+error+"'");
        out.print("<center>");
        while(rs.next()){
           out.print(rs.getString(2)+"</br>");
        }
        out.print("</center>");
        
    }   
    catch(Exception e){
        out.println(e);
    }


%>