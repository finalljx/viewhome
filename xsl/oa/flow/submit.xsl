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
	<xsl:variable name="dbPath">
		<xsl:value-of select="//input[@name='dbpath' or @name='dbPath' or @name='dbPath1']/@value" />
	</xsl:variable>

	<xsl:template match="/">
		<html lang="zh_cn">
			<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1.0" />
			<script>
				<![CDATA[
					$.hori.showLoading();
				]]>
			</script>
			</head>
			<body>
				<div id="submit" data-role="dialog" class="type-home">
					<div data-role="header">
						<style>.ui-dialog .ui-header .ui-btn-icon-notext { display:none;} </style>
						<h1>请确认提交信息</h1>
					</div>

					<div id="faqdiv" style="display:none;min-height:300px;" class="ui-overlay-shadow ui-corner-bottom ui-body-c">
						<ul id="userselect" data-role="listview" data-inset="true">
						
						</ul>
					</div>
					
					<div data-role="content" align="center">
						<xsl:choose>
							<!-- 表单选择人员 -->
							<xsl:when test="contains(//url/text(), 'frmSubmitPage')">
								<script>
									function showAndHide(id, id2){
										$("#"+id).css("display","block");
										$("#"+id2).css("display","none");
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
								</script>
								<script>
								<![CDATA[
									function hideuserselect(){
										//radio
										var val = $('input:radio:checked').val();
										var number = val.indexOf("genertec");
										if(number!="-1"){
											var num = val.indexOf("/");
											var CHname = val.substring(0,num);
											
											var num2 = CHname.indexOf("=");
											if(num2!="-1"){
												var CHname1 = CHname.substring(num2+1);
												$('#forshow').attr('value',CHname1);
											}else{
												$('#forshow').attr('value',CHname);
											}
											$('#fldXyspr').attr('value',val);
											//$("#faqdiv").css("display","none");
										}
										//checkbox
										var personstr="";
										$("input[name='chooseperson']:checked").each(function(){
											personstr+=$(this).val()+",";
										})
										personstr=personstr.substring(0,personstr.length-1);
										//console.log(personstr);
										var number2 = personstr.indexOf("genertec");
										if(number2!="-1"){
											var personstrCH = personstr.split(",");
											var personName="";
											for(var i=0;i<personstrCH.length;i++){
												var num3 = personstrCH[i].indexOf("genertec");
												personName+= personstrCH[i].substring(num3+9,personstrCH[i].length)+",";
											}
											$('#forshowcheck').val(personName);
											$('#fldXyspr').attr('value',personstr);
											//$("#faqdiv").css("display","none");
										}
										$("#faqdiv").css("display","none");
									}
									]]>
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
											<button type="submit" data-theme="f" name="$$querysaveagent" value="submitConfirm">确定11</button>
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
										$.hori.hideLoading();
										function cancelSubmit(){
											document.location.reload();
										}
									]]>
								</script>
								<script>
									<![CDATA[
									$('form').submit(function(){
										if($("#fldSelDept").length>0){
											var dept   = $("#fldSelDept").val();
											if(dept==null || dept==""){
												var person = $("#fldXyspr").val();
												if((person==null||person=="")&&(dept==null||dept=="")){
													if(person == null || person == ""){
														alert('请选择下一步审批部门!');
														return false;
													}
												}
											}
										}else{
											var person = $("#fldXyspr").val();
											if(person==null||person==""){
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
											<button type="submit" data-theme="f" name="$$querysaveagent" value="agtFlowDeny">确定22</button>
										</div>
										<div class="ui-block-b">
											<a data-role="button" data-theme="f" href="javascript:void(0);" onclick="cancelSubmit()">取消d</a>
										</div>
									</div>
									<xsl:apply-templates select="//input[@type='hidden']" mode="hidden"/>
									<xsl:apply-templates select="//div[contains(@style,'display:none')]//input" mode="hidden"/>
								</form>
								<script>
									<![CDATA[
										$.hori.hideLoading();
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
										<form action="/view/oa/submit{//form[1]/@action}" method="post" data-rel="dialog">
											<ul data-role="listview" data-inset="true">
												<li data-role="list-divider"></li>
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
													<a data-role="button" data-theme="f" href="javascript:void(0);" onclick="cancelSubmit()">确定33</a>
												</div>
											</div>
											<script>
												<![CDATA[
													$.hori.hideLoading();
													function cancelSubmit(){
														document.location.reload();
													}
												]]>
											</script>
										</form>
									</xsl:when>
									<xsl:otherwise>
										<form action="/view/oa/submit{//form[1]/@action}" method="post" data-rel="dialog">
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
													<button type="submit" data-theme="f" name="$$querysaveagent" value="agSaveSelBranch">确定44</button>
												</div>
												<div class="ui-block-b">
													<a data-role="button" data-theme="f" href="javascript:void(0);" onclick="cancelSubmit()">取消test</a>
												</div>
											</div>
											<xsl:apply-templates select="//input[@type='hidden']" mode="hidden"/>
											<xsl:apply-templates select="//div[contains(@style,'display:none')]//input" mode="hidden"/>
										</form>
										<script>
											<![CDATA[
												$.hori.hideLoading();
												function cancelSubmit(){
													$.hori.showLoading();
													document.location.reload();
												}
											]]>
										</script>
									</xsl:otherwise>
									
								</xsl:choose>
								
							</xsl:when>
							<xsl:when test="contains(//url/text(), 'Seq=')">
								<ul data-role="listview" data-inset="true">
									<li data-role="list-divider">
										<div data-role="controlgroup" data-type="horizontal" style="width:100%;" align="right">
											<a data-role="button" href="javascript:void(0);" onclick="cancelSubmit()">返回</a>
										</div>
									</li>
									<li>
										<xsl:if test="//body/script"><xsl:value-of select="substring-before(substring-after(//body/script/text(),'('),')')"/></xsl:if>
										<xsl:if test="not(//body/script)"><xsl:value-of select="//body/text()"/></xsl:if>
										
									</li>
									<li data-role="list-divider"></li>
								</ul>
								<script>
									<![CDATA[
										$.hori.hideLoading();
										function cancelSubmit(){
											document.location.reload();
										}
									]]>
								</script>
							</xsl:when>
							<xsl:otherwise>
								<ul data-role="listview" data-inset="true">
									<li data-role="list-divider"></li>
									<li>
										保存成功
									</li>
									<li data-role="list-divider"></li>
								</ul>
								<script>
									$.hori.hideLoading();
									document.location.reload();
								</script>
							</xsl:otherwise>
						</xsl:choose>
					</div>
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
			<xsl:when test="contains(.,'下一环节审批人')">
				<xsl:value-of select="td/b/text()"/>
				<!--对选人员按钮进行判断，如果调用方法为SelectPerson(),则是普通选择；-->
				<!--如果调用方法为SelectPersonAdv()；则是给定范围的选择-->
				<!--如果不能选择人员，则直接给出系统默认的人员-->
				<xsl:choose>
					<xsl:when test="contains(.//div[@id='search']/@onclick,'SelectPerson(')">
						<li data-role="fieldcontain">
							<fieldset data-role="controlgroup" data-type="horizontal" style="text-align:center;">
								<input type="text" id="forshow" name="forshow" value="{substring-before(translate(//input[@name='fldXyspr']/@value,' ',''),'/')}" readonly="true"  data-inline="true"/>
								<input type="hidden" id="fldXyspr" name="fldXyspr" value="{translate(//input[@name='fldXyspr']/@value,' ','')}" readonly="true"  data-inline="true"/>
								<!-- <a href="javascript:void(0)" onclick="clearperson();" style="margin-left:100px;" data-role="button" data-inline="true">清空666</a> -->
								<a href="javascript:void(0)" onclick="userselect('/view/oa/userselectorg/doctest/{$dbPath}/(wAddressAdv)?OpenForm&amp;unid={$unidstr}')" data-role="button" data-inline="true" data-theme="b">选人13</a>
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
								<a href="javascript:void(0)" onclick="userselect('/view/oa/userselectorg/doctest/{$dbPath}/(wAddressAdv)?OpenForm&amp;unid={$unidstr}')" data-role="button" data-inline="true" data-theme="b">选人2</a>
							</fieldset>
						</li>
					</xsl:when>
					<xsl:otherwise>
						<li data-role="fieldcontain">
							<fieldset data-role="controlgroup" data-type="horizontal">
								<legend>下一环节审批人w:</legend>
								<xsl:value-of select="substring-before(//input[@name='fldXyspr']/@value,'/')" />
								<input id="fldXyspr" name="fldXyspr" type="hidden" value="{//input[@name='fldXyspr']/@value}"/>
							</fieldset>
						</li>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="contains(.,'请选择会签部门')">
				<li data-role="fieldcontain" style="{./@style}" id="trSelectOrg">
					<fieldset data-role="controlgroup" data-type="horizontal">
						<legend>会签部门:</legend>
						<xsl:value-of select="//input[@name='fldSelDept']/@value"/>
						<!-- <a href="javascript:void(0)" onclick="" data-role="button" data-inline="true" data-theme="b">选择</a> -->
						<input id="fldSelDept" name="fldSelDept" type="hidden" value="{//input[@name='fldSelDept']/@value}"/>
					</fieldset>
				</li>
			</xsl:when>
			<xsl:when test="contains(.,'请选择会签审批人')">
				<li data-role="fieldcontain" style="{./@style}" id="trSelectUser">
					<fieldset data-role="controlgroup" data-type="horizontal">
						<legend>请选择会签审批人:</legend>
						<textarea id="forshowcheck" name="forshowcheck"></textarea>
						<input type="hidden" id="fldXyspr" name="fldXyspr" value="" readonly="true"  data-inline="true"/>
						<a href="javascript:void(0)" onclick="userselect('/view/oa/userselect/doctest/indishare/addresstree.nsf/vwdepbyparentcode?readviewentries&amp;count=1000&amp;startkey=1&amp;UntilKey=10')" data-role="button" data-inline="true" data-theme="b">选人员</a>
						<!-- <a href="javascript:void(0)" onclick="userselect('/view/oa/userselect/doctest/indishare/addresstree.nsf/vwdepbyparentcode?readviewentries&amp;count=1000&amp;startkey=1&amp;UntilKey=10')" data-role="button" data-inline="true" data-theme="b">选角色</a> -->
						<input id="fldXyspr" name="fldXyspr" type="hidden" value="{//input[@name='fldXyspr']/@value}"/>
					</fieldset>
				</li>
			</xsl:when>
			<xsl:when test="contains(.,'会 签　规 则')">
				<li data-role="fieldcontain" style="{./@style}" id="{./@id}">
					<fieldset data-role="controlgroup">
						<legend><xsl:value-of select="td[@class='tdLabel']/."/></legend>
						<input type="radio" id="_d2epa44tnk89rno8joukg_" name="fldSpgz" value="_d2epa44tnk89rno8joukg_" onclick="showAndHide('trSelectUser','')"></input>
						<label for="_d2epa44tnk89rno8joukg_">并发会签</label>
						<input type="radio" id="_d2f5r64ugu89rno8joukg_" name="fldSpgz" value="_d2f5r64ugu89rno8joukg_" onclick="showAndHide('','trSelectUser')" checked="checked"></input>
						<label for="_d2f5r64ugu89rno8joukg_">顺序会签</label>
					</fieldset>
				</li>
			</xsl:when>
			<xsl:when test="td[@class='tdLabel']">
			<xsl:if test="not(contains(td[@class='tdLabel']/.,'是否邮件'))">
				<li data-role="fieldcontain" style="{./@style}">
					<fieldset data-role="controlgroup">
						<legend><xsl:value-of select="td[@class='tdLabel']/."/></legend>
						<xsl:apply-templates select="td[@class='tdContent']/." mode="submit"/>
					</fieldset>
				</li>
			</xsl:if>
			</xsl:when>
		</xsl:choose>
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
