$(document).ready(function(){
	var hori=$.hori;
	$.hori.showLoading();
	hori.setHeaderTitle("人员信息");
	getUser();
});
//获取用户详细信息
function getUser(){
	var userid = localStorage.getItem("userid");;
	var soap ="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:urn='urn:DefaultNamespace' xmlns:web='http://webService.contant.com/'>";
	soap+='<soapenv:Header></soapenv:Header> <soapenv:Body>';
	soap+='<web:searchUser>'+'<arg0></arg0><arg1></arg1><arg2>'+userid+'</arg2><arg3></arg3><arg4></arg4><arg5></arg5></web:searchUser>';
	soap+="</soapenv:Body></soapenv:Envelope>";
	var url = $.hori.getconfig().appServerHost+"/view/contact/getContactList/ContantWebService/ContantWebServcieService";
	var data = "data-xml="+soap;
	$.hori.ajax({
		"type" : "post",
		"url" : url,
		"data":data,
		"success" : function(res) {
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
	document.getElementById('divContactCon').innerHTML = html;
	$.hori.hideLoading();
}