<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	
	<xsl:variable name="appdbpath"><xsl:value-of select="//input[@name='appdbpath']/@value"/></xsl:variable>
	<xsl:variable name="appformname"><xsl:value-of select="//input[@name='appformname']/@value"/></xsl:variable>
	
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		<html lang="zh_cn">
			<head>							
				
				
				<script src="/view/js/template.js"></script>

				<script>
					
					$(document).ready(function(){
						var hori=$.hori;
						/*设置标题*/
						hori.setHeaderTitle("单据");

					});		
					function viewfile(url){
								localStorage.setItem("attachmentUrl",url);
								$.hori.loadPage( $.hori.getconfig().serverBaseUrl+"viewhome/html/attachmentShowForm.html", $.hori.getconfig().serverBaseUrl+"viewhome/xml/AttachView.xml");
					}
							
				</script>
				
				<!-- 在ready时将动态表格HTML写入指定区域 -->
				<script>
					var dxTblhtml = "";
					$(document).bind("pageinit", function(){
						//alert($("#DhtmlxJsonData").val());
						//alert(dxTblhtml)
						if(dxTblhtml){
							$("#div_DTblHtml").html( dxTblhtml ).trigger('create');
						}
					});
				</script>
			</head>
			<body>
				<div id="notice" data-role="page">
					<div data-role="content" align="center">
										
						<!-- 支持的JSON格式如下，分head和data两部分，data中要对应head中的dataid -->
						<!-- {head: [{'title':'部门','dataid':'deptName'},{'title':'费用','dataid':'bmoney'},{'title':'申请人','dataid':'deptLeader'}],data: [{'id':1,'deptName':'公安业务部','deptCode':'BM_ZFSYB_GAYWB','bmoney':'444','deptLeader':'田龙岗(田龙岗)'}]} -->
						<script id="_dxTbl" type="text/html">
						<![CDATA[
							<% for (var i = 0; i < data.length; i ++) { %>
								<div data-role="collapsible" data-theme="a" data-content-theme="d">
									<h3>第<%= i+1 %>行</h3>
									<ul data-role="listview" data-inset="true" data-theme="d">
										<% for (var j = 0; j < head.length; j ++) { %>
											<li ><%= head[j].title %> ：<%= data[i][head[j].dataid] %></li>
										<% } %>
									</ul>
								</div>
							<% } %>
						]]>
						</script>				
				
						<xsl:if test="contains(//title/.,'手机办公平台')">
							<ul data-role="listview" data-inset="true" data-theme="d">		
								<li data-role="list-divider"><xsl:value-of select="//title/text()" /></li>								
								<li>
									<font color="red" size="4">应用单据被删除或未进行移动审批配置，请联系管理员。</font>														
								</li>
							</ul>
						</xsl:if>
						
						<xsl:if test="not(contains(//title/.,'手机办公平台'))">
							<strong><xsl:value-of select="//title/text()"/></strong>
							<ul data-role="listview" data-inset="true" data-theme="d">
								<li data-role="list-divider">基本信息</li>
								<li style="word-wrap:break-word">
									<xsl:if test="//textarea[@name='Fck_HTML']/p">
										<div style="width:100%;word-break:break-all;text-align:center;" align="center">
											<font size="4"><xsl:value-of select="//input[@id='InfoTitle']/@value"/></font>
											<hr/>
											<font size="2"><xsl:value-of select="//input[@id='InfoAuthor']/@value"/></font>
											
										</div>
										
										<div style="width:100%;text-align:left" align="left">
											
											<xsl:apply-templates select="//textarea[@name='Fck_HTML']/p[1]"/>
											
										</div>

									</xsl:if>
									<xsl:if test="//textarea[@name='RtfFieldConfig']/mobilefieldconfig//fieldentry">
									<!--
										<div style="width:100%;word-break:break-all;text-align:center;" align="center">
											<xsl:apply-templates select="//textarea[@name='RtfFieldConfig']/mobilefieldconfig/fieldentries/fieldentry"/>
										</div>
									-->
										<xsl:apply-templates select="//textarea[@name='RtfFieldConfig']/mobilefieldconfig/fieldentries/fieldentry"/>
									</xsl:if>								
								</li>
							</ul>
							
							<ul data-role="listview" data-inset="true" data-theme="d">
								<li data-role="list-divider">附件信息</li>
								<li>
									<xsl:if test="//input[@name='AttachInfo']/@value =''">
										无附件
									</xsl:if>
									<xsl:if test="//input[@name='AttachInfo']/@value !=''">

										<xsl:call-template name="files">
											<xsl:with-param name="names" select="//input[@name='AttachInfo']/@value"/>
										</xsl:call-template>
									</xsl:if>
								</li>	
							</ul>
							<ul data-role="listview" data-inset="true" data-theme="d">																
								<li data-role="list-divider">当前环节信息</li>
								<li>
									环节名称：<xsl:value-of select="//input[@name='TFCurNodeName']/@value" />
									<hr/>
									环节处理人：<xsl:value-of select="//input[@name='TFCurNodeAuthors']/@value" />
												<xsl:if test="//input[@name='TFCurNodeAuthors']/@value !=''">
													<xsl:value-of select="//input[@id='TFCurNodeOneDo']/@value" />
												</xsl:if>
								</li>
							
								<li data-role="list-divider">流转意见</li>
								<li>
									<xsl:if test="//textarea[@name='ThisFlowMindInfoLog']/flowmindinfo">
										<xsl:apply-templates select="//textarea[@name='ThisFlowMindInfoLog']/flowmindinfo/mindinfo" />
									</xsl:if>
									<xsl:if test="not(//textarea[@name='ThisFlowMindInfoLog']/flowmindinfo)">
										暂无审批意见
									</xsl:if>
								</li>
								
							</ul>
							<xsl:apply-templates select="//input[@type='hidden']" mode="hidden"/>
						</xsl:if>
					</div><!-- /content -->
				</div>
			</body>
		</html>
	</xsl:template>
	     
	<!-- 处理 基本信息 -->
	<xsl:template match="fieldentry">	
	
		<xsl:if test="not(@id='MTTABLE') and not(@id='ThisFlowMindInfoLog')">
			<xsl:if test="contains(@type, 'checkbox')">
				<xsl:if test="not(value/.='')">			
					<xsl:value-of select="@title" />
					<b>：</b>												
					<xsl:value-of select="value/."/>												
					<br/><hr/>
				</xsl:if>
			</xsl:if>
			<xsl:if test="not(contains(@type, 'checkbox'))">
				<xsl:if test="not(contains(@id, 'DynTbl_'))">		
					<xsl:value-of select="@title" />
					<b>：</b>												
					<xsl:value-of select="value/."/>												
					<br/><hr/>
				</xsl:if>
			</xsl:if>
		</xsl:if>
		<xsl:if test="@id='MTTABLE'">
			<li data-role="list-divider"><xsl:value-of select="@title" /></li>
			
			<li><xsl:apply-templates select="//span/textarea//table[@id='tblListC']" mode="t1"/></li>
		</xsl:if>
		
		<!-- 此处动态生成表格，ID为"DynTbl_XXX"，OA会自动获取XXX的值写到下面的input中 -->					
		<xsl:if test="contains(@id, 'DynTbl_')">
			<input type="hidden" id="{@id}" name="{@id}" value="{value/.}" />			
			
			<xsl:if test="($appdbpath='Application/cachetApp.nsf') and ($appformname='NewappFrom') ">			
				<li data-role="list-divider">文件明细</li>
				<li id="div_DTblHtml">无数据</li>
				
				<script>
					<![CDATA[
						var innerData = $("#DynTbl_RtfTableData_json").val();
						
						if($.trim(innerData)==""){
							innerData=[{}];
						}
						
						var jsondata = '{"head": [{"title":"文件名称","dataid":"column1"},{"title":"公章类型","dataid":"column2"},{"title":"公章所在地","dataid":"column3"},{"title":"公章管理员","dataid":"column4"},{"title":"份数","dataid":"column5"},{"title":"邮寄地址","dataid":"column6"},{"title":"备注","dataid":"column7"}],"data": ';
						jsondata = jsondata + innerData +'}';
						
						var jsonObj = $.parseJSON(jsondata);
						
						dxTblhtml = template.render("_dxTbl", jsonObj);
						
						//$("#div_DTblHtml").html( dxTblhtml ).trigger('create');
						
					]]>
				</script>
			</xsl:if>
			
		</xsl:if>
	</xsl:template>

	<xsl:template match="fieldentry" mode="mind">
		<xsl:apply-templates  mode="mind"/>	
	</xsl:template>
	
	<xsl:template match="value" mode="mind" >
		<xsl:copy-of select="." />
	</xsl:template>

	<!-- 处理 附件 -->	
	<xsl:template name="files">
		<xsl:param name="names"/>

		<xsl:if test="contains($names,';')">	
			<li><a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/Produce/DigiFlowMobile.nsf/0/{//input[@name='AttachDocUnid']/@value}/$file/{substring-before($names, ';')}');" data-role="button"><xsl:value-of select="substring-before($names, ';')"/></a></li>
			<xsl:call-template name="files">
				<xsl:with-param name="names" select="translate(substring-after($names, ';'), ' ', '')"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(contains($names, ';'))">
			<li><a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/Produce/DigiFlowMobile.nsf/0/{//input[@name='AttachDocUnid']/@value}/$file/{$names}');" data-role="button"><xsl:value-of select="$names"/></a></li>
		</xsl:if>		
	</xsl:template>

    <!-- 处理 流转意见 -->
	<xsl:template match="mindinfo">
		<div>
			<div style="width:100%" align="left">
				<xsl:copy-of select="." />
			</div>
			<div style="width:100%" align="left">
				<!--<xsl:value-of select="translate(@approver, '&quot;', '')"/> -->
				<label><xsl:value-of select="@approver"/></label>
				
				<xsl:value-of select="@flownodename"/>
					<xsl:if test="@optnameinfo !=''">
						<xsl:value-of select="@optnameinfo"/>
					</xsl:if>
				<br/>
				<xsl:value-of select="@approvetime"/>
			</div>
		</div>
		<hr/>
		
	</xsl:template>

	<xsl:template match="pre">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="br">
		<br/><xsl:text>&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>
	</xsl:template>

	<xsl:template match="p">
		<br/><xsl:text>&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text><xsl:apply-templates />
		<br/>
	</xsl:template>

	<!-- 处理 基本信息table -->
	<xsl:template match="table" mode="t1" >	
		<xsl:apply-templates  mode="t1"/>	
	</xsl:template>	
	
	<xsl:template match="tbody" mode="t1" >	
		<xsl:apply-templates  mode="t1"/>	
	</xsl:template>

	 <xsl:template match="tr" mode="t1" >
		<xsl:variable name="num" select="position()"/>

		  <xsl:if test="$num!=1">
			<li><xsl:apply-templates  mode="t1"/></li>
		 </xsl:if>
		

	</xsl:template>

	 <xsl:template match="td" mode="t1" >	
		<xsl:variable name="n" select="position()"/>
		<xsl:value-of select="../../tr[1]/td[$n]"/>:
		<xsl:value-of select="text()"/>
		<br/>
	</xsl:template>


	 <xsl:template match="textarea" mode="c1" >	
		<xsl:apply-templates mode="c1"/>
	</xsl:template>
	 <xsl:template match="p" mode="c1" >	
		<xsl:apply-templates mode="c1"/>
	</xsl:template>
	 <xsl:template match="span" mode="c1" >	
		<xsl:apply-templates mode="c1"/>
	</xsl:template>
	<xsl:template match="br" mode="c1" >	
		<br/>
	</xsl:template>
	<xsl:template match="text()" mode="c1">
		<xsl:value-of select="."/>
	</xsl:template>
</xsl:stylesheet>
