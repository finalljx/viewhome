<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:variable name="appdbpath"><xsl:value-of select="//input[@name='appdbpath']/@value"/></xsl:variable>
	<xsl:variable name="appformname"><xsl:value-of select="//input[@name='appformname']/@value"/></xsl:variable>
	<xsl:variable name="username">
		<xsl:value-of select="substring-before(substring-after(//input[@name='curUser']/@value,'CN='),'/O=')"/>
	</xsl:variable>
	<!-- 表单变量 --> 
	<xsl:variable name="dbPath">
		<xsl:value-of select="//input[@name='dbpath' or @name='dbPath' or @name='dbPath1']/@value" />
	</xsl:variable>
	<xsl:variable name="unId">
		<xsl:choose><xsl:when test="contains(//url/text(),'/0/')"><xsl:value-of select="substring-before(substring-after(//url/text(),'/0/'),'?')" /></xsl:when><xsl:when test="contains(//url/text(),'/vwDocByDate/')"><xsl:value-of select="substring-before(substring-after(//url/text(),'/vwDocByDate/'),'?')" /></xsl:when><xsl:otherwise><xsl:value-of select="substring-before(substring-after(substring-after(//url/text(),'nsf/'),'/'),'?')" /></xsl:otherwise></xsl:choose>
	</xsl:variable>
	<xsl:template match="/">
			<script>
			<![CDATA[
				//viewfile 附件函数
				function viewfile(url){
					localStorage.setItem("attachmentUrl",url);
					$.hori.loadPage( $.hori.getconfig().serverBaseUrl+"viewhome/html/attachmentShowForm.html","viewhome/xml/AttachView.xml");
				}
			]]>
			</script>
			<style>
				.ui-btn-text{text-align: center;}
				.ui-listview {background: #D61800;}
			</style>
		
			<div id="notice" data-role="page">
					<div data-role="content" align="center">
					<h3><xsl:value-of select="substring-after(//table[@id='table1']/tbody/tr[4]/.,':')" /></h3>
						   
					<div data-role="collapsible" data-collapsed="false" data-theme="f" data-content-theme="d">
						<h4>附件</h4>
						<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
							 
							<xsl:if test="count(//span[@id='idxSpan']//param[@name='FileInfos'])=0">
								<li>无附件</li>
							</xsl:if>
								<xsl:call-template name="attachedFiles">
									<xsl:with-param name="FileInfosValue" select="//param[@name='FileInfos']/@value"/>
								</xsl:call-template>
						</ul>
					</div>
						<div data-role="collapsible" data-theme="f" data-content-theme="d">
							<h4>领导指示</h4>
							<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
								<!-- <li data-role="list-divider">领导指示</li> -->
								<li>
									<xsl:if test="count(//td[@class='top']//table/tbody)=0">
										<font color="red" size="3">无领导指示</font>
									</xsl:if>
									<xsl:apply-templates select="//td[@class='top']//table/tbody" mode="leader"/>
								</li>
							</ul>
						</div>
						<div data-role="collapsible" data-theme="f" data-content-theme="d">
							<h4>基本信息</h4>
						<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
							<li>
								<xsl:if test="count(//table[@id='table1']/tbody)=0">
									<font color="red" size="3">无基本信息</font>
								</xsl:if>
								<xsl:apply-templates select="//table[@id='table1']/tbody" mode="basedata"/>
							</li>
						</ul>
						</div>
						<div data-role="collapsible" data-theme="f" data-content-theme="d">
							<h4>会签部门意见</h4>
						<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
							<li>
								会签部门意见:<br/><xsl:apply-templates select="//table[@id='table1']/tbody/tr[6]/td//table" mode="yu7"/>
							</li>
						</ul>
						</div>
						<div data-role="collapsible" data-collapsed="false" data-theme="f" data-content-theme="d">
							<h4>公文流转</h4>
							<ul data-role="listview" data-inset="true" data-theme="d" style="word-wrap:break-word">
							<li>
								<xsl:if test="count(//table[@id='agyj']//tbody//tr)=0">
									<font color="red" size="3">无</font>
								</xsl:if>
								<xsl:apply-templates select="//table[@id='agyj']//tbody//tr" mode="mindinfo"/>
							</li>
							</ul>
						</div>
					</div>
			</div>
		
	</xsl:template>
	
	<!-- 将隐藏控件传入 -->
	<xsl:template match="input" mode="hidden">
		<xsl:if test="@name!='$$querysaveagent'">
			<input type="hidden" name="{@name}" value="{@value}"/>
		</xsl:if>
	</xsl:template>

	<!-- 字符串倒叙查找子字符串 -->
	<xsl:template name="substring-after-last">
	  <xsl:param name="string" />
	  <xsl:param name="delimiter" />
	  <xsl:choose>
		<xsl:when test="contains($string, $delimiter)">
		  <xsl:call-template name="substring-after-last">
			<xsl:with-param name="string"
			  select="substring-after($string, $delimiter)" />
			<xsl:with-param name="delimiter" select="$delimiter" />
		  </xsl:call-template>
		</xsl:when>
		<xsl:otherwise><xsl:value-of select="$string" /></xsl:otherwise>
	  </xsl:choose>
	</xsl:template>
	<!--正文-->
	<xsl:template name="attachedFiles">
		<xsl:param name="fileunids"/>
		<xsl:param name="FileInfosValue"/>
		<xsl:variable name="fileunid" select="substring-before(substring-after($FileInfosValue,'&lt;file_unid&gt;'),'&lt;/file_unid&gt;')"/>
		<xsl:variable name="file" select="substring-before(substring-after($FileInfosValue,'&lt;file_name&gt;'),'&lt;/file_name&gt;')"/>
		<xsl:variable name="docunid" select="substring-before(substring-after($FileInfosValue,'&lt;doc_unid&gt;'),'&lt;/doc_unid&gt;')"/>
		<xsl:variable name="filetype">
			<xsl:call-template name="substring-after-last">
			    <xsl:with-param name="string" select="$file" />
			    <xsl:with-param name="delimiter" select="'.'" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="type" select="translate($filetype, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
		<xsl:if test="not(contains($fileunids, $fileunid))">
				<li>
					<a href="javascript:void(0)" onclick="viewfile($.hori.getconfig().appServerHost+'view/oa/file/'+$.hori.getconfig().docServer+'/{$dbPath}/0/{$docunid}/$file/{$fileunid}.{$filetype}')">
					<xsl:value-of select="$file"/></a>
				</li>
		</xsl:if>
		<xsl:if test="contains(substring-after($FileInfosValue,'/doc_unid'),'file_unid')">
			<xsl:call-template name="attachedFiles">
				<xsl:with-param name="fileunids"><xsl:value-of select="$fileunids"/>;<xsl:value-of select="$fileunid"/>;</xsl:with-param>
				<xsl:with-param name="FileInfosValue" select="substring-after($FileInfosValue,'/doc_unid')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- 处理领导审批 -->
	<xsl:template match="tbody" mode="leader">
		<div>
			<div style="width:100%;line-height:1.8;" align="left">
				指示意见:<xsl:value-of select="tr[1]/td/text()"/><br/>
				指示时间:<xsl:value-of select="tr[2]/td/text()"/><br/>
				指示领导:<xsl:value-of select="substring-before(tr[2]/td/span/text(),'/')"/>
			</div>
		</div>
		<hr/>
	</xsl:template>
	<!-- 处理基本信息 select="tr[5]/table/tbody/tr"-->
	<xsl:template match="tbody" mode="basedata">
		<xsl:value-of select="substring-before(tr[5]/td/table/tbody/tr/td[1]/.,'：')" />：<xsl:value-of select="tr[5]/td/table/tbody/tr/td[1]/font/font/text()" />
		<xsl:value-of select="tr[5]/td/table/tbody/tr/td[1]/font/text()" />
		<xsl:value-of select="tr[5]/td/table/tbody/tr/td[1]/font/font/select/option[@selected='selected']/." /><hr/>
		<xsl:if test="tr[5]/td/table/tbody/tr/td[1]/font/font/select/option[contains(@selected,'selected')]">
			<input type="hidden" name="fldSelSPQX" value="{tr[5]/td/table/tbody/tr/td[1]/font/font/select/option[@selected='selected']/@value}"/>
		</xsl:if>
		<xsl:value-of select="tr[5]/td/table/tbody/tr/td[2]/." /><hr/>
		会签单位：<xsl:value-of select="tr[5]/td/table/tbody/tr/td[3]/table/tbody/tr/td[2]/." />
		<xsl:value-of select="//textarea[@name='flddanwei']/." />
		<xsl:value-of select="tr[5]/td/table/tbody/tr/td[3]/span[2]/text()" /><hr/>
			<xsl:apply-templates select="tr[5]/td/table/tbody/tr/td[4]/table/tbody/tr[2]" mode="yu1"/>
			<xsl:apply-templates select="tr[5]/td/table/tbody/tr/td[5]/table/tbody//tr" mode="yu9"/>
	</xsl:template>
	<xsl:template match="table" mode="yu7">
		<div style="line-height: 1.5em;">
		　　审批意见：<xsl:value-of select="tbody/tr[1]/td[1]/."/><br/>
		　　审批人：<xsl:value-of select="tbody/tr[2]/td/span/."/><br/>
		　　处理时间：<xsl:value-of select="tbody/tr[2]/td/text()"/><br/><hr/>
		</div>
	</xsl:template>
	<xsl:template match="tr" mode="yu1">	
		签报人：<xsl:value-of select="substring-before(td/.,'/')"/><hr/>
		签报时间：<xsl:value-of select="substring-after(td/.,'/genertec')"/><hr/>
	</xsl:template>
	<xsl:template match="tr" mode="yu9">
		<xsl:variable name="trnumber" select="position()"/>
		<xsl:choose>
				<xsl:when test="$trnumber=1">
					<xsl:value-of select="td[1]/."/><xsl:value-of select="substring-before(td[2]/.,'/')"/><hr/>
				</xsl:when>
				<xsl:when test="$trnumber!=1">
					<xsl:value-of select="td[1]/."/><xsl:value-of select="td[2]/."/><hr/>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- 处理审批意见 -->
	<xsl:template match="tr" mode="mindinfo">
		<div>
			<div style="width:100%;line-height:1.8;" align="left">
				<xsl:variable name="num" select="position()"/>
			<xsl:choose>
				<xsl:when test="$num mod 2!=0">
					<xsl:value-of select="td[1]/."/>:<xsl:value-of select="substring-before(td[2]/.,'/')"/><br/>
					<xsl:value-of select="td[3]/."/>:<xsl:value-of select="td[4]/."/><br/>
					<xsl:value-of select="td[5]/."/>:<xsl:value-of select="td[6]/."/><br/><hr/>
				</xsl:when>
				<!-- <xsl:when test="$num mod 2=0">
					意  见:<xsl:value-of select="td[2]/."/><br/><hr/>
				</xsl:when> -->
				<xsl:otherwise>
				</xsl:otherwise>
			</xsl:choose>
			</div>
		</div>
		
	</xsl:template>
</xsl:stylesheet>