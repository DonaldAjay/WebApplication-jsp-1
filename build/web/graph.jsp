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
            map.put("name",Xval);
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
        <script src="https://code.highcharts.com/highcharts.src.js"></script>
        <script type="text/javascript">
            document.addEventListener('DOMContentLoaded', function () {
                const chart = Highcharts.chart('container', {
                    chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false,
                        type: 'pie'
                    },
                    title: {
                        text: 'Summary of Bug'
                        },
                    tooltip: {
                        pointFormat: 'Bug Cleared: <b>{point.y}</b>'
                        },
                    accessibility: {
                    },
                    plotOptions: {
                        pie: {
                            allowPointSelect: true,
                            cursor: 'pointer',
                            dataLabels: {
                                enabled: true,
                                format: '<b>{point.name}</b>: {point.y} '
                                },
                            showInLegend: true
                        }
                    },
                    series: [{
                        name: 'Bug',
                        colorByPoint: true,
                        data: <% out.print(datapoints); %>
                    }]
                });
            });
        </script>
    </head>
    <body>
        <script src="https://code.highcharts.com/highcharts.js"></script>
        <script src="https://code.highcharts.com/modules/exporting.js"></script>
        <script src="https://code.highcharts.com/modules/export-data.js"></script>
        <script src="https://code.highcharts.com/modules/accessibility.js"></script>
        <figure class="highcharts-figure">
            <div id="container"></div>
        </figure>
    </body>
</html>
