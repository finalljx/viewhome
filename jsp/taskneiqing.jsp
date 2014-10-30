<%@page import="dom.GetElementsByTagName"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="cc.movein.mda.system.control.Query"%>
<%@ page language="java" import="org.json.*"%>


<%@ page language="java" import="org.dom4j.DocumentException"%>
<%@ page language="java" import="org.dom4j.Node"%>
<%@ page language="java" import="org.dom4j.DocumentHelper"%>
<%@ page language="java" import="java.util.List"%>
<%@ page language="java" import="java.io.File"%>
<%@ page language="java" import="java.util.Iterator"%>
<%@ page language="java"
	import="org.apache.commons.lang.StringEscapeUtils"%>

<%@ page language="java" import="org.jsoup.*"%>
<%@ page language="java" import="org.jsoup.select.*"%>
<%@ page language="java" import="org.jsoup.nodes.*"%>

<%
	JSONObject taskJson = new JSONObject();
	Query q = Query.getInstance(request);
	String responseXml = q.getContent();
	Document doc = Jsoup.parse(responseXml);
	Elements hidden=doc.select("input[type=hidden]");
	System.out.println(hidden);
	String agyj=doc.getElementById("agyj").toString().replaceAll("/genertec", "");
	System.out.println(agyj+"====================================");
	taskJson.put("hidden",hidden);
	taskJson.put("agyj", agyj);
	
	out.print(taskJson);
	
	
%>