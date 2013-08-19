(function(app){
app.viewModel=function(data){
	var jsonData=JSON.parse(data);
	
	var mapping={"href":{
		update:function(options){
			var config=$.hori.getconfig();
			var targetURL= config.serverBaseUrl+"viewhome/html/unreadShowForm.html"
			var ServerName=config.oaServerName;
			var itcode=localStorage.getItem("itcode");
			if(itcode!=null){

				
				itcode=decrypt(config.encryptKey,itcode);
			}
			var docunid=options.data;
			var oaMsgUrl="/Produce/DigiFlowMobile.nsf/showform?openform&login&apptype=msg&appserver="+ServerName+"&appdbpath=DFMessage/dfmsg_"+itcode+".nsf&appdocunid="+docunid;
			return oaMsgUrl;
		}
	}};
	var viewModel=ko.mapping.fromJS(jsonData,mapping);
	
	return viewModel;


}
})(app)
