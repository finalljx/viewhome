<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="cn.com.genertec.mobile.office.dao.MobileLDAPAuthDao"%>
<%@ page import="java.util.*"%>
<%@ page
	import="cn.com.horitech.mobile.platform.common.tools.JacksonHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String user = request.getParameter("it_code");
	String pwd = request.getParameter("pwd");
	WebApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(this
			.getServletContext());
	MobileLDAPAuthDao dao = (MobileLDAPAuthDao) context.getBean("mobileLDAPAuthDao");
	Map<String, Boolean> result = dao.hasLDAPInfo(user, pwd);
	out.clear();
	out.print(JacksonHelper.toJson(result));
%>