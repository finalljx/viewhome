<%@page import="cc.movein.mda.system.control.q.Input"%>
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
	String agyj=doc.getElementById("agyj").toString().replaceAll("/genertec", "");
	taskJson.put("agyj", agyj);
	Elements hidden=doc.select("input[type=hidden]");
	System.out.println(hidden);
	taskJson.put("hidden", hidden);
	Elements content=doc.select("td<[class=tdd]>");
	System.out.print(content);
	out.print(taskJson);
	%>