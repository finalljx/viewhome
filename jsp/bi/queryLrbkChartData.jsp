<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="cc.movein.mda.system.control.Query"%>
<%@ page language="java" import="cn.com.horitech.mobile.platform.common.tools.XmlUtils" %>
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
	Query q = Query.getInstance(request);
	String responseXml = q.getContent();

	Document doc = DocumentHelper.parseText(responseXml);
	Map nsMap = new HashMap();
	nsMap.put("ns1", "http://webservice.biz.digiwin.com");
	//对document而言全路径为：/beans:beans/beans:bean   
	XPath xpath = doc.createXPath("//ns1:viewreportbyidresponse//ns1:out");
	
	xpath.setNamespaceURIs(nsMap);
	String data = "";
	try {
		data = xpath.selectSingleNode(doc).getStringValue();
	} catch (Exception e) {
		e.printStackTrace();
	}
	out.clear();
	out.print(XmlUtils.xml2Json(data));
%>