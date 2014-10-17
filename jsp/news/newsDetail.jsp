<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="cc.movein.mda.system.control.Query"%>
<%@ page language="java"
	import="cn.com.horitech.mobile.platform.common.tools.XmlUtils"%>
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
    XPath xpath = doc.createXPath("//ns1:getwcmnewsdataresponse//ns1:out[1]");
    xpath.setNamespaceURIs(nsMap);
    String data = "";
    try {
        //返回xml数据内容
        data = xpath.selectSingleNode(doc).getStringValue().replaceAll("&#160;","	").replace("&", "&amp;");
    } catch (Exception e) {
        e.printStackTrace();
    }
    Document doc1 = DocumentHelper.parseText(data);
    XPath xpath1 = doc1.createXPath("//richText[1]");
    //获取正文html内容
    String richText = xpath1.selectSingleNode(doc1).asXML();
    
    richText = richText.replaceAll("<richText>","").replaceAll("</richText>","");
    data = doc1.asXML();
    String json = XmlUtils.xml2Json(data);
    JSONObject jo = new JSONObject(json);
    JSONObject newslist = (JSONObject)jo.get("newslist");
   XPath xpath2 = doc1.createXPath("//attachment[1]");
   if(xpath2.selectSingleNode(doc1)!=null){
   String attachment = xpath2.selectSingleNode(doc1).asXML();
    attachment = attachment.replaceAll("<attachment>","").replaceAll("</attachment>","");
    XPath xpath3 = doc1.createXPath("//attachmentSource[1]");
    String attachmentSource = xpath3.selectSingleNode(doc1).asXML();
    attachmentSource = attachmentSource.replaceAll("<attachmentSource>","").replaceAll("</attachmentSource>","");
    newslist.put("attachment",attachment);
    newslist.put("attachmentSource",attachmentSource);
   } 
    //替换正文html内容
    newslist.put("richText",richText);
    out.clear();
    out.print(newslist.toString());
%>