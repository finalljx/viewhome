var app=window.app={
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
	alert(oaServerName);
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
