<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page language="java" import="cc.movein.mda.system.control.Query"%>
<%@ page language="java" import="org.json.*"%>


<%@ page language="java" import="org.dom4j.Document"%>
<%@ page language="java" import="org.dom4j.DocumentException"%>
<%@ page language="java" import="org.dom4j.Element"%>
<%@ page language="java" import="org.dom4j.Node"%>
<%@ page language="java" import="org.dom4j.DocumentHelper"%>
<%@ page language="java" import="java.util.List"%>
<%@ page language="java" import="java.util.Iterator"%>
<%@ page language="java" import="org.apache.commons.lang.StringEscapeUtils"%>

				<%
				Query q = Query.getInstance(request);
				String responseXml = q.getContent();
				Document  doc = DocumentHelper.parseText(responseXml);
			      Node contentNode=doc.selectSingleNode("//return");
			      String content=contentNode.getText();
			     //System.out.print(content);
				//System.out.println(responseXml);
				out.print(content);
				
				
				%>
				