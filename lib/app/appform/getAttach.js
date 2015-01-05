$(document).ready(function() {
     getAttach();
});
var jsonData = new Object();
function getAttach() {
	var server = $("#appserver").val();
	localStorage.setItem("serverLength", server.length);
	var dbpath = $("#appdbpath").val();
	var unid = $("#appdocunid").val();
	var AttachMentUrl = $.hori.getconfig().appServerHost
			+ "view/oa/attach/Produce/SysInterface.nsf/getAttachment?openagent&server="
			+ server + "&dbpath=" + dbpath + "&unid=" + unid
			+ "&data-result=text";
	$.hori.ajax({
		"type" : "post",
		"url" : AttachMentUrl,
		"success" : function(res) {
			var list = JSON.parse(res);
			if (list.word[0] == undefined) {
				list.word[0] = {
					"name" : "无正文内容",
					"url" : ""
				};
				$("li.word").hide();

			}
			jsonData.word = list.word;
			renderDetail();
			if (list.attachment[0] == undefined) {
				list.attachment[0] = {
					"name" : "无附件",
					"url" : ""
				};

			}
			jsonData.attachment = list.attachment;
			renderDetail2();
		},
		"error" : function(res) {
			$.hori.hideLoading();
		}
	});

}
function renderDetail() {
	var viewModelDetail = ko.mapping.fromJS(jsonData);
	console.log(viewModelDetail);
	ko.applyBindings(viewModelDetail, document.getElementById("word"));
}
function renderDetail2() {
	var viewModelDetail = ko.mapping.fromJS(jsonData);
	console.log(viewModelDetail);
	ko.applyBindings(viewModelDetail, document.getElementById("attachment"));
}
function viewfile(item) {

	var url = item.url();
	if (url == "") {
		return;
	}
	var size = localStorage.getItem("serverLength");
	var number = parseInt(size) + 7;
	url = url.substring(number);
	url = $.hori.getconfig().appServerHost + 'view/oa/file' + url;
	localStorage.setItem("attachmentUrl", url);
	$.hori.loadPage($.hori.getconfig().serverBaseUrl
			+ "viewhome/html/attachmentShowForm.html","viewhome/xml/AttachView.xml");
}