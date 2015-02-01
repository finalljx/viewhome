$(document).ready(function() {
     getAttach();
});


var jsonData = new Object();
function viewfile(url) {
		var url = $(url).data("url");
		url=url.substring(3);
		url=$.hori.getconfig().appServerHost+'view/oa/file'+url;
		localStorage.setItem("attachmentUrl", url);
		$.hori.loadPage($.hori.getconfig().serverBaseUrl
				+ "viewhome/html/attachmentShowForm.html","viewhome/xml/AttachView.xml");
	}
	function viewfile1(item) {
		var url = item.url();
		if(url==""){
		   return;
		}
		var size=localStorage.getItem("serverLength");
		var number=parseInt(size)+7;
		url=url.substring(number);
		url=$.hori.getconfig().appServerHost+'view/oa/file'+url;
		localStorage.setItem("attachmentUrl", url);
		$.hori.loadPage($.hori.getconfig().serverBaseUrl
				+ "viewhome/html/attachmentShowForm.html","viewhome/xml/AttachView.xml");
	}
	function getAttach(){
			var server =$.hori.getconfig().server;
			localStorage.setItem("serverLength",server.length);
	        var dbpath =$("#dbpath").val();
	        var unid=localStorage.getItem("annoucedocunid");
		   var AttachMentUrl=$.hori.getconfig().appServerHost+"view/oa/attach/Produce/SysInterface.nsf/getAttachment?openagent&server="+server+"&dbpath="+dbpath+"&unid="+unid+"&data-result=text";
        $.hori.ajax({
				"type":"post",
				"url":AttachMentUrl,
				"success":function(res){
				var list = JSON.parse(res);
				if(list.word[0]==undefined){
					list.word[0]={"name":"无正文内容","url":""};
					$("li#word").hide();
					$("li#word").prev().hide();
					
					}else{
						if(list.word.length>1){
							for(var i=0; i<list.word.length;i++){
								if(list.word[i].name="TANGER_OCX_Attachment.pdf"){
									var url=list.word[i].url;
									list.word=[{
											"name" : "点击这里查看正文",
											"url" : url
									}];
								}
							}
						}
						else{
 							if(list.word[0].name.indexOf("TANGER_OCX_Attachment")>=0){
 								list.word[0].name="点击这里查看正文";
 							}
 							
 						}
						
					}
					jsonData.word=list.word;
					renderDetail();
				},
				"error":function(res){
					$.hori.hideLoading();
				}
			});
         
		}
		function renderDetail() {
		var viewModelDetail = ko.mapping.fromJS(jsonData);
		console.log(viewModelDetail);
		ko.applyBindings(viewModelDetail, document.getElementById("word"));
	}