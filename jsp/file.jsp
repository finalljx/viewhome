<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="cc.movein.mda.system.control.Query"%>
<%@ page language="java" import="org.json.*"%>

<%@ page language="java" import="org.dom4j.Document"%>;
<%@ page language="java" import="org.dom4j.DocumentException"%>;
<%@ page language="java" import="org.dom4j.Element"%>;
<%@ page language="java" import="org.dom4j.Node"%>;
<%@ page language="java" import="org.dom4j.DocumentHelper"%>;
<%@ page language="java" import="java.util.List"%>;
<%@ page language="java" import="java.util.Iterator"%>;
<%@ page language="java"
	import="org.apache.commons.lang.StringEscapeUtils"%>;

<%
				JSONObject json = new JSONObject();
				Query q = Query.getInstance(request);
				
				String path = q.getContent();
				System.out.print(path);
				
				path = path.replace("\\", "/");
				String type = q.getContentType();
				boolean ispage = false;
			
				int total=0;
		
				if(type.indexOf("image")!=-1){
					path="/view"+path;
				
				}else if(type.indexOf(".png")!=-1 || type.indexOf(".jpg")!=-1){
					path="/view"+path;					
				}else if(type.indexOf("text/")!=-1){					
					
						if(path.indexOf("<data-params>")==-1){
							
						}else{
							path=path.substring(0, path.indexOf("<data-params>"));
						}
						
				}else if(type.indexOf("application/vnd")!=-1 || type.indexOf("application/pdf")!=-1 || type.indexOf("application/msword")!=-1 || type.indexOf("application/octet-stream")!=-1 || type.indexOf("application/vnd.ms-powerpoint")!=-1){
					ispage = true;
					path = q.getRequest().getRequestURI() + "?data-page=1";
				}
				
						
				total=q.getPageSize();
				
				json.put("total",total);
				json.put("path",path);
		
				out.clear();
				out.println(json);
			%>
