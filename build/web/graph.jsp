<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
<%
    Gson gsonObj = new Gson();
    Map<Object,Object> map = null;
    String str = null;
    String[] str_qr = new String[100] ; 
    String[] title = new String[100];
    int i=0;
    
    Class.forName("com.mysql.cj.jdbc.Driver");
    try
    {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db1","root","");
        Statement st = con.createStatement();
        Statement st1 = con.createStatement();
        String xval,yval;
        ResultSet resultset = st.executeQuery("SELECT * from graph ");
        while(resultset.next()){
            st = con.createStatement();
            String query = resultset.getString(2);
            title[i]=resultset.getString(3);      
            ResultSet rs = st1.executeQuery(query);
            List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
            while(rs.next()){
                xval = rs.getString(1);
                yval = rs.getString(2);
                map = new HashMap<Object,Object>();
                map.put("name",xval);
                map.put("y",Double.parseDouble(yval));
                list.add(map);
            }
            str = gsonObj.toJson(list);           
            str_qr[i++]=str;
        }
    }
    catch(Exception e){
        out.println(e);
        str = null;
    }

%>
<!DOCTYPE html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Summary of Bug</title>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <script src="https://code.highcharts.com/highcharts.src.js"></script>
        <script src="https://code.highcharts.com/modules/exporting.js"></script>
        <script src="https://code.highcharts.com/modules/export-data.js"></script>
        <script src="https://code.highcharts.com/modules/accessibility.js"></script>
        <script type="text/javascript">
        var chart;
        var arr=[""];
        var title =[""];
        var totalcharts= <%= i %> - 0
        function create_div_dynamic(i){
            dv = document.createElement('div');
            dv.setAttribute('id','myChart'+i);     
            document.getElementById('graph').appendChild(dv);
        }
        <% for(int x = 0;x < i ;x++) { %>
            arr.push(<%= str_qr[x] %>); 
            title.push('<%= title[x] %>');
        <% }%>
        
        jQuery(document).ready(function($) {
                            for (var i = 0; i < totalcharts; i++) {
                                create_div_dynamic(i);
                                $('#myChart' + i).chart = new Highcharts.Chart({
                                            chart: {
                                                renderTo:'myChart' + i,
                                                plotBackgroundColor: null,
                                                plotBorderWidth: null,
                                                plotShadow: false,
                                                type: 'pie'
                                            },
                                            title: {
                                                text: title[i+1]
                                                },
                                            tooltip: {
                                                pointFormat: '<b>{point.y}</b>'
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
                                                data: arr[i+1]
                                            }]

                                              });
                                          }
                                      });
        
        </script>
        
    </head>
    <body>
        <center>
            <h id='graph'> </h>
        <a href="javascript:history.back()" >Go Back</a>
        </center>
    </body>
    
    

