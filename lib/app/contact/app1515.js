var app=window.app={
}
app.test=function(){
	//当前用户
	var currentUser = "80001037";
	//查询key
	var searchStr= "王黎";
	//当前页
	var currentPage  = "1";
	//每页显示条数
	var pageSzie  = "5";
	var soap ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:DefaultNamespace" xmlns:web="http://webService.contant.com/">';
	soap+='<soapenv:Header></soapenv:Header> <soapenv:Body>';
	soap+='<web:searchUser>'+'<arg0>'+currentUser+'</arg0>'+'<arg1>'+searchStr+'</arg1>'+'<arg2>'+currentPage+'</arg2>'+'<arg3>'+pageSzie+'</arg3>'+'</web:searchUser>';
	soap+="</soapenv:Body></soapenv:Envelope>";
	//viewer 拼接这个地址http://thpwspap01.crsc.isc:10050/ContantWebService/ContantWebServcieService
	var url = $.hori.getconfig().appServerHost+"/view/contact/todosmobile/ContantWebService/ContantWebServcieService";
	var date = "data-xml="+soap;
	$.hori.ajax({
		type: "post", url: url,data:date,
		success: function(response){
			//var result = JSON.parse(response);
			alert(response);
			//alert(result.msg);
		},
		error:function(response){
			var result = response;
			alert("error");
		}
	});
}
app.searchContact=function(){
	$.hori.showLoading();
	var username = $("#phonenumber").val();
	
	
	if($.trim(username)==""){
		alert('请输入关键字 ');
		return ;
	}
	
	var config=$.hori.getconfig();
	var oaServerName=localStorage.getItem("oaServerName");
	var serverUrl=config.appServerHost;
	var dataSource=
	serverUrl+ "view/oa/phonenumberrequest/Produce/WeboaConfig.nsf/telSearchForm?openform&svrName="+oaServerName+"&queryStr="+username+"&dbFile=Produce/DigiFlowOrgPsnMng.nsf&showField=UserDeptPhone";
	
	
	$.hori.ajax({
		
		url:dataSource,
		type:"get",
		data:"",
		success:function(res){
			app.render(res);
		},
		error:function(res){
			alert(res);
		}
	});
};
ko.unapplyBindings = function ($node, remove) {
  
    $node.find("*").each(function () {
        $(this).unbind();
    });

    // Remove KO subscriptions and references
    if (remove) {
        ko.removeNode($node[0]);
    } else {
        ko.cleanNode($node[0]);
    }
};
app.render=function(jsonData){
	
	
	if(app.searchCout==0){
		
		var viewModel=app.viewModel(jsonData);
		app.contactViewModel=viewModel;
		ko.applyBindings(viewModel,document.getElementById("divContact"));
		app.searchCout+=1;
	}else{
		app.refreshData(jsonData, app.contactViewModel);
		app.searchCout+=1;
	}
	$.hori.hideLoading();
};

$(document).ready(function(){
	$.hori.registerEvent("case", "navButtonTouchUp", function(oper) {
		app.searchContact();
	});
	app.searchCout=0;
	
});
