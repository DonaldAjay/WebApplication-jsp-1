<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
<%
    Gson gsonObj = new Gson();
    Map<Object,Object> map = null;
    List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
    String datapoints = null;
    Class.forName("com.mysql.cj.jdbc.Driver");
    String a="[";
    try
    {
        
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db1","root","");
        Statement st = con.createStatement();
        String Xval,Yval;
        
        ResultSet resultset = st.executeQuery("SELECT developer, COUNT(id) FROM request WHERE status='Closed' GROUP BY  developer ORDER BY COUNT(id) ");
        
        while(resultset.next()){
            Xval = resultset.getString(1);
            Yval = resultset.getString(2);
            map = new HashMap<Object,Object>();
            map.put("label",Xval);
            map.put("y",Double.parseDouble(Yval));
            list.add(map);
        }   
        datapoints=gsonObj.toJson(list);

        con.close();     
    }
    catch(Exception e){
        out.println(e);
        datapoints= null;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Summary of Bug</title>
<script type="text/javascript">
window.onload = function() { 
 
var chart = new CanvasJS.Chart("chartContainer", {
                        theme: "light2",
                        animationEnabled: true,
                        exportFileName: "Summary of Bug",
                        exportEnabled: true,
                        title:{
                                text: "Summary of Bug"
                        },
                        data: [{
                                type: "pie",
                                showInLegend: true ,
                                legendText: "{label}",
                                toolTipContent: "{label}: <strong>{y}%</strong>",
                                indexLabel: "{label} {y}",
                                dataPoints : <%out.print(datapoints);%>
                        }]
                });

                chart.render();

                }
</script>
    </head>
    <body>
        <div id="chartContainer" style="height: 370px; width: 100%;"></div>
        <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
    </body>
</html>
