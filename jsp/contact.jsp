<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page language="java" import="cc.movein.mda.system.control.Query"%>
<%@ page language="java" import="org.json.*"%>


<%@ page language="java" import="org.dom4j.Document"%>
<%@ page language="java" import="org.dom4j.DocumentException"%>
<%@ page language="java" import="org.dom4j.Element"%>
<%@ page language="java" import="org.dom4j.Node"%>
<%@ page language="java" import="org.dom4j.DocumentHelper"%>
<%@ page language="java" import="java.util.List"%>
<%@ page language="java" import="java.util.Iterator"%>
<%@ page language="java" import="org.apache.commons.lang.StringEscapeUtils"%>

				<%
				JSONArray taskArray=new JSONArray();
				JSONObject taskJson=new JSONObject();	
				Query q = Query.getInstance(request);
				String responseXml = q.getContent();
				System.out.println(responseXml);
				Document   doc = DocumentHelper.parseText(responseXml);
				System.out.println("========================================================================");
				List contactList=doc.selectNodes("//table[@class='table1']//tr");
				
				//第一个tr是标题，所以个数减一是真是数据
				int contactNumber=contactList.size()-1;  
				
				for(int i=1;i<contactList.size();i++){
					Element contactInfo=(Element)contactList.get(i);
					JSONObject json=new JSONObject();
					//ITCode
					Node ITCode=(Node)contactInfo.selectSingleNode("./td[1]");
				
					//System.out.println("userName="+userName.asXML());
					//System.out.println("userName111="+userName.getText());
					//员工编号
					Node dialNumber=contactInfo.selectSingleNode("./td[3]");		
					
					//用户名
					Node userName=contactInfo.selectSingleNode("./td[2]");		
					
					//移动电话
					Node telNumber=contactInfo.selectSingleNode("./td[4]");
					//办公电话
					Node officeNumber=contactInfo.selectSingleNode("./td[5]");	
				
		
										
					json.put("ITCode",ITCode.getStringValue());
					json.put("userName",userName.getStringValue());
					json.put("telNumber",telNumber.getStringValue());
					json.put("dialNumber",dialNumber.getStringValue());
					json.put("officeNumber",officeNumber.getStringValue());
					
					taskArray.put(json);
					
				}
				taskJson.put("contactNumber", String.valueOf(contactNumber));		
				taskJson.put("contactlist",taskArray);
			
				out.clear();

				out.print(taskJson);

				System.out.println(taskJson);
				
				%>
				