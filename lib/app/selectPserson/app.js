$(document).ready(function(){
	
	$.hori.setHeaderTitle("选择人员");
	var config=$.hori.getconfig();
	var itcode=localStorage.getItem("itcode");

	var oaServerName=localStorage.getItem("oaServerName");
	var serverUrl=$.hori.getconfig().appServerHost+"view/oamobile/contentmobile";
	
	var dataSource=localStorage.getItem("oajqDataSource");
	var localServer=$.hori.getconfig().serverBaseUrl;
	
	
	var oaAppContentHtml=localStorage.getItem("oaAppContentHtml");
	$("#divAppContent").html(oaAppContentHtml);

});



function selectOaPerson(){
	var username = $("#username").val();
	if($.trim(username)==""){
		alert('请输入关键字 ');
		return ;
	}
	
	$.hori.showLoading();
	var url = $.hori.getconfig().appServerHost+"view/oamobile/operationsearch/Produce/DigiFlowMobile.nsf/SearchPsnAgent?openagent&searchKey="+username;
	$.hori.ajax({
		type: "post", url: url,
		success: function(response){
			$.hori.hideLoading();
			//hiddenLoading();
			$("#viewValue").html(response);
			$("#viewValue ul").listview();
			$("#viewValue ul").listview();    
		},
		error:function(response){
			
			alert(response);
			$.hori.hideLoading();
		}
	});
}
function sure(){
	var persons = $(':input:radio:checked');
	if(persons.length == 0){
		alert("请选择人员!");
	}else{
		var p1 = $(persons[0]).val();
		var p2 = $(persons[0]).attr("id");
		postToNextNode(p1, p2);
	}
}

function postToNextNode(optpsnid, tempauthors){
	var appserver = $("#appserver").val();
	var appdbpath = $("#appdbpath").val();
	var appdocunid = $("#appdocunid").val();
	var CurUserITCode = $("#CurUserITCode").val();
	//var toNodeId=$("#TFCurNodeID").val();
	var toNodeId=localStorage.getItem("oaNextNodeId");
	var FlowMindInfo =localStorage.getItem("FlowMindInfo");
	var MsgTitle = $("#MsgTitle").val();
	if(MsgTitle+""=="undefined")MsgTitle="";
	//FlowMindInfo = encodeURI(escape(FlowMindInfo));
	MsgTitle = encodeURI(escape(MsgTitle));
	tempauthors = encodeURI(escape(tempauthors));

	//将回车变为换行
	FlowMindInfo = FlowMindInfo.replace(/\n/g," ");
	FlowMindInfo = FlowMindInfo.replace(/\r/g," ");
	FlowMindInfo = encodeURI(escape(FlowMindInfo));
	//FlowMindInfo = escape(FlowMindInfo);
	FlowMindInfo = FlowMindInfo.replace(/%20/g," ");

	if(window.navigator.userAgent.match(/iPad/i) || window.navigator.userAgent.match(/iPhone/i) || window.navigator.userAgent.match(/iPod/i)) {
		FlowMindInfo = encodeURI(FlowMindInfo);
	}
     
	var selectPsn=optpsnid;
	var value=localStorage.getItem("value");
	
	var soap = "<SOAP-ENV:Envelope xmlns:SOAP-ENV='http://schemas.xmlsoap.org/soap/envelope/' xmlns:SOAP-ENC='http://schemas.xmlsoap.org/soap/encoding/' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema'><SOAP-ENV:Body><m:bb_dd_GetDataByView xmlns:m='http://sxg.bbdd.org' SOAP-ENV:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/'><db_Flag xsi:type='xsd:string'>fromMobile</db_Flag><db_ServerName xsi:type='xsd:string'>"+appserver+"</db_ServerName><db_DbPath xsi:type='xsd:string'>"+appdbpath+"</db_DbPath><db_DocUID xsi:type='xsd:string'>"+appdocunid+"</db_DocUID><db_UpdInfo xsi:type='xsd:string'></db_UpdInfo><db_OptPsnID xsi:type='xsd:string'>"+CurUserITCode+"</db_OptPsnID><db_TempAuthors xsi:type='xsd:string'>"+tempauthors+"</db_TempAuthors><db_MsgTitle xsi:type='xsd:string'></db_MsgTitle><db_ToNodeId xsi:type='xsd:string'>"+toNodeId+"</db_ToNodeId><db_Mind xsi:type='xsd:string'>"+FlowMindInfo+"</db_Mind><db_OptType xsi:type='xsd:string'>"+value+"</db_OptType><db_SelectPsn xsi:type='xsd:string'>"+selectPsn+"</db_SelectPsn></m:bb_dd_GetDataByView></SOAP-ENV:Body></SOAP-ENV:Envelope>";
	$.mobile.showPageLoadingMsg();
	var url = $.hori.getconfig().appServerHost+"view/oa/request/Produce/ProInd.nsf/THFlowBackTraceAgent?openagent&login";
	var data = "data-xml="+soap;
	$.hori.ajax({
		type: "post", url: url, data:data,
		success: function(response){
			$.hori.hideLoading();
			var result = response;
			alert(result);
			setTimeout("$.hori.backPage(1)",1000);
			//var targetUrl = $.hori.getconfig().serverBaseUrl+ "viewhome/html/task.html";
	        //$.hori.loadPage(encodeURI(targetUrl));
		},
		error:function(response){
			alert(response);
			$.hori.hideLoading();										
		}
	});
}



function back(){
	$.hori.backPage(1);
	
}
