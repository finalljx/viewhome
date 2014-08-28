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
<%		
	Query q = Query.getInstance(request);
	String responseXml = q.getContent();
	Document   doc = DocumentHelper.parseText(responseXml);
	String itcode="";
	try{
		Node actionNode=doc.selectSingleNode("//td[@class='viewtotal']/a/@href");
		if(actionNode!=null){
			String name = actionNode.getStringValue();
			name = name.substring(name.indexOf("CN=")+3, name.indexOf("/O="));
			itcode=java.net.URLEncoder.encode(name, "gb2312");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	out.clear();
	out.print(itcode);
%>