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
				JSONObject json=new JSONObject();			
				Query q = Query.getInstance(request);
			
				String responseXml = q.getContent();
				System.out.println(responseXml);
				Document   doc = DocumentHelper.parseText(responseXml);
				
				String formAction=doc.selectSingleNode("//form//@action").getStringValue();
				
				
				Node loginCodeNode = doc.selectSingleNode("//logincode/text()");
				String loginCode="";
				if(loginCodeNode!=null){
					loginCode=loginCodeNode.getStringValue();
				}
				if(loginCode.equals("10")){
					json.put("success", false);
					json.put("msg","用户超出设备邦定数量,请联系管理员。");
				}else if(loginCode.equals("7")){
					json.put("success", false);
					json.put("msg","用户未被授权访问系统,请联系管理员。");
				}else if(formAction.contains("names.nsf")){
					json.put("success", false);
					json.put("msg","用户名和密码错误！");
				}else{
					String itcode=doc.selectSingleNode("//param[@name=\"Username\"]/@value").getStringValue();
					json.put("success", true);
					json.put("itcode",itcode);
					json.put("data-authorize","succeed");
				}
				String type = q.getContentType();

			
				out.clear();
				out.print(json);
				System.out.println(json);
				
				%>
				