<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page
	import="cn.com.genertec.mobile.office.dao.MobileUserPermissionDao"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.com.horitech.mobile.platform.common.tools.JacksonHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    String user = request.getParameter("it_code");
	WebApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(this
			.getServletContext());
	MobileUserPermissionDao dao = (MobileUserPermissionDao) context.getBean("mobileUserPermissionDao");
	List<Map> list = dao.findUserPermission(user);
	out.clear();
	out.print(JacksonHelper.toJson(list));
%>