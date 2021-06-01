<%@page language="java" import="java.sql.*" pageEncoding="UTF-8"%>
<%
    
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String type = request.getParameter("type");
    if(username.equals("") || password.equals("")){
        response.sendRedirect("indexpage.jsp");
    }
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db1","root","");
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("select * from login where username='"+username+"' and password ='"+password+"' and type='"+type+"'");
        
        if(rs.next()){
            if(type.equals("Tester")){
                session.setAttribute("username_test",username);
                response.sendRedirect("tester/tester_home.jsp");
            }
            else if(type.equals("Developer")){
                session.setAttribute("username_dev",username);
                response.sendRedirect("developer/developer_home.jsp");
            }
        }
        out.print("Check the Login details");
    }
    catch(Exception e){
        out.println(e);
    }


%>
