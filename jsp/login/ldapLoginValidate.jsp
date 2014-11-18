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
	System.out.println("---------------:" + responseXml);
	Document   doc = DocumentHelper.parseText(responseXml);
	try{
		Node loginCodeNode = doc.selectSingleNode("//logincode/text()");
		String loginCode="";
		if(loginCodeNode!=null){
			loginCode=loginCodeNode.getStringValue();
		}
		System.out.println("==========================="+loginCode);
		if(loginCode.equals("9")){
			json.put("success", false);
			json.put("msg","用户超出授权数量,请联系管理员。");
		}else if(loginCode.equals("8")){
			json.put("success", false);
			json.put("msg","wrong");
		}else if(loginCode.equals("10")){
			json.put("success", false);
			json.put("msg","用户超出设备邦定数量,请联系管理员。");
		}else if(loginCode.equals("7")){
			json.put("success", false);
			json.put("msg","用户未被授权访问系统,请联系管理员。");
		}else if(loginCode.equals("15")){
            json.put("success", false);
            json.put("msg","验证码错误，请重新输入。");
        }else{
			Node itcodeNode = doc.selectSingleNode("//param[@name=\"Username\"]/@value");
			String itcode="";
			if(itcodeNode!=null){
				itcode=itcodeNode.getStringValue();
			}
			json.put("success", true);
			json.put("itcode",itcode);
			json.put("data-authorize","succeed");
		}
	}catch(Exception e){
		e.printStackTrace();
		json.put("success", false);
		json.put("msg","登陆异常,请联系管理员11。");
		out.clear();
		out.print(json);
	}
	out.clear();
	out.print(json);
	System.out.println(json);
%>
