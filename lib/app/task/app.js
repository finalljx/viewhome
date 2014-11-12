var app=window.app={
};
/*
 * 
 * 解析服务器返回json{"taskCount":"","tasklist":[{},{}],"needLogin":""}
 */
app.getData=function(args){
	var dataSource=args.dataSource;
	$.hori.ajax({
		"type":"post",
		"url":dataSource,
		"data":"",
		"success":function(res){
			var jsonObj=JSON.parse(res);
			if(jsonObj.needLogin){
				var redirectUrl=document.location.href;
				$.hori.jumpToLogin({"redirecUrl":redirectUrl});
				return ;
			}
			app.render(res);
			$("#divDataLoading").hide();

			$.hori.hideLoading();

		},
		"error":function(res){
			alert(res);
			$.hori.hideLoading();

			$("#divDataLoading").hide();

		}
	});
	
};
app.openDoc=function(src){
	var oaurl=src.name;
	localStorage.setItem("oaDataSource",oaurl);
	var targetURL= $.hori.getconfig().serverBaseUrl+"viewhome/html/appform.html";
	targetURL=encodeURI(targetURL);
	
	$.hori.loadPage(targetURL);
};
app.render=function(jsonData){
	var viewModel=app.viewModel(jsonData);
	
	ko.applyBindings(viewModel);
};
$(document).ready(function(){
	var hori=$.hori;
	$.hori.showLoading();
	hori.setHeaderTitle("待办");
	var config=$.hori.getconfig();
	var itcode=localStorage.getItem("itcode");
	
	var oaMsgServer=config.oaMsgServer;
	var serverUrl=config.appServerHost;
	var dataSource=
	serverUrl+'view/oamobile/todosmobile/Produce/DigiFlowMobile.nsf/agGetMsgViewData?openagent&login&server='+oaMsgServer+'&dbpath=DFMessage/dfmsg_'+'admin'+'.nsf&view=vwTaskUnDoneForMobile&thclass=&page=1&count=20';

	app.getData({
		"dataSource":dataSource
	});
});
