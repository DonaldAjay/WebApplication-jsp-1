<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Developer Login</title>
    </head>
    <body>
    <center >
        <h1>Developer Login</h1>
        <form action="../login_check.jsp" method="post" >
            <br/>Username: <input type="text" name="username">
            <br/>Password:  <input type="text" name="password">
            <input type="hidden" name="type" value="Developer"/>
            <br/><input type="submit" value="Submit">
        </form>
    </center>
    </body>
</html>
