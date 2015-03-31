$(document).ready(function(){
	var hori=$.hori;
	hori.setHeaderTitle("通讯录");
});
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
//用户列表数据展示
function showContactUsers(res){
	var responseData = JSON.parse(res);
	var usersdata = {
		title: '用户列表',
		list: responseData.data,
		};
	var html = template('contactUsers', usersdata);
	$("#empty_bg").hide();
	document.getElementById('divContactCon').innerHTML = html;
	$.hori.hideLoading();
}
function loadContact(str){
	var userid = $(str).data("userid");
	localStorage.setItem("userid",userid);
	$.hori.showLoading();
	$.hori.loadPage($.hori.getconfig().serverBaseUrl+ 'viewhome/html/searchUser.html')
}
