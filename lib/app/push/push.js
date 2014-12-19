function sendSms() {
	
}
/**
 * 消息推送
 * 
 * @param userId
 * @param msg
 */
function pushMsg(userId, msg) {
	if (userId == undefined || userId == '') {
		alert("没有有效的用户id");
		return;
	}
	if (msg == undefined || msg == '') {
		alert("没有有效的消息内容");
		return;
	}
	var url = $.hori.getconfig().appServerHost
			+ "view?data-action=push&data-channel=mobileapp&data-userid="
			+ userId ;
	alert(url);
			$.hori.ajax({
				"type" : "post",
				"url" : url,
				"data" : "data-message=" + escape(msg),
				"success" : function(res) {
					alert(res);
					var json = JSON.parse(res);

				},
				"error" : function(res) {
					alert("推送错误" + res);
				}
			})
}