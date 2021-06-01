package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import java.sql.*;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

public final class graph_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

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
        
        ResultSet resultset = st.executeQuery("SELECT developer, COUNT(id) FROM request GROUP BY  developer ORDER BY COUNT(id) ");
        
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

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Summary of Bug</title>\n");
      out.write("<script type=\"text/javascript\">\n");
      out.write("window.onload = function() { \n");
      out.write(" \n");
      out.write("var chart = new CanvasJS.Chart(\"chartContainer\", {\n");
      out.write("                        theme: \"light2\",\n");
      out.write("                        animationEnabled: true,\n");
      out.write("                        exportFileName: \"Summary of Bug\",\n");
      out.write("                        exportEnabled: true,\n");
      out.write("                        title:{\n");
      out.write("                                text: \"Summary of Bug\"\n");
      out.write("                        },\n");
      out.write("                        data: [{\n");
      out.write("                                type: \"pie\",\n");
      out.write("                                showInLegend: true ,\n");
      out.write("                                legendText: \"{label}\",\n");
      out.write("                                toolTipContent: \"{label}: <strong>{y}%</strong>\",\n");
      out.write("                                indexLabel: \"{label} {y}\",\n");
      out.write("                                dataPoints : ");
out.print(datapoints);
      out.write("\n");
      out.write("                        }]\n");
      out.write("                });\n");
      out.write("\n");
      out.write("                chart.render();\n");
      out.write("\n");
      out.write("                }\n");
      out.write("</script>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <div id=\"chartContainer\" style=\"height: 370px; width: 100%;\"></div>\n");
      out.write("        <script src=\"https://canvasjs.com/assets/script/canvasjs.min.js\"></script>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
