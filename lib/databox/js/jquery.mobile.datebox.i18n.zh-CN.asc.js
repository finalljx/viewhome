/*
 * jQuery Mobile Framework : plugin to provide a date and time picker.
 * Copyright (c) JTSage
 * CC 3.0 Attribution.  May be relicensed without permission/notifcation.
 * https://github.com/jtsage/jquery-mobile-datebox
 *
 * Translation by: ChiElvis <elvis311@msn.com>, josher19 <crowdin>
 *
 */

jQuery.extend(jQuery.mobile.datebox.prototype.options.lang, {
	'zh-CN': {
		setDateButtonLabel: "&#35774;&#32622;&#26085;&#26399;",
		setTimeButtonLabel: "&#35774;&#32622;&#26102;&#38388;",
		setDurationButtonLabel: "&#35774;&#32622;&#25345;&#32493;&#26102;&#38388;",
		calTodayButtonLabel: "&#36873;&#25321;&#20170;&#22825;&#26085;&#26399;",
		titleDateDialogLabel: "&#36873;&#25321;&#26085;&#26399;",
		titleTimeDialogLabel: "&#36873;&#25321;&#26102;&#38388;",
		daysOfWeek: ["&#26143;&#26399;&#26085;", "&#26143;&#26399;&#19968;", "&#26143;&#26399;&#20108;", "&#26143;&#26399;&#19977;", "&#26143;&#26399;&#22235;", "&#26143;&#26399;&#20116;", "&#26143;&#26399;&#20845;"],
		daysOfWeekShort: ["&#26085;", "&#19968;", "&#20108;", "&#19977;", "&#22235;", "&#20116;", "&#20845;"],
		monthsOfYear: ["&#19968;&#26376;", "&#20108;&#26376;", "&#19977;&#26376;", "&#22235;&#26376;", "&#20116;&#26376;", "&#20845;&#26376;", "&#19971;&#26376;", "&#20843;&#26376;", "&#20061;&#26376;", "&#21313;&#26376;", "&#21313;&#19968;&#26376;", "&#21313;&#20108;&#26376;"],
		monthsOfYearShort: ["&#19968;", "&#20108;", "&#19977;", "&#22235;", "&#20116;", "&#20845;", "&#19971;", "&#20843;", "&#20061;", "&#21313;", "&#21313;&#19968;", "&#21313;&#20108;"],
		durationLabel: ["&#22825;", "&#23567;&#26102;", "&#20998;&#38047;", "&#31186;"],
		durationDays: ["&#22825;", "&#22825;"],
		tooltip: "&#24320;&#21551;&#26085;&#26399;&#36873;&#21462;&#22120;",
		nextMonth: "&#19979;&#20010;&#26376;",
		prevMonth: "&#19978;&#20010;&#26376;",
		timeFormat: 24,
		headerFormat: '%A, %B %-d, %Y',
		dateFieldOrder: ['m', 'd', 'y'],
		timeFieldOrder: ['h', 'i', 'a'],
		slideFieldOrder: ['y', 'm', 'd'],
		dateFormat: "%Y-%m-%d",
		useArabicIndic: false,
		isRTL: false,
		calStartDay: 0,
		clearButton: "&#28165;&#38500;",
		durationOrder: ['d', 'h', 'i', 's'],
		meridiem: ["&#19978;&#21320;", "&#19979;&#21320;"],
		timeOutput: "%k:%M",
		durationFormat: "%Dd %DA, %Dl:%DM:%DS",
		calDateListLabel: "&#20854;&#20182;&#26085;&#26399;",
		calHeaderFormat: "%B %Y"
	}
});
jQuery.extend(jQuery.mobile.datebox.prototype.options, {
	useLang: 'zh-CN'
});

