<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes" encoding="gb2312"/>
	<xsl:variable name="start"><xsl:value-of select="//input[@name='start']/@value"/></xsl:variable>
	<xsl:variable name="count"><xsl:value-of select="//input[@name='count']/@value"/></xsl:variable>
	<xsl:variable name="total"><xsl:value-of select="//input[@name='total']/@value"/></xsl:variable>
	<xsl:variable name="currentPage"><xsl:value-of select="floor($start div $count)+1"/></xsl:variable>
	<xsl:variable name="totalPage"><xsl:value-of select="floor(($total - 1) div $count)+1"/></xsl:variable>
	<xsl:variable name="nextStart"><xsl:value-of select="($currentPage * $count) + 1"/></xsl:variable>
	<xsl:variable name="preStart"><xsl:value-of select="$nextStart - $count - $count"/></xsl:variable>
	<xsl:variable name="unidstr">
	<xsl:value-of select="substring-before(substring-after(//param[@name='to']/@value,'unid='),'&amp;seluser')"/>
	</xsl:variable>
	<xsl:variable name="dbpath">
	<xsl:value-of select="//param[@name='fldFromDB']/@value"/>
	</xsl:variable>

	<xsl:template match="/">
		<html lang="zh_cn">
			<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1.0" />
			<script type="application/javascript" src="/view/assets/iscroll.js"></script>
			<link rel="stylesheet" href="/view/lib/jquery-mobile/jquery.mobile.min.css" />
			<link rel="stylesheet" href="/view/assets/jquery.mobile-sugon.css" />
			<script src="/view/lib/jquery/jquery.min.js"></script>
			<script src="/view/lib/hori/hori.js?tag=21369"></script>
			<script src="/view/lib/jquery-mobile/jquery.mobile.min.js"></script>
			<script src="/view/config/web/config.js"></script>
			</head>
			<body>
				<div id="submit" data-role="dialog" class="type-home">
					<div data-role="header">
						<style>.ui-dialog .ui-header .ui-btn-icon-notext { display:none;} </style>
						<h1>请确认提交信息</h1>
					</div><!-- /header -->

					<div id="faqdiv" style="display:none;min-height:300px;" class="ui-overlay-shadow ui-corner-bottom ui-body-c">
						<ul id="userselect" data-role="listview" data-inset="true">
						
						</ul>
					</div>
					
					<div data-role="content" align="center">
						<xsl:choose>
							<!-- 表单选择人员 -->
							<xsl:when test="contains(//url/text(), 'frmSubmitPage')">
								<script>
									function showorHide(id){
										//trSelectYj  trWriteYj
										if(id=="0"){
											$("#trWriteYj").css("display","none");
											$("#trSelectYj").css("display","block");
										}else if(id=="1"){
											$("#trSelectYj").css("display","none");
											$("#trWriteYj").css("display","block");
										}
									}
									function choose(ischeck, username){
										if(ischeck){
											if($('#fldXyspr').val()!=''){
												$('#fldXyspr').attr('value', $('#fldXyspr').val() + "," + username);
											}else{
												$('#fldXyspr').attr('value', username);
											}
										}else{
											$('#fldXyspr').attr('value', $('#fldXyspr').val().replace(username+",", ''));
											$('#fldXyspr').attr('value', $('#fldXyspr').val().replace(","+username, ''));
											$('#fldXyspr').attr('value', $('#fldXyspr').val().replace(username, ''));
										}
									}
									function clearperson(){
										$('#fldXyspr').attr('value', '');
									}
									function userselect(url){
										$.mobile.showPageLoadingMsg();
										$.ajax({
											type: "get",
											url: url,
											data: null,
											dataType: "text",
											success: function(response){
												//alert(response);
												$.mobile.hidePageLoadingMsg();
												if(response!=null&amp;&amp;response!=''){
													$("#userselect").empty();
													$("#userselect").append(response);
													$("#userselect").listview("refresh");
													showuserselect();
												}
											}
										});
									}
									function showuserselect(){
										var dialogheight = $("#faqdiv").height();
										var containerheight = document.body.scrollHeight;
										if(dialogheight >= containerheight){
											$("#faqdiv").css("top", "0");
										}else{
											var top = (containerheight - dialogheight) / 2;
											$("#faqdiv").css("top", top);
										}
										$("#faqdiv").css("display", "block");

									}
									function hideuserselect(){
										var val = $('input:radio:checked').val();
										console.log(val);
										var number = val.indexOf("genertec");
										if(number!="-1"){
											var CHname = val.substring(number+9,val.length);
											$('#forshow').attr('value',CHname);
											$('#fldXyspr').attr('value',val);
											$("#faqdiv").css("display","none");
										}else if(number=="-1"){
											$("#faqdiv").css("display","none");
										}
										
									}
								</script>
								<style type="text/css">
									#faqdiv{position:absolute;width:80%; left:50%; top:50%; margin-left:-40%; min-height:300px; height:auto; z-index:100; background-color:#fff;}
								</style>
								<!-- 选人提交 -->
								<form action="/view/oa/responsesubmit{//form[1]/@action}" method="post">
									<ul data-role="listview" data-inset="true">
										<li data-role="list-divider"></li>
										<xsl:apply-templates select="//table[@class='tableClass']//tr" mode="choose"/>
									</ul>
									<div class="ui-grid-a">
										<div class="ui-block-a">
											<button type="submit" data-theme="f" name="$$querysaveagent" value="submitConfirm">确定yu01</button>
										</div>
										<div class="ui-block-b">
											<a data-role="button" data-theme="f" href="javascript:void(0);" onclick="cancelSubmit()">取消</a>
										</div>
									</div>
									<xsl:apply-templates select="//input[@type='hidden']" mode="hidden"/>
									<xsl:apply-templates select="//div[contains(@style,'display:none')]//input" mode="hidden"/>
								</form>
								<script>
									<![CDATA[
										function cancelSubmit(){
											document.location.reload();
										}
									]]>
								</script>
								<script>
									<![CDATA[
									$('form').submit(function(){
										if($("#fldXyspr").length>0){
											var person = $("#fldXyspr").val();
											if(person == null || person == ""){
												alert('请选择下一步审批人!');
												return false;
											}
										}
										return true;
									});
									]]>
								</script>
							</xsl:when>
							<!-- 表单驳回确认 -->
							<xsl:when test="contains(//url/text(), 'frmDenySubmit')">
								<form action="/view/oa/responsesubmit{//form[1]/@action}" method="post">
									<ul data-role="listview" data-inset="true">
										<li data-role="list-divider"></li>
										<xsl:apply-templates select="//table[@class='tableClass']//tr" mode="choose"/>
									</ul>
									<div class="ui-grid-a">
										<div class="ui-block-a">
											<button type="submit" data-theme="f" name="$$querysaveagent" value="agtFlowDeny">确定yu02</button>
										</div>
										<div class="ui-block-b">
											<a data-role="button" data-theme="f" href="javascript:void(0);" onclick="cancelSubmit()">取消</a>
										</div>
									</div>
									<xsl:apply-templates select="//input[@type='hidden']" mode="hidden"/>
									<xsl:apply-templates select="//div[contains(@style,'display:none')]//input" mode="hidden"/>
								</form>
								<script>
									<![CDATA[
										function cancelSubmit(){
											document.location.reload();
										}
									]]>
								</script>
							</xsl:when>
							<!-- 表单流程分支 -->
							<xsl:when test="contains(//url/text(), 'frmBranchSelecter')">
								<xsl:choose>
									<xsl:when test="//td[@class='msgok_msg']">
										<form action="/view/oa/signsubmit{//form[1]/@action}" method="post" data-rel="dialog">
											<ul data-role="listview" data-inset="true">
												<li data-role="list-divider">
												</li>
												<li>
													<div style="100%;text-align:center;" align="center">
														<div align="center">
															<xsl:value-of select="//td[@class='msgok_msg']/."/>
														</div>
													</div>
												</li>
											</ul>
											<div class="ui-grid-a">
												<div class="ui-block-a">
												</div>
												<div class="ui-block-b">
													<a data-role="button" data-theme="f" href="javascript:void(0);" onclick="cancelSubmit()">确定yu03</a>
												</div>
											</div>
											<script>
												<![CDATA[
													function cancelSubmit(){
														document.location.reload();
													}
												]]>
											</script>
										</form>
									</xsl:when>
									<xsl:otherwise>
										<form action="/view/oa/signsubmit{//form[1]/@action}" method="post" data-rel="dialog">
											<xsl:choose>
												<xsl:when test="contains(//div[@class='Toolbar']/@onclick, 'agSaveSelBranch')">
													<input type="hidden" id="querysaveagent" name="$$querysaveagent" value="agSaveSelBranch" />
												</xsl:when>
												<xsl:otherwise>
													<input type="hidden" id="querysaveagent" name="$$querysaveagent" value="{//input[@name='$$querysaveagent']/@value}" />
												</xsl:otherwise>
											</xsl:choose>
											<ul data-role="listview" data-inset="true">
												<li data-role="list-divider"></li>
												<xsl:apply-templates select="//table[@bgcolor='#eeeeee']//tr[position()&lt;last()]" mode="branch"/>
											</ul>
											<div class="ui-grid-a">
												<div class="ui-block-a">
													<button type="submit" data-theme="f" name="$$querysaveagent" value="agSaveSelBranch">确定yu04</button>
												</div>
												<div class="ui-block-b">
													<a data-role="button" data-theme="f" href="javascript:void(0);" onclick="cancelSubmit()">取消</a>
												</div>
											</div>
											<xsl:apply-templates select="//input[@type='hidden']" mode="hidden"/>
											<xsl:apply-templates select="//div[contains(@style,'display:none')]//input" mode="hidden"/>
										</form>
										<script>
											<![CDATA[
												function cancelSubmit(){
													document.location.reload();
												}
											]]>
										</script>
									</xsl:otherwise>
								</xsl:choose>
								
							</xsl:when>
							<!-- 表单错误提示 -->
							<xsl:when test="contains(//url/text(), 'Seq=')">
								<ul data-role="listview" data-inset="true">
									<li data-role="list-divider"></li>
									<li>
										<xsl:choose>
											<xsl:when test="//body/script">接收成功</xsl:when>
											<xsl:when test="not(//body/script)"><xsl:value-of select="//body/text()"/></xsl:when>
											<xsl:otherwise>操作成功</xsl:otherwise>
										</xsl:choose>
									</li>
									<li data-role="list-divider"></li>
								</ul>
								<div class="ui-grid-a">
									<div class="ui-block-a"></div>
									<div class="ui-block-b">
										<a data-role="button" data-theme="f" href="javascript:void(0);" onclick="cancelSubmit()">返回</a>
									</div>
									<script>
										<![CDATA[
											function cancelSubmit(){
												//document.location.reload();
												$.hori.backPage(1);
											}
										]]>
									</script>
								</div>
							</xsl:when>
							<xsl:otherwise>
								<ul data-role="listview" data-inset="true">
									<li data-role="list-divider"></li>
									<li>
										<xsl:choose>
											<xsl:when test="//fieldset"><xsl:value-of select="//fieldset//table/."/></xsl:when>
											<xsl:when test="//body/script"><xsl:value-of select="substring-before(substring-after(//body/script/text(),'('),')')"/></xsl:when>
											<xsl:when test="not(//body/script)"><xsl:value-of select="//body/text()"/></xsl:when>
										</xsl:choose>
									</li>
									<li data-role="list-divider"></li>
								</ul>
								<div class="ui-grid-a">
									<div class="ui-block-a"></div>
									<div class="ui-block-b">
										<a data-role="button" data-theme="f" href="javascript:void(0);" onclick="cancelSubmit()">返回</a>
									</div>
									<script>
										<![CDATA[
											function cancelSubmit(){
												//document.location.reload();
												$.hori.backPage(1);
											}
										]]>
									</script>
								</div>
							</xsl:otherwise>
						</xsl:choose>
					</div><!-- /content -->
				</div>
			</body>
		</html>
	</xsl:template>
	
	<!-- 将隐藏控件传入 -->
	<xsl:template match="input" mode="hidden">
		<xsl:if test="@name!='$$querysaveagent'">
			<input type="hidden" name="{@name}" value="{@value}"/>
		</xsl:if>
	</xsl:template>

	<!-- 流程分支选择 -->
	<xsl:template match="tr" mode="branch">
		<xsl:choose>
			<xsl:when test="position()=1">
			</xsl:when>
			<xsl:when test="position()=last()+1">
			</xsl:when>
			<xsl:otherwise>
			<li data-role="fieldcontain">
				<fieldset data-role="controlgroup">
					<legend><xsl:value-of select="../tr[1]/."/></legend>
					<xsl:apply-templates select="td[2]/." mode="branchcontent"/>
				</fieldset>
			</li>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="input" mode="branchcontent">
		<xsl:if test="@type='radio'">
			<input type="{@type}" id="{@value}" name="{@name}" value="{@value}">
				<xsl:if test="@checked">
					<xsl:attribute name="checked">checked</xsl:attribute>
				</xsl:if>
			</input>
			<label for="{@value}"><xsl:value-of select="./following::text()"/></label>
		</xsl:if>
	</xsl:template>
	<xsl:template match="text()" mode="branchcontent"></xsl:template>
	<xsl:template match="br" mode="branchcontent"></xsl:template>

	
	<!-- 流程人员选择 -->
	<xsl:template match="tr" mode="choose">
		<xsl:choose>
			<xsl:when test="contains(@style,'display:none')">
				<input type="hidden" value="" name="fldSelDept"/>
				<input type="hidden" value="" name="fldSelHuiqianDept"/>
				<input type="hidden" readonly="true" value="{//input[@name='fldSelHuiqianDept']/@value}" name="fldSelHuiqianDept"/>
				<input type="hidden" readonly="true" value="{//input[@name='fldSelDept']/@value}" name="fldSelDept"/>
			</xsl:when>
			<xsl:when test="contains(.,'意见反馈')">
				<li data-role="fieldcontain">
					<fieldset data-role="controlgroup">
						<legend><xsl:value-of select="td[@class='tdLabel']/."/></legend>
						<xsl:apply-templates select="td[@class='tdContent']/." mode="fankuimind"/>
					</fieldset>
				</li>
			</xsl:when>
			<xsl:when test="contains(.,'请选择意见') or contains(., '请选择同步反馈意见的部门')">
				<li data-role="fieldcontain" style="{./@style}" id="trSelectYj">
					<fieldset data-role="controlgroup">
						<legend>请选择意见:</legend>
						<xsl:if test="count(//tr[@bgcolor='#E0E0E0'])=0">
							<font size="3">没有可选择的意见，请直接填写!</font>
						</xsl:if>
						<xsl:apply-templates select="//tr[@bgcolor='#E0E0E0']" mode="choosemind"/>
					</fieldset>
				</li>
				<li data-role="fieldcontain" style="display:none" id="trWriteYj">
					<fieldset data-role="controlgroup" data-type="horizontal">
						<legend>请填写意见:</legend>
						<textarea name="fldIdea" rows="7" cols="50"></textarea>
					</fieldset>
				</li>
			</xsl:when>
			<xsl:when test="contains(.,'下一环节审批人')">
				<!--对选人员按钮进行判断，如果调用方法为SelectPerson(),则是普通选择；-->
				<!--如果调用方法为SelectPersonAdv()；则是给定范围的选择-->
				<!--如果不能选择人员，则直接给出系统默认的人员-->
				<xsl:choose>
					<xsl:when test="contains(.//div[@id='search']/@onclick,'SelectPerson(')">
						<li data-role="fieldcontain">
							<fieldset data-role="controlgroup" data-type="horizontal">
								<legend>下一环节审批人:</legend>
								<input type="text" id="forshow" name="forshow" value="{substring-before(translate(//input[@name='fldXyspr']/@value,' ',''),'/')}" readonly="true"  data-inline="true"/>
								<input type="hidden" id="fldXyspr" name="fldXyspr" value="{translate(//input[@name='fldXyspr']/@value,' ','')}" readonly="true"  data-inline="true"/>
								<!-- <a href="javascript:void(0)" onclick="clearperson();" style="margin-left:30px;" data-role="button" data-inline="true">清空</a> -->
								<a href="javascript:void(0)" onclick="userselect('/view/oa/userselectsignsub/doctest/indishare/addresstree.nsf/vwUserBydepPath?readviewentries&amp;restricttocategory=_53_&amp;count=500&amp;start=1')" data-role="button" data-inline="true" data-theme="b">选人yu06
								</a>
							</fieldset>
							
						</li>
					</xsl:when>
					<xsl:when test="contains(.//div[@id='search']/@onclick,'SelectPersonAdv(')">
						<li data-role="fieldcontain">
							<fieldset data-role="controlgroup" data-type="horizontal">
								<legend>下一环节审批人:</legend>
								<input type="text" id="forshow" name="forshow" value="{substring-before(translate(//input[@name='fldXyspr']/@value,' ',''),'/')}" readonly="true"  data-inline="true"/>
								<input type="hidden" id="fldXyspr" name="fldXyspr" value="{translate(//input[@name='fldXyspr']/@value,' ','')}" readonly="true"  data-inline="true"/>
								<!-- <a href="javascript:void(0)" style="margin-left:30px;" onclick="clearperson();" data-role="button" data-inline="true">清空</a> -->
								<a href="javascript:void(0)" onclick="userselect('/view/oa/userselectorg/doctest/{$dbpath}/(wAddressAdv)?OpenForm&amp;unid={$unidstr}')" data-role="button" data-inline="true" data-theme="b">选人yu09</a>
							</fieldset>
						</li>
					</xsl:when>
					<xsl:otherwise>
						<li data-role="fieldcontain">
							<fieldset data-role="controlgroup" data-type="horizontal">
								<legend>下一环节审批人:</legend>
								<xsl:value-of select="//input[@name='fldXyspr']/@value" />
								<input id="fldXyspr" name="fldXyspr" type="hidden" value="{//input[@name='fldXyspr']/@value}"/>
							</fieldset>
						</li>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			
			<xsl:when test="td[@class='tdLabel']">
				<xsl:if test="not(contains(td[@class='tdLabel']/.,'是否邮件'))">
				<li data-role="fieldcontain">
					<fieldset data-role="controlgroup">
						<legend><xsl:value-of select="td[@class='tdLabel']/."/></legend>
						<xsl:apply-templates select="td[@class='tdContent']/." mode="submit"/>
					</fieldset>
				</li>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="input" mode="fankuimind">
		<xsl:if test="@type='radio'">
			<input type="{@type}" id="{@value}" name="{@name}" value="{@value}" onclick="showorHide(this.id)">
				<xsl:if test="@checked">
					<xsl:attribute name="checked">checked</xsl:attribute>
				</xsl:if>
			</input>
			<label for="{@value}"><xsl:value-of select="./following::text()"/></label>
		</xsl:if>
	</xsl:template>
	<xsl:template match="text()" mode="fankuimind">
		<xsl:if test="not(..//input)">
			<xsl:value-of select="."/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="br" mode="fankuimind"></xsl:template>
	<!-- 审批意见 -->
	<xsl:template match="tr" mode="choosemind">
				<xsl:variable name="num" select="position()-1"/>
				<input type="checkbox" name="SelectyjNum" id="{$num}" value="{$num}"/>
				<label for="{$num}">
						<xsl:value-of select="td[1]/."/>:<xsl:value-of select="substring-before(td[2]/.,'/')"/><br/>
						<xsl:value-of select="td[3]/."/>:<xsl:value-of select="td[4]/."/><br/>
						<xsl:value-of select="td[5]/."/>:<xsl:value-of select="td[6]/."/><br/>
						意  见:<xsl:value-of select="//tr[@bgcolor='#F0F0F0']/td[2]/."/>
				</label>
	</xsl:template>
	<xsl:template match="input" mode="submit">
		<xsl:if test="@type='radio'">
			<input type="{@type}" id="{@value}" name="{@name}" value="{@value}">
				<xsl:if test="@checked">
					<xsl:attribute name="checked">checked</xsl:attribute>
				</xsl:if>
			</input>
			<label for="{@value}"><xsl:value-of select="./following::text()"/></label>
		</xsl:if>
	</xsl:template>
	<xsl:template match="text()" mode="submit">
		<xsl:if test="not(..//input)">
			<xsl:value-of select="."/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="br" mode="submit"></xsl:template>

	
</xsl:stylesheet>
