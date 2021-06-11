<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
<%
    Gson gsonObj = new Gson();
    Map<Object,Object> map = null;
    Map<Object,Object> map1 = null;
    Map<Object,Object> map2 = null;
    List<Map<Object,Object>> list_developer = new ArrayList<Map<Object,Object>>();
    List<Map<Object,Object>> list_tester = new ArrayList<Map<Object,Object>>();
    List<Map<Object,Object>> list_bug = new ArrayList<Map<Object,Object>>();
    List list_error = new ArrayList();
    String top_developer = null;
    String top_tester = null;
    String bug_status = null;
    String error = null;
    Class.forName("com.mysql.cj.jdbc.Driver");
    try
    {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db1","root","");
        Statement st = con.createStatement();
        Statement st1 = con.createStatement();
        Statement st2 = con.createStatement();
        String Xval,Yval;
        
        ResultSet resultset = st.executeQuery("SELECT developer, COUNT(id) FROM request WHERE status='Closed' GROUP BY  developer ORDER BY COUNT(id) ");
        ResultSet rs2 = st1.executeQuery("select tester, count(id) from request group by tester order by count(id) ");
        ResultSet rs3 = st2.executeQuery("Select Error,status,status_code,description from request");
        while(resultset.next()){
            Xval = resultset.getString(1);
            Yval = resultset.getString(2);
            map = new HashMap<Object,Object>();
            map.put("name",Xval);
            map.put("y",Double.parseDouble(Yval));
            list_developer.add(map);
        } 
        top_developer=gsonObj.toJson(list_developer);
        while(rs2.next()){
            Xval = rs2.getString(1);
            Yval = rs2.getString(2);
            map1 = new HashMap<Object,Object>();
            map1.put("name",Xval);
            map1.put("y",Double.parseDouble(Yval));
            list_tester.add(map1);
        }
        top_tester = gsonObj.toJson(list_tester);
        while(rs3.next()){
            Xval = rs3.getString(1);
            Yval = rs3.getString(3);
            list_error.add(rs3.getString(1));
            map2 = new HashMap<Object,Object>();
            map2.put("name",Xval);
            map2.put("status",rs3.getString(2));
            map2.put("desc",rs3.getString(4));
            map2.put("y",Double.parseDouble(Yval));
            list_bug.add(map2);
        }
        bug_status = gsonObj.toJson(list_bug);
        error = gsonObj.toJson(list_error);
    }
    catch(Exception e){
        out.println(e);
        top_tester=null;
        top_developer=null;
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
                        text: 'Top Developer'
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
                        data: <% out.print(top_developer); %>
                    }]
                });
                const chart1 = Highcharts.chart('container1', {
                    chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false,
                        type: 'pie'
                    },
                    title: {
                        text: 'Top Tester'
                        },
                    tooltip: {
                        pointFormat: '<b>{point.desc}</b>: <b>{point.y}</b>'
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
                        data: <% out.print(top_tester); %>
                    }]
                });
                const chart2 = Highcharts.chart('container2', {
                    chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false,
                        type: 'pie'
                    },
                    title: {
                        text: 'Bug Summary  '
                        },
                    tooltip: {
                        pointFormat: '<b>{point.desc}</b>: <b>{point.status}</b>'
                        },
                    xAxis: {
                        categories: <% out.print(error);%>,
                        title: {
                            text: null
                        }
                    },
                            yAxis: {
                                min: 0,
                                categories: ["","Not Fixed","Re open" ,"Fixed/Not an Issue" ,"Closed"],
                                labels: {   
                                    overflow: 'justify'
                                }
                            },
                    accessibility: {    
                    },
                    plotOptions: {
                        bar: {
                            allowPointSelect: true,
                            cursor: 'pointer',
                            dataLabels: {
                                enabled: true,
                                format: '<b>{point.name}-{point.status}</b> '
                                },
                            showInLegend: true
                        }
                    },
                    series: [{
                        name: 'Bug',
                        colorByPoint: true,
                        data: <% out.print(bug_status); %>
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
            <div id="container1"></div>
        </figure>
        <figure class="highcharts-figure">
            <div id="container2"></div>
        </figure>
    </body>
</html>
