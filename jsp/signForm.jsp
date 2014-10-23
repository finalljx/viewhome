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
				List contactList=doc.selectNodes("//table[@class='table1']//tr");
				//第一个tr是标题，所以个数减一是真是数据
				int contactNumber=contactList.size()-1;  
				
				for(int i=1;i<contactList.size();i++){
					Element contactInfo=(Element)contactList.get(i);
					JSONObject json=new JSONObject();
					//用户名
					Node userName=(Node)contactInfo.selectSingleNode("./td[1]");
					System.out.println("userName="+userName.asXML());
					System.out.println("userName111="+userName.getText());
					//部门名称
					Node deptName=contactInfo.selectSingleNode("./td[3]");		
					
					//移动电话
					Node telNumber=contactInfo.selectSingleNode("./td[4]");
					//办公电话
					Node officeNumber=contactInfo.selectSingleNode("./td[5]");	
					//邮箱
					Node mail=contactInfo.selectSingleNode("./td[6]");	
										
					json.put("userName",userName.getStringValue());
					json.put("deptName",deptName.getStringValue());
					json.put("telNumber",telNumber.getStringValue());
					json.put("dialNumber",telNumber.getStringValue());
					json.put("officeNumber",officeNumber.getStringValue());
					json.put("mail",mail.getStringValue());
					json.put("mailto",mail.getStringValue());
					taskArray.put(json);
					
				}
				taskJson.put("contactNumber", String.valueOf(contactNumber));		
				taskJson.put("contactlist",taskArray);
			
				out.clear();

				out.print(taskJson);

				System.out.println(taskJson);
				
				%>
				