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
	Element content1 =doc.getElementById("table1");
	String content=content1.toString().replaceAll("/genertec", "");
	
	taskJson.put("content", content);
	Element agyj1=doc.getElementById("agyj");
	String agyj=agyj1.toString().replaceAll("/genertec", "");
	
	
	taskJson.put("agyj", agyj);
	Element idSpan = doc.getElementById("idxSpan");
	Elements dbPathArr = idSpan.select("param[name=DbPath]");
	
	String toDoString=dbPathArr.val();
	
	
	Elements file_unid = doc.select("file_unid");
	if(file_unid.size()>0){
	
	Elements doc_unid = doc.select("doc_unid");
	String[] strUrl=new String[file_unid.size()];
	for(int i=0; i<file_unid.size(); i++){
		String s = toDoString;
		s+="/0/";
		s+=doc_unid.get(i).text();
		s+="/$file/";
		s+=file_unid.get(i).text();  
		strUrl[i] = s;
	}
	
	Elements file_name = doc.select("file_name");
	String[] nameArr = new String[file_unid.size()];
	for(int i=0; i<file_unid.size(); i++){
		nameArr[i] = file_name.get(i).text();
	}
	
	taskJson.put("lianjie", strUrl);
	System.out.println(strUrl[0]);
	taskJson.put("fileName", nameArr);
	}
	
	out.print(taskJson);
	
	
	
	
	
	
	
	
	
	
	
	
	
%>