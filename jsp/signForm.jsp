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
JSONObject taskJson=new JSONObject();	
	Query q = Query.getInstance(request);
	String responseXml = q.getContent();
	Document doc = Jsoup.parse(responseXml); 
	Elements content = doc.getElementsByClass("tbl");
	Elements tables = doc.getElementsByClass("tableClass");
	Element fujian = doc.getElementById("idTabs");
	Element e = doc.getElementsByClass("tdd").first();
	 if(null!=e){
		 taskJson.put("content", content.first());
		}else{
			taskJson.put("fujian", fujian);
			taskJson.put("content", tables.first());
		} 
	 
	
	
	Element idSpan = doc.getElementById("idxSpan");
	Elements dbPathArr = idSpan.select("param[name=DbPath]");
	
	String toDoString=dbPathArr.val();
	
	Element con = doc.getElementById("idxSpan");
	Elements file_unid = doc.select("file_unid");
	/* //System.out.println("-----file_unid-----= ===============" + ele.toArray()[0]); */
	Elements doc_unid = doc.select("doc_unid");
	String[] strArr=new String[file_unid.size()];
	for(int i=0; i<file_unid.size(); i++){
		String str = toDoString;
		str+="/0/";
		str+=doc_unid.get(i).text();
		str+="/$file/";
		str+=file_unid.get(i).text();
		strArr[i] = str;
	}
	
	Elements file_name = doc.select("file_name");
	String[] nameArr = new String[file_unid.size()];
	for(int i=0; i<file_unid.size(); i++){
		nameArr[i] = file_name.get(i).text();
	}
	
	taskJson.put("lianjie", strArr);
	taskJson.put("fileName", nameArr);
	out.print(taskJson);
%>