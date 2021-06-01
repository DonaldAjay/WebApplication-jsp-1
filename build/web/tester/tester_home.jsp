<%@page session="true" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Tester Home</title>
    </head>
    <body>
        <sql:setDataSource
            var="ds"
            driver="com.mysql.cj.jdbc.Driver"
            password=""
            url="jdbc:mysql://localhost:3306/db1"
            user="root"/>
        <sql:query var="list_Active_bug" dataSource="${ds}" >
            select * from request where status='Not Fixed' or status='Re Open';
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
            String a = session.getAttribute("username_test").toString();
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
        
        <form method="post" action="error_insert.jsp">
            Report new Error/Bug: <input type="text" name="error"/>
            </br> Description : <input type="text" name="desc"/>
            <input type="submit" name="submit" value="Submit"/>
        </form>
        
        <table border="1" cellpadding="5">
            <caption><h2>Error/Bugs report </h2></caption>
            <tr>
                <th>ID</th>
                <th>Error</th>
                <th>Description</th>
                <th>Status</th>
                <th>Tester</th>
                <th>Developer</th>
            </tr>
            <c:forEach var="error" items="${list_Active_bug.rows}">
                <tr>
                    <td>${error.ID}</td>
                    <td>${error.error}</td>
                    <td>${error.description}</td>
                    <td>${error.status} </td>
                    <td>${error.tester}</td>
                    <td>${error.developer}</td>
                    <td><form action="tester_bug_update.jsp" method="post">
                            <input type="submit" value="Remove" name="update"/>
                            <input type="hidden" value="${error.Error}" name="error"/>
                    </form></td>
                    
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
                    <td>    
                            <form action="tester_bug_update.jsp" method="post">
                                <input type="submit" value="Close" name="update"/>
                                <input type="hidden" value="${error.Error}" name="error"/>
                                <input type="hidden" value="${error.status}" name="status"/>
                            </form>
                        </td>
                        <td>    
                            <form action="tester_bug_update.jsp" method="post">
                                <input type="submit" value="Reopen" name="update"/>
                                <input type="hidden" value="${error.Error}" name="error"/>
                                <input type="hidden" value="${error.status}" name="status"/>
                            </form>
                        </td>
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
        
        </br></br>
        <a href="tester_logout.jsp">Logout</a>
    </center>
    </body>
</html>
