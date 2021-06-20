<%@page session="true" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Tester Home</title>
        <style>
        body {font-family: Arial, Helvetica, sans-serif;}

        /* The Modal (background) */
        .modal {
          display: none; /* Hidden by default */
          position: fixed; /* Stay in place */
          z-index: 1; /* Sit on top */
          padding-top: 100px; /* Location of the box */
          left: 0;
          top: 0;
          width: 100%; /* Full width */
          height: 100%; /* Full height */
          overflow: auto; /* Enable scroll if needed */
          background-color: rgb(0,0,0); /* Fallback color */
          background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        /* Modal Content */
        .modal-content {
          background-color: #fefefe;
          margin: auto;
          padding: 20px;
          border: 1px solid #888;
          width: 80%;
        }

        /* The Close Button */
        .close {
          color: #aaaaaa;
          float: right;
          font-size: 28px;
          font-weight: bold;
        }

        .close:hover,
        .close:focus {
          color: #000;
          text-decoration: none;
          cursor: pointer;
        }
        </style>
    </head>
    <body>
        
        
 
        <sql:setDataSource
            var="ds"
            driver="com.mysql.cj.jdbc.Driver"
            password=""
            url="jdbc:mysql://localhost:3306/db1"
            user="root"/>
        <sql:query var="list_Active_bug" dataSource="${ds}" >
            select * from request where status='Not Fixed' or status='Re Open' ;
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
            session.setAttribute("username_test",a);
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
        <script >
            function filterTable() {
            var dropdown, table,filter,txtValue,tr,td,i;
            dropdown = document.getElementById("mySelector");
            filter = dropdown.value;
            table = document.getElementById("myTable");
            tr = table.getElementsByTagName("tr");
           
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[3];
                if (td) {
                  txtValue = td.textContent || td.innerText;
                  if (txtValue.indexOf(filter) > -1) {
                    tr[i].style.display = "";
                  } else {
                    tr[i].style.display = "none";
                  }
                }
            }
          }
        </script>
        <table border="1" cellpadding="5" id ="myTable" >
            <caption><h2>Error/Bugs report </h2></caption>
            
            <tr>
                
                <th>ID</th>
                <th>Error</th>
                <th>Description</th>
                <th>Status 
                    <select id='mySelector' onchange="filterTable()">
                        <option value="">All</option>
                        <option value="Closed ">Closed</option>
                        <option value="Fixed">Fixed</option>
                        <option value="Re Open">Re Open</option>
                        <option value="Not fixed">Not Fixed</option>
                    </select></th>
                <th>Tester</th>
                <th>Developer</th>
               
            </tr>   
            <c:forEach var="error" items="${list_Active_bug.rows}">
                <tr >
                    <td>${error.ID}</td>
                    <td>${error.error}</td>
                    <td>${error.description}</td>
                    <td  >${error.status} </td>
                    <td>${error.tester}</td>
                    <td>${error.developer}</td>
                    <td><form action="tester_bug_update.jsp" method="post">
                            <input type="submit" value="Remove" name="update"/>
                            <input type="hidden" value="${error.Error}" name="error"/>
                    </form></td>
                    <td><form action="../bug_log.jsp" method="post" >
                                    <input type="submit" value="Log"/>
                                    <input type="hidden" value="${error.error}" name="error"/>
                        </form></td>
                    
                    
                </tr>
            </c:forEach>
            <c:forEach var="error" items="${list_developer_update.rows}">
                <tr >
                    <td>${error.ID}</td>
                    <td>${error.error}</td>
                    <td>${error.description}</td>
                    <td >${error.status} </td>
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
                        <td><form action="../bug_log.jsp" method="post" >
                                    <input type="submit" value="Log"/>
                                    <input type="hidden" value="${error.error}" name="error"/>
                        </form></td>
                </tr>
            </c:forEach>
            <c:forEach var="error" items="${list_closed_error.rows}">
                <tr >
                    <td>${error.ID}</td>
                    <td>${error.error}</td>
                    <td>${error.description}</td>
                    <td >${error.status} </td>
                    <td>${error.tester}</td>
                    <td>${error.developer}</td>
                    <td><form action="../bug_log.jsp" method="post" >
                                    <input type="submit" value="Log"/>
                                    <input type="hidden" value="${error.error}" name="error"/>
                        </form></td>
                    
                </tr>  
            </c:forEach>
        </table>
        
        </br></br>
        <form method="post" action="../graph.jsp" >
            <input type="submit" value="Bug Summary">
        </form>
        
        <a href="tester_logout.jsp">Logout</a>
    </center>


    </body>
</html>
