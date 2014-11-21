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
		// {"user_name":"geyuxi","rtn_code":"2000","rtn_msg":"用户名密码验证通过"} 
		//{"user_name":"","rtn_code":"2001","rtn_msg":"登录密码错误"} 
		if(loginCode.equals("9")){
			json.put("success", false);
			json.put("msg","用户超出授权数量,请联系管理员。");
		}else if(loginCode.equals("8")){
			json.put("success", false);
			json.put("msg","用户名或密码错误。");
		}else if(loginCode.equals("10")){
			json.put("success", false);
			json.put("msg","用户超出设备邦定数量,请联系管理员。");
		}else if(loginCode.equals("7")){
			json.put("success", false);
			json.put("msg","用户未被授权访问系统,请联系管理员。");
		}else if(loginCode.equals("15")){
            json.put("success", false);
            json.put("msg","验证码错误，请重新输入。");
        }else if(responseXml.contains("登录密码错误")){
			json.put("success", false);
			json.put("msg","登录密码错误");
		}else if(responseXml.contains("用户账号错误")){
			json.put("success", false);
			json.put("msg","用户账号错误");
		}else{
			json.put("success", true);
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
