<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="cn.com.genertec.mobile.office.dao.MobilePeriodicalDao"%>
<%@ page import="java.util.*"%>
<%@ page
	import="cn.com.horitech.mobile.platform.common.tools.JacksonHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String year = request.getParameter("year");
	WebApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(this
			.getServletContext());
	MobilePeriodicalDao dao = (MobilePeriodicalDao) context.getBean("mobilePeriodicalDao");
	List<Map> list = new ArrayList();
	if (year != null && !year.equals("")) { //年份不为空
		list = dao.findPeriodicalList(year);
	} else {
		list = dao.findPeriodicalList(null);
	}
	out.clear();
	out.print(JacksonHelper.toJson(list));
%>