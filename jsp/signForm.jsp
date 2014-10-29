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
	Elements content = doc.getElementsByClass("tdd");

	String str[] = new String[5];
	
	for (int i = 0; i < content.size(); i++) {
		switch (i) {
		case 1:
			str[0] = content.get(1).text();

			break;
		case 3:
			str[1] = content.get(3).select(".tbl").get(1).select("td")
					.first().text();

			break;
		case 5:
			str[2] = content.get(5).select("tr>td").get(1).text();
			break;
		case 4:
			str[3] = content.get(4).select("tr>td").get(0).text();
			str[4] = content.get(4).select("tr>td").get(1).text();
			break;

		}
	}
	
	
	
	String[] strArr = new String[str.length];
	if (null != str) {

		for (int i = 0; i < str.length; i++) {
			if( str[i].split("：").length>1)
			strArr[i] = str[i].split("：")[1].trim();
			else
				strArr[i] = " ";
			
		}

	}
	String[] data=strArr[1].split("/");
	strArr[1]=data[2]+"-"+data[0]+"-"+data[1];
	taskJson.put("content", strArr);
	
	Element yjTable=doc.getElementById("agyj");
	Element agyj=yjTable.select("tr").first();
	

    taskJson.put("agyj", agyj);
	
	Element idSpan = doc.getElementById("idxSpan");
	Elements dbPathArr = idSpan.select("param[name=DbPath]");
	
	String toDoString=dbPathArr.val();
	
	
	Elements file_unid = doc.select("file_unid");
	
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
	out.print(taskJson);
%>

