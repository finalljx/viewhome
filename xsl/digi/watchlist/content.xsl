<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dxmlf="http://www.datypic.com/xmlf"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:local="http://www.datypic.com/local"
                 xmlns:functx="http://www.functx.com"  
                exclude-result-prefixes="dxmlf xs" version="2.0">

	<xsl:function name="functx:trim" as="xs:string" xmlns:functx="http://www.functx.com">
  		<xsl:param name="arg" as="xs:string?"/>
  		<xsl:sequence select="  replace(replace($arg,'\s+$',''),'^\s+','') "/>

	</xsl:function>
	<xsl:function name="functx:left-trim" as="xs:string" xmlns:functx="http://www.functx.com" >
		<xsl:param name="arg" as="xs:string?"/>

		<xsl:sequence select="replace($arg,'^\s+','')"/>

</xsl:function>

	<xsl:variable name="appdbpath"><xsl:value-of select="//input[@name='appdbpath']/@value"/></xsl:variable>
	<xsl:variable name="appformname"><xsl:value-of select="//input[@name='appformname']/@value"/></xsl:variable>
	<xsl:variable name="appNodeId"><xsl:value-of select="//input[@name='TFCurNodeID']/@value"/></xsl:variable>

	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
	
	

		<html lang="zh_cn">
			<head>							
			

				<!-- 在ready时将动态表格HTML写入指定区域 -->
				<script>
					<![CDATA[
						var dxTblhtml = "";
						$(document).bind("pageinit", function(){
							
							initDthml();
							
						});

						function initDthml(){
							
							var table_data=$("#DynTbl_RtfTableData_json").val();
							
							var table_head=$("#DynTbl_RtfTableData_head").val();
							
											
							if(table_head!==undefined && table_data!==undefined){
								table_data=table_data.replace(/\s/g,"");
								table_head=table_head.replace(/\s/g,"");
								var jsonObj={};							
								var table_head_obj=$.parseJSON(table_head);								
								var table_data_obj=$.parseJSON(table_data);								
								jsonObj.head=table_head_obj;
								jsonObj.data=table_data_obj;
								dxTblhtml = template.render("_dxTbl", jsonObj);
								if(window.console!==undefined){
									console.log(JSON.stringify(jsonObj));
								}
								
								$("#div_DTblHtml").html( dxTblhtml ).trigger('create');

							}else{
								//$("#ul_dtable_list").hide();
							}
						}
					]]>
				</script>

				
				<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
			</head>
			<body>
				<div id="notice" data-role="page">
					
					<div data-role="content" align="center">
						<script>
							<![CDATA[
												
							function viewfile(url){
						
								var attachUrl=url.replace(/&nbsp;/g," ");
								localStorage.setItem("attachmentUrl",attachUrl);

							
								$.hori.loadPage( $.hori.getconfig().serverBaseUrl+"viewhome/html/attachmentShowForm.html", $.hori.getconfig().serverBaseUrl+"viewhome/xml/AttachView.xml");
							}

							


							
						]]>
						
						</script>
						
						<!-- 支持的JSON格式如下，分head和data两部分，data中要对应head中的dataid -->
						<!-- {head: [{'title':'部门','dataid':'deptName'},{'title':'费用','dataid':'bmoney'},{'title':'申请人','dataid':'deptLeader'}],data: [{'id':1,'deptName':'公安业务部','deptCode':'BM_ZFSYB_GAYWB','bmoney':'444','deptLeader':'田龙岗(田龙岗)'}]} -->
						<script id="_dxTbl" type="text/html">
						<![CDATA[
							<% for (var i = 0; i < data.length; i ++) { %>
									<ul data-role="listview" data-inset="true" data-theme="d">
										<% for (var j = 0; j < head.length; j ++) { %>
											<li ><%= head[j].title %> ：<%= data[i][head[j].dataid] %></li>
										<% } %>
									</ul>
							<% } %>
						]]>
						</script>

						<div data-role="content">
							<xsl:if test="not(//div[@name='Fck_HTML']//fieldentry)">
								<ul data-role="listview" data-inset="true" data-theme="f">
									<li data-role="list-divider"><xsl:value-of select="//title/text()" /></li>							
									<li>
										<font color="red" size="4">应用单据被删除或未进行移动审批配置，请联系管理员。</font>														
									</li>
								</ul>
							</xsl:if>
							
							<xsl:if test="(//div[@name='Fck_HTML']//fieldentry)">
								<h3><xsl:value-of select="//title/." /></h3>
								<ul data-role="listview" data-inset="true" data-theme="d" id="ul_dtable_list">
									<li data-role="list-divider">值班信息</li>

									<li id="div_DTblHtml">无数据</li>

								</ul>
								<ul data-role="listview" data-inset="true" data-theme="d">
									<li data-role="list-divider">节假日期间生产安排情况</li>
								
									<li><xsl:value-of select="//fieldentry[@id='HolSit']/value/."/></li>
								</ul>
								<ul data-role="listview" data-inset="true" data-theme="d">
									<li data-role="list-divider">安全保证措施</li>
								
									<li><xsl:value-of select="//fieldentry[@id='Safety']/value/."/></li>
								</ul>
								<!-- <ul data-role="listview" data-inset="true" data-theme="d">
									<li data-role="list-divider">附件信息</li>
									<xsl:if test="//input[@name='AttachInfo']/@value =''">
									<li>
										无附件
									</li>	
									</xsl:if>
									<xsl:if test="//input[@name='AttachInfo']/@value !=''">
										<xsl:call-template name="file">
											<xsl:with-param name="info" select="//input[@name='AttachInfo']/@value"/>
										</xsl:call-template>
									</xsl:if>
								</ul> -->


							</xsl:if>						
						</div>
						
						
						<xsl:apply-templates select="//input[@type='hidden']" mode="hidden"/>
					</div><!-- /content -->
				</div>		
							
			</body>
		</html>
	</xsl:template>
	<xsl:template name="flows">
		<xsl:param name="flows"/>

		<xsl:param name="alreadyflowids"/>	
		<xsl:variable name="alreadyflowidstr" select="concat($alreadyflowids,'#')" />

		<xsl:variable name="flowid">
			<xsl:choose>
				<xsl:when test="substring-after($flows, ';')!=''"><xsl:value-of select="substring-after(substring-before($flows, ';'), '/')"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="substring-after($flows, '/')"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="flowidstr" select="concat($flowid,'#')" />

		<xsl:variable name="flowname">
			<xsl:choose>
				<xsl:when test="substring-after($flows, ';')!=''"><xsl:value-of select="substring-before(substring-before($flows, ';'), '/')"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="substring-before($flows, '/')"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="alreadyflowidstr" select="concat($alreadyflowidstr,$flowid)" />

		<xsl:if test="not(contains($alreadyflowidstr, $flowidstr))">
			<input type="radio" name="radio-choice" id="radio-choice-{$flowid}" value="{$flowid}" onclick="post('reject', this.value,'yes','确定要驳回到{$flowname}环节吗？');" />

     		<label for="radio-choice-{$flowid}"><xsl:value-of select="$flowname"/></label>
		</xsl:if>

		<xsl:if test="substring-after($flows, ';')!=''">
			<xsl:call-template name="flows">
				<xsl:with-param name="flows" select="substring-after($flows, ';')"/>
				<xsl:with-param name="alreadyflowids" select="$alreadyflowidstr" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	

	<xsl:template name="file">
		<xsl:param name="info" />
		<li>
		<xsl:choose>
			<xsl:when test="contains($info, ';')">
				<a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/Produce/DigiFlowMobile.nsf/0/{//input[@name='AttachDocUnid']/@value}/$file/{functx:left-trim(substring-before($info, ';'))}');"  data-role="button"><xsl:value-of select="functx:left-trim(substring-before($info, ';'))"/></a>
				<xsl:call-template name="file">
					<xsl:with-param name="info" select="substring-after($info, ';')"/>
				</xsl:call-template>
			</xsl:when>

		
			<xsl:otherwise>
				<a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/Produce/DigiFlowMobile.nsf/0/{//input[@name='AttachDocUnid']/@value}/$file/{functx:left-trim($info)}');"  data-role="button"><xsl:value-of select="$info"/></a>
			</xsl:otherwise>
		</xsl:choose>
		</li>
	</xsl:template>

	
	<!-- 处理 基本信息 -->
	<xsl:template match="fieldentry">
			<xsl:variable name="sub">rtfmobile<xsl:value-of select="@name"/></xsl:variable>
			<xsl:choose>
				<xsl:when test="@type='table'">				
					<div style='text-align:center;'><xsl:value-of select="@title" /></div>
					<div style='padding-left:10px;'><xsl:apply-templates select="//textarea[@name=$sub]" mode="bx"/></div>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="contains(@id, 'HolSit')">
						<li>
						　　<xsl:value-of select="value/."/>
						</li>
					</xsl:if>
				</xsl:otherwise>

			</xsl:choose>	

			<!-- 处理分支  substring-after(substring-before($flows, ';'), '/')-->
			<xsl:if test="contains(@id, 'ToNodeId')">
				<select id="toflownodeid" name="toflownodeid" onChange='' data-theme="b" >
					
				</select>
			</xsl:if>
			<xsl:if test="contains(@id, 'DynTbl_')">
				<input type="hidden" id="{@id}" name="{@id}" value="{value/.}" />			
			</xsl:if>
			
			
		
	</xsl:template>
	<xsl:template name="flownodes">
		<xsl:if test="@id='MTTABLE'">
			<ul data-role="listview" data-inset="true" data-theme="d">
				<li data-role="list-divider"><xsl:value-of select="@title" /></li>			
				<li><xsl:apply-templates select="//div[@name='Fck_HTML']//table[@id='tblListC']" mode="t1"/></li>
			</ul>
		</xsl:if>
					
		
	</xsl:template>

	<xsl:template match="fieldentry" mode="mind">
		<xsl:apply-templates  mode="mind"/>	
	</xsl:template>
	
	<xsl:template match="value" mode="mind" >
		<xsl:copy-of select="." />
	</xsl:template>
	
	<!-- 处理 流转意见 -->
	<xsl:template match="mindinfo">
	
		处理人<b>:</b><xsl:value-of select="translate(@approver, '&quot;', '')"/>
		<br/>
		审批时间<b>:</b><xsl:value-of select="@approvetime"/>
		<br/>

		审批环节<b>:</b>
		<xsl:value-of select="@flownodename"/>
			<xsl:if test="@optnameinfo !=''">
				(<xsl:value-of select="@optnameinfo"/>)
			</xsl:if>
		
		<br/>
		审批意见<b>:</b><xsl:value-of select="text()"/>
		<br/>

		<hr/>		
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
	
	<xsl:template match="input" mode="hidden">
		<input type="hidden" id="{@name}" name="{@name}" value="{@value}" />
	</xsl:template>
	
	<xsl:template match="tr" mode="option">
		<div style="width;100%" align="left"><xsl:value-of select="td[4]/."/></div>
		<div style="width;100%" align="right">
			<xsl:value-of select="td[1]/."/><br/>
			<xsl:value-of select="td[2]/."/><br/>
			<xsl:value-of select="td[3]/."/><br/>
		</div>
		<hr/>
	</xsl:template>


	<!-- 表单批量格式化模版 -->
	<!-- variable of $mini and $aliasname at mdp.xsl -->
	<xsl:template match="table" mode="c1">
		<xsl:apply-templates mode="c2"/>
	</xsl:template>

	<xsl:template match="tbody" mode="c2">
		<xsl:apply-templates mode="c2"/>
	</xsl:template>

	<xsl:template match="tr" mode="c2">
		<div style="width:100%" align="left">
			<xsl:attribute name="align">
				<xsl:if test="not(position()=1 or position()=3)">left</xsl:if>
			</xsl:attribute>
			<xsl:apply-templates mode="c3"/>
		</div>
		<hr color="gray"/>
	</xsl:template>

	<xsl:template match="td" mode="c3">
		<xsl:if test=".!=''">
			<xsl:if test="not(@style) or not(contains(@style, 'display:none'))">
				<!-- 发文红色字体特殊处理 -->
				<xsl:choose>
					<xsl:when test="position()=1">
						<span style="width:38%;display:inline-block;text-align:right"><font color="red"><xsl:value-of select="."/>
							<xsl:if test="not(contains(., ':'))">:</xsl:if>
						</font></span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates mode="c4"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="position()=2">
					<br/>
				</xsl:if>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="text()" mode="c4">
		<xsl:value-of select="."/>
	</xsl:template>
	
	<xsl:template match="q" mode="c4">
		<xsl:apply-templates mode="c4"/>
	</xsl:template>
	
	<xsl:template match="b" mode="c4">
		<xsl:if test="normalize-space(.)!=''">
			<strong><xsl:apply-templates mode="c4"/></strong>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="center" mode="c4">
		<span width="100%" align="center" mode="c4">
			<xsl:apply-templates mode="c4"/>
		</span>
	</xsl:template>
	
	<xsl:template match="font" mode="c4">
		<font>
			<xsl:apply-templates mode="c4"/>
		</font>
	</xsl:template>
	
	<xsl:template match="input" mode="c4">
		<xsl:value-of select="@value"/>
	</xsl:template>
	
	<xsl:template match="select" mode="c4">
		<xsl:if test="starts-with(@name, 'fld')">
			<xsl:value-of select="option[@selected='selected']/text()"/>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="textarea" mode="c4">
		<xsl:value-of select="text()"/>
	</xsl:template>
	
	<xsl:template match="hr" mode="c4">
		<hr size="{@size}">
			<xsl:attribute name="color">
				<xsl:call-template name="color">
					<xsl:with-param name="name"><xsl:value-of select="@color" /></xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
		</hr>
	</xsl:template>
	
	<xsl:template match="div" mode="c4">
		<xsl:apply-templates mode="c4" />
	</xsl:template>
	
	<xsl:template match="img" mode="c4">
	</xsl:template>
	
	<xsl:template name="color">
		<xsl:param name="name" />
		<xsl:choose>
			<xsl:when test="@color='red'">
				<xsl:text>#FF0000</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>#FF0000</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


</xsl:stylesheet>
