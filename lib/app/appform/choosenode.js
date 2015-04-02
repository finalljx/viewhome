$(document).ready(function(){
	var oaresponseData;//声明OA返回流程数据
	var oapersonData;//声明OA返回处理人
	var namechshow;//声明流程处理人中文名
	var itcodeshow;//声明流程处理人itcode
});

//获取流程走向和处理人代理数据
function getnodedialogData(val){
	var server = $("#appserver").val();
	var dbpath = $("#appdbpath").val();
	var unid = $("#appdocunid").val();
	var opttype = val;
	var optpsnid = localStorage.getItem("itcode");
	var getnodeUrl = $.hori.getconfig().appServerHost+ "view/oa/attach/Produce/ProInd.nsf/MobileNextOptionAgent?OpenAgent&appserver="+server+"&appdbpath="+dbpath+"&appdocunid="+unid+"&opttype="+opttype+"&optpsnid="+optpsnid+"&data-result=text";
	//alert(getnodeUrl);return;
	$.hori.ajax({
		"type" : "post",
		"url" : getnodeUrl,
		"success" : function(res) {
			oaresponseData = res;
			//调用json处理模板
			usetemplate();
		},
		"error" : function(res) {
			$.hori.hideLoading();
			alert("获取数据异常，请稍后重试。");
		}
	});
}
//根据不同情况选用对应的处理模板
var responseData;
var html;
function usetemplate(){
	//alert(oaresponseData);
	responseData = JSON.parse(oaresponseData);
	//环节
	var data = {
		title: '数据',
		nodeslist:responseData.nodesdata,
	};
	html = template('nodetemplate', data);
	$("#nextnode").html(html).trigger("create");
	//人员
	var personNum = responseData.nodesdata[0].personsdata.length;//处理人个数
	if(personNum==0){
		$("#searchPersonli").show();
	}else if(personNum==1){
		var data = {
			title: '数据',
			personlist:responseData.nodesdata[0].personsdata,
		};
		var choosePersonHtml = template('siglePerson', data);
		$("#PersonLi").html(choosePersonHtml).trigger("create");
		$("li[name='PersonLi']").show();
		$("li[name='choosePersonLi']").hide();
	}else if(personNum>1){
		var data = {
			title: '数据',
			personlist:responseData.nodesdata[0].personsdata,
		};
		var choosePersonHtml = template('choosePerson', data);
		$("#choosePersonLi").html(choosePersonHtml);
		$("li[name='choosePersonLi']").show();
		namechshow=$("#namechshow").val();
		itcodeshow=$("#itcodeshow").val();
	}else{}
	$( "#nodedialog" ).popup( "open");
}
//环节不确定，人员确定时，切换环节处理人自动更新
function personchange(){
	//环节切换时清空选择的处理人
	$("#namechshow").val("");
	$("#itcodeshow").val("");
	var responseData = JSON.parse(oaresponseData);
	var optionnum = $('#toflownodeid').find('option:selected').attr('number');
	//处理人个数
	var personNum = responseData.nodesdata[optionnum].personsdata.length;
	if(personNum==0){
		$("#searchPersonli").show();
	}else if(personNum==1){
		var data = {
			title: '数据',
			personlist:responseData.nodesdata[optionnum].personsdata,
		};
		var choosePersonHtml = template('siglePerson', data);
		$("#PersonLi").html(choosePersonHtml).trigger("create");
		$("li[name='PersonLi']").show();
		$("li[name='choosePersonLi']").hide();
		$("#searchPersonli").hide();
	}else if(personNum>1){
		var data = {
			title: '数据',
			personlist:responseData.nodesdata[optionnum].personsdata,
		};
		var choosePersonHtml = template('choosePerson', data);
		$("#choosePersonLi").html(choosePersonHtml);
		$("li[name='choosePersonLi']").show();
		$("li[name='PersonLi']").hide();
		$("#searchPersonli").hide();
		namechshow=$("#namechshow").val();
		itcodeshow=$("#itcodeshow").val();
	}else{}
}
//搜索处理人时将结果更新到选择区域
function searchPerson(){
	var searchKey = $("#searchPersonKey").val();
	alert(searchKey);
	if(searchKey==""||searchKey==" "){
		alert("请输入搜索的关键字");return;
	}
	var curITCode = localStorage.getItem("itcode");
	var getpersonUrl = $.hori.getconfig().appServerHost+ "view/oa/attach/Produce/DigiFlowMobile.nsf/SearchPsnAgentV2?OpenAgent&searchKey="+searchKey+"&curITCode="+curITCode+"&data-result=text";
	//alert(getpersonUrl);return;
	$.hori.ajax({
		"type" : "post",
		"url" : getpersonUrl,
		"success" : function(res) {
			//调用json处理模板
			var personData = JSON.parse(res);
			var data = {
				title: '数据',
				personlist: personData.personsdata,
			};
			var choosePersonHtml = template('searchPerson', data);
			$("#choosePersonLi").html(choosePersonHtml);
			$("li[name='choosePersonLi']").show();
			$("li[name='PersonLi']").hide();
		},
		"error" : function(res) {
			$.hori.hideLoading();
			alert("获取数据异常，请稍后重试。");
		}
	});
}
//获取选择的处理人值
function getchooseperson(){
	var itcodestr="";
	var namestr="";
	$("input[name='chooseperson']:checked").each(function(){
		var allnamestr="";
		itcodestr+=$(this).val()+";";
		allnamestr+=$(this).attr('namech');
		var number = allnamestr.indexOf("[");
		namestr+=allnamestr.substring(0,number)+";";
	})
	var namechshowstr = $.trim(namechshow)+$.trim(namestr);
	namechshowstr = namechshowstr.substring(0,namechshowstr.lastIndexOf(";"));
	$("#namechshow").val(namechshowstr);
	var itcodeshowstr = $.trim(itcodeshow)+$.trim(itcodestr);
	itcodeshowstr = itcodeshowstr.substring(0,itcodeshowstr.lastIndexOf(";"));
	$("#itcodeshow").val(itcodeshowstr);
}
function clearPerson(){
	$("#namechshow").val("");
	$("#itcodeshow").val("");
}