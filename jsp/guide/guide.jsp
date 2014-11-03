<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page language="java" import="cc.movein.mda.system.control.Query"%>
<%@ page language="java" import="java.util.*"%>
<%
    Query q = Query.getInstance(request);
    String responseXml = q.getContent();
    out.clear();
    out.print(responseXml);
%>