<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
	<xsl:variable name="appdbpath">
		<xsl:value-of select="//input[@name='appdbpath']/@value" />
	</xsl:variable>
	<xsl:variable name="appformname">
		<xsl:value-of select="//input[@name='appformname']/@value" />
	</xsl:variable>
	<xsl:variable name="flownodeid">
		<xsl:value-of select="//input[@name='TFCurNodeID']/@value" />
	</xsl:variable>
	<xsl:variable name="flownodeidpanduan">
		<xsl:value-of select="concat(//input[@name='TFCurNodeID']/@value,';')" />
	</xsl:variable>
	<xsl:output method="html" indent="yes" />
	<xsl:template match="/">
		<html lang="zh_cn">
			<head>
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />
				<script>
				<![CDATA[
					$(document).ready(function(){
						var hori=$.hori;
					});
			
  		]]>
				</script>
				<style>
					.ui-bar-b{border: 0px;background-image: linear-gradient( #c4d9ef , #c4d9ef );}
					.ui-collapsible-heading-toggle {
						border: 1px solid #c4d9ef /*{c-bup-border}*/;
						background-image: linear-gradient( #c4d9ef /*{c-bup-background-start}*/, #c4d9ef /*{c-bup-background-end}*/);
					}
				</style>
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />
			</head>
			<body>
				<div id="notice" data-role="page">

					<div data-role="content" align="center">
						<script>
							<![CDATA[
							//viewfile 附件函数
							//function viewfile(url){
								//localStorage.setItem("attachmentUrl",url);
								//$.hori.loadPage( $.hori.getconfig().serverBaseUrl+"viewhome/html/attachmentShowForm.html", $.hori.getconfig().serverBaseUrl+"viewhome/xml/AttachView.xml");
							//}
							]]>
						</script>

						<!-- <h3>
							<xsl:value-of select="//title/text()" />
						</h3> -->
						<div style="display:none">
							<textarea id="jsonv">
								<xsl:value-of select="//fieldentry[@id='TravelInfo']/value/." />
							</textarea>
						</div>
						<!-- <div><a data-role="button" value="reject" onclick="searchPerson();" 
							data-mini='true' data-theme="f">选人</a></div> -->
						<ul data-role="listview" data-inset="true" data-theme="d"
							style="word-wrap:break-word">
							<li data-role="list-divider" class="fontdividerstyle">基本信息</li>
							<li class="fontstyle">
								<xsl:if test="not(//div[@name='Fck_HTML']//fieldentry)">
									<font color="red" size="3">应用单据被删除或未进行移动审批配置，请联系管理员。</font>
								</xsl:if>
								标题：<xsl:value-of select="//title/text()" /><br/><hr/>
								<xsl:apply-templates select="//div[@name='Fck_HTML']//fieldentry" />
							</li>



							<li data-role="list-divider" class="word" style="color: black;font-size: 16px;font-family: Microsoft YaHei;text-shadow: none;">正文内容</li>
							<li data-bind="foreach: word" id="word" class="word">
								<a data-role="button" data-bind="click:viewfile">
									<span text-align="center" data-bind="text: name" style="color:#265b93;font-size: 15px;font-family: Microsoft YaHei;"></span>
								</a>
							</li>

							<li data-role="list-divider" class="fontdividerstyle">附件信息</li>
							<li data-bind="foreach: attachment" id="attachment" data-icon="false" style="background: #ffffff;">
								<a data-bind="click:viewfile">
									<span  data-bind="text: number" style="color:#265b93;font-size: 15px;font-family: Microsoft YaHei;"/>
									<span id="filenumber" style="color:#265b93;">.</span>
									<span  data-bind="text: name" style="white-space: pre-wrap;color:#265b93;font-size: 15px;font-family: Microsoft YaHei;"></span>
								</a>
							</li>
							<li data-role="list-divider" class="fontdividerstyle">当前环节信息</li>
							<li class="fontstyle">
								环节名称：
								<xsl:value-of select="//input[@name='TFCurNodeName']/@value" />
								<hr />
								环节处理人：
								<xsl:value-of select="//input[@name='TFCurNodeAuthorsCN']/@value" />
								<xsl:value-of select="//input[@id='TFCurNodeOneDo']/@value" />
							</li>
						

						</ul>
						<div data-role="collapsible" data-collapsed="true" data-theme="f" data-content-theme="d" class="ui-collapsible ui-collapsible-inset ui-corner-all ui-collapsible-themed-content">
							<h1 class="ui-collapsible-heading">
								<a href="#" class="ui-collapsible-heading-toggle ui-btn-up-f" style="color: white;">
									<span class="ui-btn-text" style="color: black;font-size: 16px;font-family: Microsoft YaHei;text-shadow: none;">流转意见</span>
									</a>
							</h1>
							<div>
								<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word" class="ui-listview ui-listview-inset ui-corner-all ui-shadow">
									<li class="ui-li ui-li-static ui-btn-up-d ui-first-child ui-last-child" style="font-size: 15px;font-family: Microsoft YaHei;">
								<xsl:if test="//textarea[@name='ThisFlowMindInfoLog']/flowmindinfo">
									<xsl:apply-templates
										select="//textarea[@name='ThisFlowMindInfoLog']/flowmindinfo/mindinfo" />
								</xsl:if>
								<xsl:if test="not(//textarea[@name='ThisFlowMindInfoLog']/flowmindinfo) and //textarea[@name='ThisFlowMindInfoLog']!=''">
								   <xsl:call-template name="mindinfo">
								      <xsl:with-param name="mindinfo" select="//textarea[@name='ThisFlowMindInfoLog']/."></xsl:with-param>
								      <xsl:with-param name="uninfo" select="substring-before(//textarea[@name='ThisFlowMindInfoLog']/.,'处')"></xsl:with-param>
								   </xsl:call-template>
								</xsl:if>
								<xsl:if
									test="not(//textarea[@name='ThisFlowMindInfoLog']/flowmindinfo) and //textarea[@name='ThisFlowMindInfoLog']=''">
									暂无审批意见
								</xsl:if>
							</li>
									
									
								</ul>
							</div>
						</div>
						
						<xsl:apply-templates select="//input[@type='hidden' or not(@type)]"
							mode="hidden" />
					</div><!-- /content -->
				</div>
			</body>
		</html>
	</xsl:template>

	<!-- 驳回选关 -->
	<xsl:template name="flows">
		<xsl:param name="flows" />

		<xsl:param name="alreadyflowids" />
		<xsl:variable name="alreadyflowidstr" select="concat($alreadyflowids,'#')" />

		<xsl:variable name="flowid">
			<xsl:choose>
				<xsl:when test="substring-after($flows, ';')!=''">
					<xsl:value-of select="substring-after(substring-before($flows, ';'), '/')" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring-after($flows, '/')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="flowidstr" select="concat($flowid,'#')" />

		<xsl:variable name="flowname">
			<xsl:choose>
				<xsl:when test="substring-after($flows, ';')!=''">
					<xsl:value-of
						select="substring-before(substring-before($flows, ';'), '/')" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring-before($flows, '/')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="alreadyflowidstr" select="concat($alreadyflowidstr,$flowid)" />

		<xsl:if test="not(contains($alreadyflowidstr, $flowidstr))">
			<input type="radio" name="radio-choice" id="radio-choice-{$flowid}"
				value="{$flowid}" onclick="post('reject', this.value,'yes','确定要驳回到{$flowname}环节吗？');" />

			<label for="radio-choice-{$flowid}">
				<xsl:value-of select="$flowname" />
			</label>
		</xsl:if>

		<xsl:if test="substring-after($flows, ';')!=''">
			<xsl:call-template name="flows">
				<xsl:with-param name="flows" select="substring-after($flows, ';')" />
				<xsl:with-param name="alreadyflowids" select="$alreadyflowidstr" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<!-- 特殊格式的流转意见处理 -->
	<xsl:template name="mindinfo">
	 <xsl:param name="mindinfo"/>
	 <xsl:param name="uninfo"/>
	 <xsl:variable name="newmindinfo" select="substring-after($mindinfo,$uninfo)"></xsl:variable>
	 <xsl:choose>
	    <xsl:when test="contains($newmindinfo,$uninfo)">
	        <xsl:value-of select="substring-before($newmindinfo,$uninfo)"/>
	        <br/><hr/>
	        <xsl:call-template name="mindinfo">
	            <xsl:with-param name="mindinfo" select="$newmindinfo"/>
	            <xsl:with-param name="uninfo" select="$uninfo"/>
	        </xsl:call-template>
	    </xsl:when>
	    <xsl:otherwise>
	     <xsl:value-of select="$newmindinfo"></xsl:value-of>
	        <br/><hr/>
	    </xsl:otherwise>
	 </xsl:choose> 
	</xsl:template>

	<!-- 处理 流转意见 -->
	<xsl:template match="mindinfo">
		<div style="line-height: 1.5em;">
			<div style="width:100%" align="left">
				审批意见:<xsl:copy-of select="." />
			</div>
			<div style="width:100%" align="left">
				<label>
					处理人(环节):<xsl:value-of select="translate(@approver, '&quot;', '')" />
				</label>
				(<xsl:value-of select="@flownodename" />)
				<xsl:if test="@optnameinfo !=''">
					(<xsl:value-of select="@optnameinfo" />)
				</xsl:if>

				<br />
				时间:<xsl:value-of select="@approvetime" />
			</div>
		</div>
		<hr />

	</xsl:template>

	<!-- 处理 附件（目前前仅支持单个附件） -->
	<xsl:template name="file">
		<xsl:param name="info" />
		<li>
			<xsl:choose>
				<xsl:when test="contains($info, ';')">
					<a href="javascript:void(0)"
						onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/Produce/DigiFlowMobile.nsf/0/{//input[@name='AttachDocUnid']/@value}/$file/{substring-before($info, '(')}');"
						data-role="button">
						<xsl:variable name="zhengwen">
							<xsl:value-of select="substring-before($info, '(')" />
						</xsl:variable>
						<xsl:if test="$zhengwen = 'zhengwen.doc'">
							查看正文
						</xsl:if>
						<xsl:if test="$zhengwen != 'zhengwen.doc'">
							<xsl:value-of select="substring-before($info, '(')" />
						</xsl:if>
					</a>
					<xsl:call-template name="file">
						<xsl:with-param name="info" select="substring-after($info, ';')" />
					</xsl:call-template>
				</xsl:when>

				<xsl:when test="contains($info, '(')">
					<a href="javascript:void(0)"
						onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/Produce/DigiFlowMobile.nsf/0/{//input[@name='AttachDocUnid']/@value}/$file/{substring-before($info, '(')}');"
						data-role="button">
						<xsl:variable name="zhengwen">
							<xsl:value-of select="substring-before($info, '(')" />
						</xsl:variable>
						<xsl:if test="$zhengwen = 'zhengwen.doc'">
							查看正文
						</xsl:if>
						<xsl:if test="$zhengwen != 'zhengwen.doc'">
							<xsl:value-of select="substring-before($info, '(')" />
						</xsl:if>
					</a>

				</xsl:when>
				<xsl:otherwise>
					<a href="javascript:void(0)"
						onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/Produce/DigiFlowMobile.nsf/0/{//input[@name='AttachDocUnid']/@value}/$file/{$info}');"
						data-role="button">
						<xsl:variable name="zhengwen">
							<xsl:value-of select="$info" />
						</xsl:variable>
						<xsl:if test="$zhengwen = 'zhengwen.doc'">
							查看正文
						</xsl:if>
						<xsl:if test="$zhengwen != 'zhengwen.doc'">
							<xsl:value-of select="$info" />
						</xsl:if>
					</a>
				</xsl:otherwise>
			</xsl:choose>
		</li>
	</xsl:template>

	<!-- 处理 基本信息 -->
	<xsl:template match="fieldentry">
		<xsl:variable name="sub">
			rtfmobile
			<xsl:value-of select="@name" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="@type='table'">
				<div style='text-align:center;'>
					<xsl:value-of select="@title" />
				</div>
				<div style='padding-left:10px;'>
					<xsl:apply-templates select="//textarea[@name=$sub]"
						mode="bx" />
				</div>
			</xsl:when>

			<!-- 新加了这个radio -->
			<xsl:when test="@type='radio'">
				<xsl:variable name="radioVal">
					<xsl:value-of select="concat('|',value/.)" />
				</xsl:variable>
				<xsl:variable name="radioTxt">
					<xsl:value-of select="substring-before(text/., $radioVal)" />
				</xsl:variable>
				<xsl:value-of select="@title" />
				<b>：</b>

				<xsl:if test="contains($radioTxt, ';')">
					<xsl:variable name="radioTxt2">
						<xsl:value-of select="substring-after($radioTxt,';')" />
					</xsl:variable>

					<xsl:if test="contains($radioTxt2, ';')">
						<xsl:value-of select="substring-after($radioTxt2,';')" />
					</xsl:if>

					<xsl:if test="not(contains($radioTxt2, ';'))">
						<xsl:value-of select="$radioTxt2" />
					</xsl:if>
				</xsl:if>

				<xsl:if test="not(contains($radioTxt, ';'))">
					<xsl:value-of select="$radioTxt" />
				</xsl:if>

				<br />
				<hr />
			</xsl:when>

			<!-- 新加了这个select -->
			<xsl:when test="@type='select'">
				<xsl:if test="not(contains(@id, 'ToNodeId'))">
					<xsl:value-of select="@title" />
					<b>：</b>
					<xsl:value-of select="value/." />
					<br />
					<hr />
				</xsl:if>
			</xsl:when>
			<xsl:when test="@id='MTTABLE'">
				<li data-role="list-divider">
					<xsl:value-of select="@title" />
				</li>
				<li>
					<xsl:apply-templates
						select="//div[@name='Fck_HTML']//table[@id='tblListC']" mode="t1" />
				</li>
			</xsl:when>
			<xsl:when test="@id='StKPRQ'">
				<xsl:if test="contains(concat(@shownodes,';'),$flownodeidpanduan)">
					<xsl:value-of select="@title" />
					<b>：</b>
					<xsl:value-of select="value/." />
					<br />
					<hr />
				</xsl:if>
			</xsl:when>
			<xsl:when test="@id='StOperator'">
				<xsl:if test="contains(concat(@shownodes,';'),$flownodeidpanduan)">
					<xsl:value-of select="@title" />
					<b>：</b>
					<xsl:value-of select="value/." />
					<br />
					<hr />
				</xsl:if>
			</xsl:when>
			<xsl:when test="@id='StDocNumber'">
				<xsl:if test="contains(concat(@shownodes,';'),$flownodeidpanduan)">
					<xsl:value-of select="@title"/>
					<b>：</b>
					<xsl:value-of select="value/." />
					<br />
					<hr />
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="contains(@type, 'checkbox')">
					<xsl:if test="not(value/.='')">
						<xsl:value-of select="@title" />
						<b>：</b>
						<xsl:value-of select="value/." />
						<br />
						<hr />
					</xsl:if>
				</xsl:if>
				<!--<xsl:if test="not(contains(@type, 'checkbox'))"> <xsl:value-of select="@title" 
					/> <b>：</b> <xsl:value-of select="value/."/> <br/><hr/> </xsl:if> -->
				<xsl:if
					test="not(contains(@type, 'checkbox')) and not(contains(@name,'TravelInfo'))">

					<xsl:value-of select="@title" />
					<b>：</b>
					<xsl:value-of select="value/." />
					<br />
					<hr />

				</xsl:if>

				<xsl:if test="contains(@name,'TravelInfo')">
					<xsl:value-of select="@title" />
					<b>：</b>
					<div id="div_DTblHtml">
					</div>

					<br />
					<hr />
				</xsl:if>

			</xsl:otherwise>

		</xsl:choose>
	</xsl:template>
	<xsl:template name="flownodes">
		<xsl:param name="flows" />
		<xsl:param name="default" />
		<xsl:if test="substring-after($flows, ';')!=''">
			<xsl:choose>
				<xsl:when
					test="$default=substring-after(substring-before($flows, ';'), '|')">
					<option selected="true"
						value="{substring-after(substring-before($flows, ';'), '|')}">
						<xsl:value-of
							select="substring-before(substring-before($flows, ';'), '|')" />
					</option>
				</xsl:when>
				<xsl:otherwise>
					<option value="{substring-after(substring-before($flows, ';'), '|')}">
						<xsl:value-of
							select="substring-before(substring-before($flows, ';'), '|')" />
					</option>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="flownodes">
				<xsl:with-param name="flows" select="substring-after($flows, ';')" />
				<xsl:with-param name="default" select="$default" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="substring-after($flows, ';')=''">
			<xsl:choose>
				<xsl:when test="$default=substring-after($flows, '|')">
					<option selected="true" value="{substring-after($flows, '|')}">
						<xsl:value-of select="substring-before($flows, '|')" />
					</option>
				</xsl:when>
				<xsl:otherwise>
					<option value="{substring-after($flows, '|')}">
						<xsl:value-of select="substring-before($flows, '|')" />
					</option>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<!-- 处理 基本信息table -->
	<xsl:template match="table" mode="t1">
		<xsl:apply-templates mode="t1" />
	</xsl:template>

	<xsl:template match="tbody" mode="t1">
		<xsl:apply-templates mode="t1" />
	</xsl:template>

	<xsl:template match="tr" mode="t1">
		<xsl:variable name="num" select="position()" />
		<xsl:if test="$num!=1">
			<li>
				<xsl:apply-templates mode="t1" />
			</li>
		</xsl:if>
	</xsl:template>

	<xsl:template match="td" mode="t1">
		<xsl:variable name="n" select="position()" />
		<xsl:value-of select="../../tr[1]/td[$n]" />
		:
		<xsl:value-of select="text()" />
		<br />
	</xsl:template>



	<!-- 差旅报销表格展示 -->
	<xsl:template match="textarea" mode="bx">
		<xsl:if test="position()=1">
			<xsl:apply-templates mode="bx" />
		</xsl:if>
	</xsl:template>

	<xsl:template match="table" mode="bx">
		<xsl:apply-templates mode="bx" />
	</xsl:template>

	<xsl:template match="tbody" mode="bx">
		<xsl:apply-templates mode="bx" />
	</xsl:template>

	<xsl:template match="tr" mode="bx">
		<xsl:variable name="num" select="position()" />

		<xsl:if test="$num!=1">
			<xsl:apply-templates mode="bx" />
			<hr />
		</xsl:if>

	</xsl:template>

	<xsl:template match="td" mode="bx">
		<!-- 2012-12-9 不显示隐藏的属性 武红宇 -->
		<xsl:if test="not(@style)">
			<xsl:variable name="n" select="position()" />
			<xsl:value-of select="translate(../../tr[1]/td[$n],'*','')" />
			:
			<xsl:apply-templates mode="bx" />
			<br />
		</xsl:if>
	</xsl:template>

	<xsl:template match="input" mode="bx">
		<xsl:value-of select="translate(@value,'?readOnly','')" />
	</xsl:template>


	<xsl:template match="input" mode="hidden">
		<input type="hidden" id="{@name}" name="{@name}" value="{@value}" />
	</xsl:template>

	<xsl:template match="tr" mode="option">
		<div style="width;100%" align="left">
			<xsl:value-of select="td[4]/." />
		</div>
		<div style="width;100%" align="right">
			<xsl:value-of select="td[1]/." />
			<br />
			<xsl:value-of select="td[2]/." />
			<br />
			<xsl:value-of select="td[3]/." />
			<br />
		</div>
		<hr />
	</xsl:template>


	<!-- 表单批量格式化模版 -->
	<!-- variable of $mini and $aliasname at mdp.xsl -->
	<xsl:template match="table" mode="c1">
		<xsl:apply-templates mode="c2" />
	</xsl:template>

	<xsl:template match="tbody" mode="c2">
		<xsl:apply-templates mode="c2" />
	</xsl:template>

	<xsl:template match="tr" mode="c2">
		<div style="width:100%" align="left">
			<xsl:attribute name="align">
				<xsl:if test="not(position()=1 or position()=3)">left</xsl:if>
			</xsl:attribute>
			<xsl:apply-templates mode="c3" />
		</div>
		<hr color="gray" />
	</xsl:template>

	<xsl:template match="td" mode="c3">
		<xsl:if test=".!=''">
			<xsl:if test="not(@style) or not(contains(@style, 'display:none'))">
				<!-- 发文红色字体特殊处理 -->
				<xsl:choose>
					<xsl:when test="position()=1">
						<span style="width:38%;display:inline-block;text-align:right">
							<font color="red">
								<xsl:value-of select="." />
								<xsl:if test="not(contains(., ':'))">
									:
								</xsl:if>
							</font>
						</span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates mode="c4" />
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="position()=2">
					<br />
				</xsl:if>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="text()" mode="c4">
		<xsl:value-of select="." />
	</xsl:template>
	<xsl:template match="q" mode="c4">
		<xsl:apply-templates mode="c4" />
	</xsl:template>
	<xsl:template match="b" mode="c4">
		<xsl:if test="normalize-space(.)!=''">
			<strong>
				<xsl:apply-templates mode="c4" />
			</strong>
		</xsl:if>
	</xsl:template>
	<xsl:template match="center" mode="c4">
		<span width="100%" align="center" mode="c4">
			<xsl:apply-templates mode="c4" />
		</span>
	</xsl:template>
	<xsl:template match="font" mode="c4">
		<font>
			<xsl:apply-templates mode="c4" />
		</font>
	</xsl:template>
	<xsl:template match="input" mode="c4">
		<xsl:value-of select="@value" />
	</xsl:template>
	<xsl:template match="select" mode="c4">
		<xsl:if test="starts-with(@name, 'fld')">
			<xsl:value-of select="option[@selected='selected']/text()" />
		</xsl:if>
	</xsl:template>
	<xsl:template match="textarea" mode="c4">
		<xsl:value-of select="text()" />
	</xsl:template>
	<xsl:template match="hr" mode="c4">
		<hr size="{@size}">
			<xsl:attribute name="color">
				<xsl:call-template name="color">
					<xsl:with-param name="name"><xsl:value-of
				select="@color" /></xsl:with-param>
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