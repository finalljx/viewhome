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
	XPath xpath = doc.createXPath("//ns1:viewreportbyidresponse//ns1:out");
	
	String year = "";
	String month = "";
	String type = "";
	String[] seriesname = new String[4];
	String[] statMonth= new String[12];
	String[] lastSumData= new String[12];
	String[] nowSumData= new String[12];
	String[] increaseData= new String[12];
	String[] yearBudget= new String[12];
	String[] serieschart= new String[4];
	String[] seriesname2 = new String[4];
	String[] nowSumData2 = new String[12];
	String[] lastSumData2= new String[12];
	String[] increaseData2= new String[12];
	String[] yearBudget2= new String[12];
	String[] serieschart2= new String[4];
	try {
		 type = xpath.selectSingleNode("../type").getStringValue();
	 year = xpath.selectSingleNode("//root//year").getStringValue();
	 month = doc.selectSingleNode("//root//reportdata//month").getStringValue();
	 String aa = doc.selectSingleNode("//seriesname[1]").getStringValue();
	   seriesname=aa.split("\\|");
	   String sm = doc.selectSingleNode("//statMonth[1]").getStringValue();
		 statMonth=sm.split("\\|");
		String lsm1 = doc.selectSingleNode("//lastSumData[1]").getStringValue();
		 lastSumData =lsm1.split("\\|");
	  String nsm = doc.selectSingleNode("//nowSumData[1]").getStringValue();
	  nowSumData=nsm.split("\\|");
	  String ism  = doc.selectSingleNode("//increaseData[1]").getStringValue();
	  increaseData=ism.split("\\|");
	  String  ysm = doc.selectSingleNode("//yearBudget[1]").getStringValue();
	  yearBudget =ysm.split("\\|");
	  String  ss = doc.selectSingleNode("//serieschart[1]").getStringValue();
	  serieschart=ss.split("\\|");
	  String  aa2 = doc.selectSingleNode("//seriesname[2]").getStringValue();
	  seriesname2 =aa2.split("\\|");
	  String  lsm2 = doc.selectSingleNode("//lastSumData[2]").getStringValue();
	  lastSumData2=lsm2.split("\\|");
	  String  nsm2  = doc.selectSingleNode("//nowSumData[2]").getStringValue();
	  nowSumData2=nsm2.split("\\|");
	  String  ism2 = doc.selectSingleNode("//increaseData[2]").getStringValue();
	  increaseData2=ism2.split("\\|");
	  String  ysm2 = doc.selectSingleNode("//yearBudget[2]").getStringValue();
	  yearBudget2=ysm2.split("\\|");
	  String s2  = doc.selectSingleNode("//serieschart[2]").getStringValue();
	    serieschart2 =s2.split("\\|");
	} catch (Exception e) {
		e.printStackTrace();
	}
    json.put("year", year);
    json.put("month", month);
    json.put("type", type);
    json.put("seriesname", seriesname);
    json.put("seriesname2", seriesname2);
    json.put("statMonth", statMonth);
    json.put("lastSumData", lastSumData);
    json.put("lastSumData2", lastSumData2);
    json.put("nowSumData", nowSumData);
    json.put("nowSumData2", nowSumData);
    json.put("increaseData", increaseData);
    json.put("increaseData2", increaseData2);
    json.put("yearBudget", yearBudget);
    json.put("yearBudget2", yearBudget2);
    json.put("serieschart", serieschart);
    json.put("serieschart2", serieschart2);
	out.print(json);
	System.out.println(json);
%>