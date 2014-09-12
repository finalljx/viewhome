<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="cc.movein.mda.system.control.Query"%>
<%@ page language="java" import="org.json.*"%>

<%@ page language="java" import="org.dom4j.io.SAXReader"%>

<%@ page language="java" import="org.dom4j.Document"%>
<%@ page language="java" import="org.dom4j.DocumentException"%>
<%@ page language="java" import="org.dom4j.Element"%>
<%@ page language="java" import="org.dom4j.Node"%>
<%@ page language="java" import="org.dom4j.DocumentHelper"%>
<%@ page language="java" import="org.dom4j.XPath"%>
<%@ page language="java" import="java.util.*"%>
<%
   JSONObject json = new JSONObject();
	Query q = Query.getInstance(request);
	String responseXml = q.getContent();

	Document doc = DocumentHelper.parseText(responseXml);
	
	String year = "";
	String month = "";
	String primaryunit = "";
	String seriesname = "";
	String seriesdata = "";
	String qnys="";
	String ljwc="";
	String wcbl="";
	String qnysz="";
	String ljwcz="";
	String wcblz="";
	try {
	 year = doc.selectSingleNode("//year").getStringValue();
	 month = doc.selectSingleNode("//month").getStringValue();
	 primaryunit = doc.selectSingleNode("//primaryunit").getStringValue();
	 seriesname = doc.selectSingleNode("//seriesname").getStringValue();
	  String[] aa=seriesname.split("\\|");
	  qnys=aa[0];
	  ljwc=aa[1];
	  wcbl=aa[2];
	 seriesdata = doc.selectSingleNode("//seriesdata").getStringValue();
	 String[] bb=seriesdata.split("\\|");
	  qnysz=bb[0];
	  ljwcz=bb[1];
	  wcblz=bb[2];
	} catch (Exception e) {
		e.printStackTrace();
	}
    json.put("year", year);
    json.put("month", month);
    json.put("primaryunit", primaryunit);
    json.put("qnys", qnys);
    json.put("ljwc", ljwc);
    json.put("wcbl", wcbl);
    json.put("qnysz", qnysz);
    json.put("ljwcz", ljwcz);
    json.put("wcblz", wcblz);
    
	out.print(json);
	System.out.println(json);
%>