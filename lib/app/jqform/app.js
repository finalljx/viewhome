$(document).ready(function(){
	
	$.hori.setHeaderTitle("加签");
	var config=$.hori.getconfig();
	var itcode=localStorage.getItem("itcode");

	var oaServerName=localStorage.getItem("oaServerName");
	var serverUrl=$.hori.getconfig().appServerHost+"view/oamobile/contentmobile";
	
	var dataSource=localStorage.getItem("oajqDataSource");
	var localServer=$.hori.getconfig().serverBaseUrl;
	
	
	var oaAppContentHtml=localStorage.getItem("oaAppContentHtml");
	$("#divAppContent").html(oaAppContentHtml);


});


// 加签人查询
function jqsearch(){
	var username = $("#username").val();
	if($.trim(username)==""){
		alert('请输入关键字 ');
		return ;
	}
	
	$.hori.showLoading();
	var url = $.hori.getconfig().appServerHost+"view/oamobile/operationsearch/Produce/DigiFlowMobile.nsf/SearchPsnAgent?openagent&searchKey="+username;
	$.hori.ajax({
		type: "get", url: url,
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
		//jq(p1, p2);
		var p3 = $("#isUseFlowWS").val();
		if(p3=="yes"){
			FlowBackTraceForWSJQ(p2);
			return;
		}else{
			jq(p1, p2);
		}
	}
}

function jq(optpsnid, tempauthors){
	var appserver = $("#appserver").val();
	var appdbpath = $("#appdbpath").val();
	var appdocunid = $("#appdocunid").val();
	var CurUserITCode = $("#CurUserITCode").val();

	var FlowMindInfo = $("#FlowMindInfo").val();
	if(FlowMindInfo=="" || FlowMindInfo==null || FlowMindInfo==" "){
		FlowMindInfo = "加签";
	}

	var MsgTitle = $("#MsgTitle").val();
	if(MsgTitle+""=="undefined")MsgTitle="";
	FlowMindInfo = escape(FlowMindInfo);
	FlowMindInfo = FlowMindInfo.replace(/%20/g," ");

	
	if(window.navigator.userAgent.match(/iPad/i) || window.navigator.userAgent.match(/iPhone/i) || window.navigator.userAgent.match(/iPod/i)) {
		FlowMindInfo = encodeURI(FlowMindInfo);
	}

	MsgTitle = encodeURI(escape(MsgTitle));
	tempauthors = encodeURI(escape(tempauthors));
	
	var soap = "<SOAP-ENV:Envelope xmlns:SOAP-ENV='http://schemas.xmlsoap.org/soap/envelope/' xmlns:SOAP-ENC='http://schemas.xmlsoap.org/soap/encoding/' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema'><SOAP-ENV:Body><m:bb_dd_GetDataByView xmlns:m='http://sxg.bbdd.org' SOAP-ENV:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/'><db_Flag xsi:type='xsd:string'>fromMobile</db_Flag><db_ServerName xsi:type='xsd:string'>"+appserver+"</db_ServerName><db_DbPath xsi:type='xsd:string'>"+appdbpath+"</db_DbPath><db_DocUID xsi:type='xsd:string'>"+appdocunid+"</db_DocUID><db_UpdInfo xsi:type='xsd:string'></db_UpdInfo><db_OptPsnID xsi:type='xsd:string'>"+CurUserITCode+"</db_OptPsnID><db_TempAuthors xsi:type='xsd:string'>"+tempauthors+"</db_TempAuthors><db_MsgTitle xsi:type='xsd:string'>"+MsgTitle+"</db_MsgTitle><db_ToNodeId xsi:type='xsd:string'></db_ToNodeId><db_Mind xsi:type='xsd:string'>"+FlowMindInfo+"</db_Mind><db_OptType xsi:type='xsd:string'>append</db_OptType><db_AppAgentName xsi:type='xsd:string'></db_AppAgentName><db_SelectPsn xsi:type='xsd:string'></db_SelectPsn></m:bb_dd_GetDataByView></SOAP-ENV:Body></SOAP-ENV:Envelope>";
	//SendMsgMobileAgent
	//alert(soap);
	//return false;
	$.hori.showLoading();
	var url = $.hori.getconfig().appServerHost+"view/oa/request/Produce/ProInd.nsf/THFlowBackTraceAgent?openagent&login";
	var data = "data-xml="+soap;
	$.hori.ajax({
		type: "post", url: url, data:data,
		success: function(response){
			$.hori.hideLoading();
			var result = response;
			alert(result);
			setTimeout("$.hori.backPage(1)",1000);									
		},
		error:function(response){
			alert(response);
			$.hori.hideLoading();										
		}
	});
}

function getOrg(value){
	if($("#"+value+"C").html().indexOf("-")!=-1){
		$("#"+value).html("");
		$("#"+value+"C").html("+");
		return;
	}
	
	var url = $.hori.getconfig().appServerHost+"view/oamobile/operationsuborg/Produce/DigiFlowOrgSysMng.nsf/OrgTreeForAddressAgent?openagent";
	var data = "data-xml="+value+";;;<xsl:value-of select='//userid/text()'/>";
	$.hori.showLoading();
	$.hori.ajax({
		type: "post", url: url, data:data,
		success: function(response){
			$.hori.hideLoading();
			$("#"+value).html(response);
			$("#"+value+"C").html("-");
		},
		error:function(response){
			alert(response);
			$.hori.hideLoading();
		}
	});
}
function viewPerson(value){
	$.hori.showLoading();
	var url = $.hori.getconfig().appServerHost+"view/oamobile/operationperson/Produce/DigiFlowMobile.nsf/ajaxGetPsnList?openagent&deptid="+value;
	$.hori.ajax({
		type: "get", url: url,
		success: function(response){
			$.hori.hideLoading();
			$("#viewValue").html(response);
			$("#viewValue ul").listview();
			$("#viewValue ul").listview();
			
			$( "#myCollapsibleSet" ).children().trigger("collapse");
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
