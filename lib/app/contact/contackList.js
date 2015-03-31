var app=window.app={
}
$(document).ready(function(){
	var hori=$.hori;
	$.hori.showLoading();
	getContactList();
	$.hori.registerEvent("case", "navButtonTouchUp", function(oper) {
		app.searchContact();
	});
});
app.searchContact=function(){
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl+ 'viewhome/html/contact.html')
};
function getContactList(){
	var orgid = localStorage.getItem("contactorgid");;
	var soap ="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:urn='urn:DefaultNamespace' xmlns:web='http://webService.contant.com/'>";
	soap+='<soapenv:Header></soapenv:Header> <soapenv:Body>';
	soap+='<web:getDeptList>'+'<arg0>'+orgid+'</arg0>'+'</web:getDeptList>';
	soap+="</soapenv:Body></soapenv:Envelope>";
	var url = $.hori.getconfig().appServerHost+"/view/contact/getContactList/ContantWebService/ContantWebServcieService";
	var data = "data-xml="+soap;
	$.hori.ajax({
		"type" : "post",
		"url" : url,
		"data":data,
		"success" : function(res) {
			var resJson = JSON.parse(res);
			if(resJson.msg=="获取数据异常null"){
				getContactUsers();
			}else{
				var contacttitle = localStorage.getItem("contacttitle");
				$.hori.setHeaderTitle(contacttitle);
				showContactList(res);
			}
		},
		"error" : function(res) {
			$.hori.hideLoading();
			alert("获取组织列表异常！");
		}
	})
}
//部门列表数据展示
function showContactList(res){
	var responseData = JSON.parse(res);
	//alert(responseData.data[1].orgName);return;
	var data = {
		title: '数据列表',
		list: responseData.data,
		};
	var html = template('contactList', data);
	$('#divDataLoading').css("display","none");
	$('#searchContactDiv').css("display","block");
	document.getElementById('divContactCon').innerHTML = html;
	$.hori.hideLoading();
}
function getContactUsers(){
	var orgid = localStorage.getItem("contactorgid");;
	var soap ="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:urn='urn:DefaultNamespace' xmlns:web='http://webService.contant.com/'>";
	soap+='<soapenv:Header></soapenv:Header> <soapenv:Body>';
	soap+='<web:searchUser>'+'<arg0></arg0><arg1></arg1><arg2></arg2><arg3>'+orgid+'</arg3><arg4></arg4><arg5></arg5></web:searchUser>';
	soap+="</soapenv:Body></soapenv:Envelope>";
	var url = $.hori.getconfig().appServerHost+"/view/contact/getContactList/ContantWebService/ContantWebServcieService";
	var data = "data-xml="+soap;
	$.hori.ajax({
		"type" : "post",
		"url" : url,
		"data":data,
		"success" : function(res) {
			var resJson = JSON.parse(res);
			if(resJson.msg=="0"){
				getUser();
			}else{
				$.hori.setHeaderTitle("用户列表");
				showContactUsers(res);
			}
		},
		"error" : function(res) {
			$.hori.hideLoading();
			alert("获取用户列表异常！");
		}
	})
}
//用户列表数据展示
function showContactUsers(res){
	var responseData = JSON.parse(res);
	var usersdata = {
		title: '用户列表',
		list: responseData.data,
		};
	var html = template('contactUsers', usersdata);
	$('#divDataLoading').css("display","none");
	//$('#searchContactDiv').css("display","block");
	document.getElementById('divContactCon').innerHTML = html;
	$.hori.hideLoading();
}
//获取用户详细信息
function getUser(){
	var orgid = localStorage.getItem("contactorgid");;
	var soap ="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:urn='urn:DefaultNamespace' xmlns:web='http://webService.contant.com/'>";
	soap+='<soapenv:Header></soapenv:Header> <soapenv:Body>';
	soap+='<web:searchUser>'+'<arg0></arg0><arg1></arg1><arg2>'+orgid+'</arg2><arg3></arg3><arg4></arg4><arg5></arg5></web:searchUser>';
	soap+="</soapenv:Body></soapenv:Envelope>";
	var url = $.hori.getconfig().appServerHost+"/view/contact/getContactList/ContantWebService/ContantWebServcieService";
	var data = "data-xml="+soap;
	$.hori.ajax({
		"type" : "post",
		"url" : url,
		"data":data,
		"success" : function(res) {
			$.hori.setHeaderTitle("用户信息");
			showUser(res);
		},
		"error" : function(res) {
			$.hori.hideLoading();
			alert("获取用户信息异常！");
		}
	})
}
//用户列表数据展示
function showUser(res){
	var responseData = JSON.parse(res);
	var userdata = {
		title: '用户列表',
		list: responseData.data,
		};
	var html = template('contactUser', userdata);
	$('#divDataLoading').css("display","none");
	//$('#searchContactDiv').css("display","block");
	document.getElementById('divContactCon').innerHTML = html;
	$.hori.hideLoading();
}
function loadContact(str){
	var orgid = $(str).data("orgid");
	localStorage.setItem("contactorgid",orgid);
	var titlename = $(str).data("titlename");
	localStorage.setItem("contacttitle",titlename);
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl+ 'viewhome/html/newcontact.html')
}
function searchContactUser(){
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl+ 'viewhome/html/contact.html');
}
var itcode=localStorage.getItem("itcode");
//当前用户
var currentUser=itcode;
//查询key
var searchStr;
function searchContact(){
    searchStr= $("#phonenumber").val();
    if($.trim(searchStr)!=""&&searchStr.length>=2){
		 var itcode=searchStr.substr(0,1);
		  if(!isNaN(Number(itcode))){
			  if($.trim(searchStr.length)<8){
				  alert("请输入8位的员工编号");
				  return;
			  }
		  }
	  }else{
		  alert('请输入至少两个关键字或者8位的员工编号');
		  return;
	  }
    searchStr= $.hori.escapeData(searchStr); //对数据escape
  	$.hori.showLoading();
	var soap ="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:urn='urn:DefaultNamespace' xmlns:web='http://webService.contant.com/'>";
	soap+='<soapenv:Header></soapenv:Header> <soapenv:Body>';
	soap+='<web:searchUser>'+'<arg0>'+currentUser+'</arg0>'+'<arg1>'+searchStr+'</arg1>'+'<arg2></arg2><arg3></arg3><arg4></arg4><arg5>500</arg5>'+'</web:searchUser>';
	soap+="</soapenv:Body></soapenv:Envelope>";
	var url = $.hori.getconfig().appServerHost+"/view/contact/getContactList/ContantWebService/ContantWebServcieService";
	var date = "data-xml="+soap;
	$.hori.ajax({
		type: "post", url: url,data:date,
		success: function(res){
			var list = JSON.parse(res);
			if(list.msg==0){
				alert("没有此人的相关信息");
				$.hori.hideLoading();
				return;
			}
			$.hori.setHeaderTitle("人员列表");
			showContactUsers(res);
		},
		error:function(response){
			var result = response;
			$.hori.hideLoading();
			alert("error");
		}
	});
}