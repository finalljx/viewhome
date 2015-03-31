$(document).ready(function(){
	var responseData2;
	var personData2;
	var namechshow;
	var itcodeshow;
	//getnodedialogData();
});

//获取数据
function getnodedialogData(){
	//responseData2 = '{"state":"1","nodesdata":[{"number":"0","nodevalue":"FlowNode9","nodech":"相关部门会签","persondsdata":[{"name":"111","itcode":"50002000"},{"name":"222","itcode":"50002000"},{"name":"333","itcode":"50002000"}]}]}';
	//responseData2 = '{"state":"2","nodesdata":[{"number":"0","nodevalue":"FlowNode9","nodech":"相关部门会签","persondsdata":[{"name":"111","itcode":"50002000"},{"name":"222","itcode":"50002000"}]},{"number":"1","nodevalue":"FlowNode6","nodech":"文书核稿","persondsdata":[{"name":"aaa","itcode":"50002000"},{"name":"bbb","itcode":"50002000"}]}]}';
	responseData2 = '{"state":"3","nodesdata":[{"number":"0","nodevalue":"FlowNode9","nodech":"相关部门会签"},{"number":"1","nodevalue":"FlowNode6","nodech":"文书核稿"},{"number":"1","nodevalue":"FlowNode6","nodech":"test"}]}';
	personData2= '{"state":"4","personsdata":[{"nameCh":"张黎明[公司办公室]","itcode":"111"},{"nameCh":"dddddd[公司办公室]","itcode":"222"},{"nameCh":"bbbbbb[公司办公室]","itcode":"333"}]}'
	usetemplate(responseData2);
}
//根据不同情况选用对应的处理模板
function usetemplate(response){
	var html;
	var responseData = JSON.parse(response);
	//alert(responseData.nodesdata[0].persondsdata);
	if(responseData.state=="1"){
		var data = {
			title: '数据',
			nodeslist:responseData.nodesdata[0].nodech,
			personlist: responseData.nodesdata[0].persondsdata,
		};
		html = template('allSure', data);
		$("#nodedialog").html(html);
	}else if(responseData.state=="2"){
		var data = {
			title: '数据',
			nodeslist:responseData.nodesdata,
			personlist: responseData.nodesdata[0].persondsdata,
		};
		html = template('personSure', data);
		alert(html);
		$("#nodedialog").html(html).trigger("create");
	}else if(responseData.state=="3"){
		var data = {
			title: '数据',
			nodeslist:responseData.nodesdata,
		};
		html = template('allNotSure', data);
		$("#nodedialog").html(html);
	}else{
		alert("数据异常，请联系管理员！");
	}
	
}
//环节不确定，人员确定时，切换环节处理人自动更新
function personchange(){
	var responseData = JSON.parse(responseData2);
	var optionnum = $('#toflownodeid').find('option:selected').attr('number');
	var data = {
		title: '数据',
		personlist: responseData.nodesdata[optionnum].persondsdata,
	};
	html = template('personreplace', data);
	$("#personli").html(html);
}
//搜索处理人时将结果更新到选择区域
function searchPerson(){
	namechshow=$("#namechshow").val();
	itcodeshow=$("#itcodeshow").val();
	var personData = JSON.parse(personData2);
	var data = {
		title: '数据',
		personlist: personData.personsdata,
	};
	html = template('searchpersonreplace', data);
	$("#choosePersonLi").html(html);
	$("li[name='choosePersonLi']").show();
}
//获取选择的处理人值
function getchooseperson(){
	var itcodestr="";
	var namestr="";
	$("input[name='chooseperson']:checked").each(function(){
		var allnamestr="";
		itcodestr+=$(this).val()+",";
		allnamestr+=$(this).attr('namech');
		var number = allnamestr.indexOf("[");
		namestr+=allnamestr.substring(0,number)+",";
	})
	$("#namechshow").val($.trim(namechshow)+$.trim(namestr));
	$("#itcodeshow").val($.trim(itcodeshow)+$.trim(itcodestr));
}
//test
function test(){
	personData2= '{"state":"4","personsdata":[{"nameCh":"a1[公司办公室]","itcode":"a"},{"nameCh":"b1[公司办公室]","itcode":"b"},{"nameCh":"c1[公司办公室]","itcode":"c"}]}'
}