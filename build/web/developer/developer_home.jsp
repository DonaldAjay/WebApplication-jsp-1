<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Developer Home</title>
    </head>
    <body>
    
        <sql:setDataSource
            var="ds"
            driver="com.mysql.cj.jdbc.Driver"
            password=""
            url="jdbc:mysql://localhost:3306/db1"
            user="root"/>
        <sql:query var="list_item" dataSource="${ds}">
                    Select * from request where status='Not Fixed' or status='Re Open';
        </sql:query>
        <sql:query var="list_developer_update" dataSource="${ds}" >
            select * from request where status ='Fixed' or status ='Not an Issue';
        </sql:query>
        <sql:query var="list_closed_error" dataSource="${ds}" >
            select * from request where status='Closed';
        </sql:query>
        <center>
        <h2>
        <%
            try{
                response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
            String a = session.getAttribute("username_dev").toString();
            out.println("Hello "+a);
            if(a==null){
                response.sendRedirect("../indexpage.jsp");
            }
            }
            catch(Exception e){
                response.sendRedirect("../indexpage.jsp");
            }
        %>
        </h2>
    </center>
        <div align="center">
            <table border="1" cellpadding="5">
                <caption><h2>Error/Bugs Report </h2></caption>
                <tr>
                    <th>ID</th>
                    <th>Error</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Tester</th>
                    <th>Developer</th>
                </tr>
                <c:forEach var="error" items="${list_item.rows}">
                    <tr>
                        <td>${error.ID}</td>
                        <td>${error.error}</td>
                        <td>${error.description}</td>
                        <td>${error.status} </td>
                        <td>${error.tester}</td>
                        <td>${error.developer}</td>
                        <td>    
                            <form action="developer_update.jsp" method="post">
                                <input type="submit" value="Fixed" name="status"/>
                                <input type="hidden" value="${error.Error}" name="error"/>
                            </form>
                        </td>
                        <td>    
                            <form action="developer_update.jsp" method="post">
                                <input type="submit" value="Not an Issue" name="status"/>
                                <input type="hidden" value="${error.Error}" name="error"/>
                            </form>
                        </td>
                        
                    </tr>
                </c:forEach>
                <c:forEach var="error" items="${list_developer_update.rows}">
                <tr>
                    <td>${error.ID}</td>
                    <td>${error.error}</td>
                    <td>${error.description}</td>
                    <td>${error.status} </td>
                    <td>${error.tester}</td>
                    <td>${error.developer}</td>
                    <td colspan="2">Waiting for Approval</td>
                </tr>
            </c:forEach>
                <c:forEach var="error" items="${list_closed_error.rows}">
                    <tr>
                        <td>${error.ID}</td>
                        <td>${error.error}</td>
                        <td>${error.description}</td>
                        <td>${error.status} </td>
                        <td>${error.tester}</td>
                        <td>${error.developer}</td>
                    </tr>  
                </c:forEach>   
            </table>
        </div>
    <center>
        </br></br>
        <a href="dev_logout.jsp">logout</a>
    </center>
    
    </body>
</html>
