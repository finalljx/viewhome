var cherry = new Object();
(function($){
	/*
	 * @author:lvjx @统一cherry脚本，作为jquery扩展函数
	 * 
	 */
	var opts={

		browerDebug:true,
		mobileDebug:false,
		timeOutAlertStr:"请求服务器超时，请检查网络",
		// 默认ajax超时时间，单位毫秒
		timeout:60000
	};
	// _init()中调用不同平台的function 做相应的初始化_cherryIos和_cherryAndroid
	// var cherry;
	var self=this;
	var uma;			// 用户手机浏览器版本

	/*
	 * _getMobileAgent @return :返回用户浏览器类型 @type 对象{ shell:浏览器内核
	 * mobile:undefined|apple|android|webos } @example:var ua=_getMobileAgent();
	 * if[ua["mobile"]]{ }
	 * 
	 * 判断是否是手机
	 * 
	 * 
	 */
	function _getMobileAgent() {

		var ua = navigator.userAgent,
			EMPTY = '', MOBILE = 'mobile',
			core = EMPTY, shell = EMPTY, m,
			IE_DETECT_RANGE = [6, 9], v, end,
			VERSION_PLACEHOLDER = '{{version}}',
			IE_DETECT_TPL = '<!--[if IE ' + VERSION_PLACEHOLDER + ']><s></s><![endif]-->',
			div = document.createElement('div'), s,
			o = {
				// browser core type
				// webkit: 0,
				// trident: 0,
				// gecko: 0,
				// presto: 0,

				// browser type
				// chrome: 0,
				// safari: 0,
				// firefox: 0,
				// ie: 0,
				// opera: 0

				// mobile: '',
				// core: '',
				// shell: ''
			},
			numberify = function(s) {
				var c = 0;
				// convert '1.2.3.4' to 1.234
				return parseFloat(s.replace(/\./g, function() {
					return (c++ === 0) ? '.' : '';
				}));
			};

		// try to use IE-Conditional-Comment detect IE more accurately
		// IE10 doesn't support this method, @ref:
		// http://blogs.msdn.com/b/ie/archive/2011/07/06/html5-parsing-in-ie10.aspx

		div.innerHTML = IE_DETECT_TPL.replace(VERSION_PLACEHOLDER, '');
		s = div.getElementsByTagName('s');

		if (s.length > 0) {

			shell = 'ie';
			o[core = 'trident'] = 0.1; // Trident detected, look for revision

			// Get the Trident's accurate version
			if ((m = ua.match(/Trident\/([\d.]*)/)) && m[1]) {
				o[core] = numberify(m[1]);
			}

			// Detect the accurate version
			// 注意：
			// o.shell = ie, 表示外壳是 ie
			// 但 o.ie = 7, 并不代表外壳是 ie7, 还有可能是 ie8 的兼容模式
			// 对于 ie8 的兼容模式，还要通过 documentMode 去判断。但此处不能让 o.ie = 8, 否则
			// 很多脚本判断会失误。因为 ie8 的兼容模式表现行为和 ie7 相同，而不是和 ie8 相同
			for (v = IE_DETECT_RANGE[0],end = IE_DETECT_RANGE[1]; v <= end; v++) {
				div.innerHTML = IE_DETECT_TPL.replace(VERSION_PLACEHOLDER, v);
				if (s.length > 0) {
					o[shell] = v;
					break;
				}
			}

		} else {

			// Apple Mobile
			if (/ Mobile\//.test(ua)) {
				o[MOBILE] = 'apple'; // iPad, iPhone or iPod Touch
		}
		// Android mobile
		if ((m = ua.match(/ Android /gi))) {
			o[MOBILE] = 'android'; // 
		}
		// webos mobile
		if ((m = ua.match(/webOS \d\.\d/))) {
			o[MOBILE] = 'webos'; // Nokia N-series, Android, webOS, ex:
									// NokiaN95
		}
		// Other WebKit Mobile Browsers
		else if ((m = ua.match(/NokiaN[^\/]*|webOS\/\d\.\d/))) {
			o[MOBILE] = m[0].toLowerCase(); // Nokia N-series, Android, webOS,
											// ex: NokiaN95
		}

		// WebKit
		// alert(ua);
		if ((m = ua.match(/AppleWebKit\/([\d.]*)/)) && m[1]) {
			o[core = 'webkit'] = numberify(m[1]);

			// Chrome
			if ((m = ua.match(/Chrome\/([\d.]*)/)) && m[1]) {
				o[shell = 'chrome'] = numberify(m[1]);
			}
			// Safari
			else if ((m = ua.match(/\/([\d.]*) Safari/)) && m[1]) {
				o[shell = 'safari'] = numberify(m[1]);
			}


		}

		// NOT WebKit
		else {
			// Presto
			// ref: http://www.useragentstring.com/pages/useragentstring.php
			if ((m = ua.match(/Presto\/([\d.]*)/)) && m[1]) {
				o[core = 'presto'] = numberify(m[1]);

				// Opera
				if ((m = ua.match(/Opera\/([\d.]*)/)) && m[1]) {
					o[shell = 'opera'] = numberify(m[1]); // Opera detected,
															// look for revision

					if ((m = ua.match(/Opera\/.* Version\/([\d.]*)/)) && m[1]) {
						o[shell] = numberify(m[1]);
					}

					// Opera Mini
					if ((m = ua.match(/Opera Mini[^;]*/)) && m) {
						o[MOBILE] = m[0].toLowerCase(); // ex: Opera
														// Mini/2.0.4509/1316
					}
					// Opera Mobile
					// ex: Opera/9.80 (Windows NT 6.1; Opera Mobi/49; U; en)
					// Presto/2.4.18 Version/10.00
					// issue: ÓÉÓÚ Opera Mobile ÓÐ Version/ ×Ö¶Î£¬¿ÉÄÜ»áÓë Opera
					// »ìÏý£¬Í¬Ê±¶ÔÓÚ Opera Mobile µÄ°æ±¾ºÅÒ²±È½Ï»ìÂÒ
					else if ((m = ua.match(/Opera Mobi[^;]*/)) && m) {
						o[MOBILE] = m[0];
					}
				}

				// NOT WebKit or Presto
			} else {
				// MSIE
				// ÓÉÓÚ×î¿ªÊ¼ÒÑ¾­Ê¹ÓÃÁË IE
				// Ìõ¼þ×¢ÊÍÅÐ¶Ï£¬Òò´ËÂäµ½ÕâÀïµÄÎ¨Ò»¿ÉÄÜÐÔÖ»ÓÐ IE10+
				if ((m = ua.match(/MSIE\s([^;]*)/)) && m[1]) {
					o[core = 'trident'] = 0.1; // Trident detected, look for
												// revision
					o[shell = 'ie'] = numberify(m[1]);

					// Get the Trident's accurate version
					if ((m = ua.match(/Trident\/([\d.]*)/)) && m[1]) {
						o[core] = numberify(m[1]);
					}

					// NOT WebKit, Presto or IE
				} else {
					// Gecko
					if ((m = ua.match(/Gecko/))) {
						o[core = 'gecko'] = 0.1; // Gecko detected, look for
													// revision
						if ((m = ua.match(/rv:([\d.]*)/)) && m[1]) {
							o[core] = numberify(m[1]);
						}

						// Firefox
						if ((m = ua.match(/Firefox\/([\d.]*)/)) && m[1]) {
							o[shell = 'firefox'] = numberify(m[1]);
						}
					}
				}
			}
		}
		}
		// 如果本地缓存有标记则认为是微信
		if (localStorage.getItem("hori_weixin") && localStorage.getItem("hori_weixin")=="yes")
		{
			o[MOBILE]=null;
		}
		o.core = core;
		o.shell = shell;
		o._numberify = numberify;
		return o;
	}

	/*
	 * _cherryIos _cherryAndroid @description:负责跟手机通讯用脚本 @return {brrdge
	 * 对象，提供跟手机交互桥接功能}
	 */
	function _cherryIos(){

		var bridge = new Object();
		var __nativeReadyQueue = new Array();
		var __scriptReadyQueue = new Array();

		var __runningOperations = new Object();

		bridge._beginNativeOperation = function () {
			var operation = __nativeReadyQueue.shift();
			if (operation != undefined) {
				__runningOperations[operation.__index] = operation;
				return operation.toString();
			} else
				return "";
		};

		bridge._endNativeOperation = function (returnStatus) {
			var operation = __runningOperations[returnStatus.index];
			if (operation) {
				operation.returnValue = returnStatus.returnValue;
				operation.stateCode = returnStatus.stateCode;
				operation._complete();
				delete __runningOperations[returnStatus.index];
			}
		};

		bridge._executeScriptOperations = function () {
			var operation = undefined;
			var executed = false;
			if ((operation = __scriptReadyQueue.shift()) != undefined) {
				operation._execute();
				operation._complete();
				executed = true;
			}
			return executed;
		};

		bridge._batchScriptOperations = function () {
			var count = 0;
			while (bridge._executeScriptOperations())
				count ++;
			return count;
		};

		var __bridgeFrame = (function () {
			frame = document.createElement("iframe");
			frame.setAttribute("width", "0px");
			frame.setAttribute("height", "0px");
			frame.setAttribute("id", "cherry_bridge_frame");
			frame.setAttribute("src", "bridge://localhost/flush");
			document.documentElement.appendChild(frame);
			return frame;
		})();

		bridge.flushOperations = function () {
			var frame = document.getElementById("cherry_bridge_frame");
			// frame.contentDocument.location.reload();
			frame.src = frame.src;
		};

		/**
		 * @class cherry.bridge.Operation
		 * @memberof cherry.bridge
		 * @brief The base class of operations
		 */
		var Operation = function () {
			/**
			 * @detail The operation state state 0, not dispatched state 1,
			 *         waiting state 2, in ready queue state 3, finished
			 * 
			 */
			this.__state = 0;
			this.__stateListener = undefined;
			this.__depCount = 0;
			this.__followers = new Array();
		};

		Operation.prototype.isDispatched = function () {
			return this.__state > 0;
		};

		Operation.prototype.isWaiting = function () {
			return this.__state == 1;
		};

		Operation.prototype.isReady = function () {
			return this.__state == 2;
		};

		Operation.prototype.isFinished = function () {
			return this.__state >= 3;
		};

		Operation.prototype._setState = function (state) {
			if (state != this.__state) {
				this.__state = state;
				if (this.stateListener != undefined)
					this.stateListener(state);
			}
		};

		Operation.prototype._complete = function () {
			this._setState(3);
			var follower = undefined;
			while ((follower = this.__followers.shift()) != undefined) {
				if ((-- follower.__depCount) == 0)
					follower._ready();
			}
		};

		Operation.prototype._ready = function () {
			this._setState(2);
		};

		Operation.prototype.setStateListener = function (stateListener) {
			if (this.isDispatched())
				throw new Error();
			this.__stateListener = stateListener;
		};

		Operation.prototype.addDependency = function (dependency)  {
			if (! dependency instanceof Operation)
				throw new Error();
			if (! dependency.isDispatched())
				throw new Error();
			if (this.isDispatched())
				throw new Error();
			if (!dependency.isFinished()) {
				dependency.__followers.push(this);
				this.__depCount ++;
			}
			return this;
		};

		Operation.prototype.dispatch = function () {
			if (! this.isDispatched()) {
				this._setState(1);
				if (this.__depCount == 0)
					this._ready();
			}
			return this;
		};

		var ScriptOperation = function (func) {
			Operation.apply(this);
			this.__func = func;
		};

		ScriptOperation.prototype = new Operation();

		ScriptOperation.prototype._ready = function () {
			Operation.prototype._ready.apply(this);
			__scriptReadyQueue.push(this);
		};

		ScriptOperation.prototype._execute = function () {
			this.__func(this);
		};

		var __indexCounter = 0;

		var NativeOperation = function (target, method, args) {
			Operation.apply(this);
			this.__target = target;
			this.__method = method;
			this.__args = args;
			this.__index = __indexCounter;
			__indexCounter = ((__indexCounter + 1) & 0x7fffffff);
		};

		NativeOperation.prototype = new Operation();

		NativeOperation.prototype._ready = function () {
			Operation.prototype._ready.apply(this);
			__nativeReadyQueue.push(this);
		};

		NativeOperation.prototype.toString = function () {
			return JSON.stringify({
				'target' : this.__target,
				   'method' : this.__method,
				   'args'   : this.__args,
				   'index'  : this.__index,
			});
		};

		bridge.ScriptOperation = ScriptOperation;
		bridge.NativeOperation = NativeOperation;

		var __eventHandlers = new Object();

		bridge.registerEvent = function (target, eventName, routine) {
			if (__eventHandlers[target] == undefined)
				__eventHandlers[target] = new Object();
			__eventHandlers[target][eventName] = routine;
		};

		bridge._fireEvent = function (params) {
			var target = __eventHandlers[params.source];
			if (!target) {
				return false;	
			}

			var routine = target[params.eventName];
			if (!routine) {
				return false;	
			}

			var operation = new ScriptOperation(routine);
			operation.args = params.args;
			operation.dispatch();
			return true;
		};

		return bridge;
	}




	function _cherryAndroid(){
		var bridge = new Object();

		var __runningOperations = new Object();

		bridge._nativeOperationDidComplete = function (returnStatus) {
			var operation = __runningOperations[returnStatus.operationID];
			if (operation) {
				operation.returnValue = returnStatus.returnValue;
				operation.stateCode = returnStatus.stateCode;
				// alert("delete native operation " + returnStatus.operationID);
				delete __runningOperations[returnStatus.operationID];
			}
		};

		bridge._runScriptOperation = function (operationID) {
			var operation = __runningOperations[operationID];
			if (operation) {
				if (operation.__func) {
					// alert("running script operation:\n"+operation.__func);
					operation.__func.apply();
				}
				// alert("delete script operation " + returnStatus.operationID);
				delete __runningOperations[operationID];
			}
		};

		bridge.flushOperations = function () {
			cherry_bridge.Bridge_flush();
		};

		/**
		 * @class cherry.bridge.Operation
		 * @memberof cherry.bridge
		 * @brief The base class of operations
		 */
		var Operation = function (operationID) {
			// alert('operation: '+operationID);
			this.__operationID = operationID;
			if (__runningOperations[operationID]) {
				alert("Internal error, an existing operation #" + operationID + "is overrided");
			} else {
				__runningOperations[operationID] = this;
			}
		};

		Operation.prototype.addDependency = function (dependency)  {
			cherry_bridge.Operation_addDependency(this.__operationID, dependency.__operationID);
			return this;
		};

		Operation.prototype.dispatch = function () {
			cherry_bridge.Operation_dispatch(this.__operationID);
			return this;
		};

		var ScriptOperation = function (func) {
			var operationID = cherry_bridge.Bridge_createScriptOperation();
			// alert("create script operation #" + operationID);
			Operation.apply(this, [ operationID ]);
			this.__func = func;
		};


		var NativeOperation = function (target, method, args) {
			var operationID = cherry_bridge.Bridge_createNativeOperation(target, method, args);
			// alert("create native operation #" + operationID);
			Operation.apply(this, [ operationID ]);
			this.__target = target;
			this.__method = method;
			this.__args = args;
		};

		operationProto = new Operation(-1);
		ScriptOperation.prototype = operationProto;
		NativeOperation.prototype = operationProto;

		bridge.ScriptOperation = ScriptOperation;
		bridge.NativeOperation = NativeOperation;

		var __eventHandlers = new Object();

		bridge.registerEvent = function (target, eventName, routine) {
			if (__eventHandlers[target] == undefined)
				__eventHandlers[target] = new Object();
			__eventHandlers[target][eventName] = routine;
		};

		bridge._fireEvent = function (params){
			var target = __eventHandlers[params.source];
			if (!target) {
				return false;	
			}

			var routine = target[params.eventName];
			if (!routine) {
				return false;	
			}
			routine();
			return true;
		};

		return bridge;
	}




	/*
	 * @descripttion: 根据不同的平台分别初始化cherry 触发horiInit事件
	 */
	(function _initCherry(){
		var ua=_getMobileAgent();
		var _bridge;


		if(ua["mobile"]){
			if(ua["mobile"]==="apple"){
				// 手机 重置浏览器调试开关
				opts.browerDebug=false;
				_bridge=_cherryIos();
				// 兼容ios客户端暴露cherry.bridge
				// cherry.bridge=cherry;

				// return
			}
			if(ua["mobile"]==="android"){
				opts.browerDebug=false;
				_bridge=_cherryAndroid();

				// return
			}
			if(ua["mobile"]==="weixin"){
				opts.browerDebug=false;
				_bridge=_cherryIos();

				// return
			}
			// $.trigger("horiInit",cherry);
		}else{
			// 可能是浏览器模式,按照ios方式 初始化方便调试
			// cherry={};
			if(opts.browerDebug){
				_bridge=_cherryIos();
			}	
			// cherry=_cherryAndroid();
		}

		cherry=_bridge;
		cherry.bridge=_bridge;
		// 增加ajax 默认超时
		$.ajaxSetup({
			timeout:opts.timeout
		});

	})();
	// 返回给外部调用的对象
	var horiPub={
		/*判断是不是浏览器登陆*/
		isMobileDevice:function(){
			return !opts.browerDebug;
		},
		/*
		 * @param targetUrl @trype String 目标url 相对路径 @param componetXmlUrl @type
		 * string 容器url 相对路径
		 */
		loadPage:function(targetUrl,componetXmlUrl){

					 var ua=_getMobileAgent();
					 if(ua["mobile"]){

						 // var serverUrl=$.cookie("serverBaseUrl");
						 if (typeof(componetXmlUrl) == "undefined" || $.trim(componetXmlUrl) == "") {
							 componetXmlUrl = "viewhome/xml/PureWeb.scene.xml";

						 } else {
							
						 }
						 if (targetUrl == "") {
							 alert("targetUrl参数不能为空 ");
						 }
						 

						 componetXmlUrl=encodeURI(componetXmlUrl);
						 if (opts.mobileDebug) {
							 alert("targetUrl = "+ targetUrl);
							 alert("componetXmlUrl = "+ componetXmlUrl);
						 }

						 var pushScene = new cherry.NativeOperation("application", "pushScene", [componetXmlUrl, targetUrl]);
						 pushScene.dispatch();
						 cherry.flushOperations();
					 }else{
						 if (opts.browerDebug) {
							// 补全请求地址，默认添加appKey参数
							if(targetUrl.indexOf("?") != -1){
								targetUrl = targetUrl + "&data-application=" + $.hori.getconfig().appKey;
							}else{
								targetUrl = targetUrl + "?data-application=" + $.hori.getconfig().appKey;
							}
							 window.location.href = targetUrl;
							 return;
						 }		
					 }
				 },
		/*
		 * @param forceRefresh @type:string @default:"0" 如果强制刷新传"1" 即可
		 */
		backPage: function(forceRefresh) {
					  var ua=_getMobileAgent();
					  if(ua["mobile"]) {
						  if(typeof(forceRefresh) == "undefined"|| parseInt(forceRefresh, 10) == 0) {

							  var refreshFlag = "0";
						  } else {
							  var refreshFlag = "1";
						  }
						  var popScene = new cherry.NativeOperation("application", "popScene", [refreshFlag]);

						  popScene.dispatch();

						  cherry.flushOperations();

					  } else {

						  if(opts.browerDebug) {
							  window.history.go(-1);
							  return;
						  }
					  }
				  },
		//调用jQueryMobile loading
		loading:function(show,text){
			var msg = "加载中，请稍候...";
			if(text != undefined && text != ""){
				msg = text;
			}
			if(show != undefined){
				if(show == "show"){
					$.mobile.loading(show, {
						text: msg,
						theme:"d",
						textonly:false,
						textVisible:true,
						html:""
					});
				}else{
					$.mobile.loading("hide");
				}
			}else{
				$.mobile.loading("show", {
					text: msg,
					theme:"d",
					textonly:false,
					textVisible:true,
					html:""
				});
			}
		},
		// 调用原生loading页面
		showLoading:function(){
						if (opts.browerDebug) {		
							
							
						}
						if(_getMobileAgent()["mobile"]) {

							var loading = new cherry.NativeOperation("application", "showLoadingSheet", ["20"]);
							loading.dispatch();
							cherry.flushOperations();
						}

					},
		// 隐藏原生loading页面
		// @return :无

		hideLoading:function(){
						if (opts.browerDebug) {
							
						}
						if(_getMobileAgent()["mobile"]) {
							var hiddenLoading = new cherry.NativeOperation("application", "hideLoadingSheet", []);
							hiddenLoading.dispatch();
							cherry.flushOperations();

						}
					},
		/*
		 * @description:返回设备的uuid @return :uuid或空串 @type:string @param:callback
		 * 回调函数
		 */
		getDeviceId:function(callback){
						if($.isFunction(callback)){

							var getdeviceIdNative = new cherry.NativeOperation("application", "getDeviceId", []).dispatch();			

							var cherryScript = new cherry.ScriptOperation(function(){
								var deveiceId="";
								deveiceId=getdeviceIdNative.returnValue;				
								callback.apply(this,[deveiceId]);

							});

							cherryScript.addDependency(getdeviceIdNative);		
							cherryScript.dispatch();
							cherry.flushOperations();

						}else{
							alert("请传入正确的回调函数");
						}
					},
		/*
		 * @description:得到手机类型 @return undefined 表示是浏览器
		 * |apple|android|webos|nokia
		 */
		getMobileType:function(){
						  return _getMobileAgent()["mobile"];
					  },

		setHeaderTitle:function(title){
						   var headerTitle="";
						   if(title){
							   headerTitle=title;
						   }
						   new cherry.NativeOperation("case","setProperty",["title",headerTitle]).dispatch();
						   cherry.flushOperations();
					   },
		/*
		 * 返回cherry对象共外部调用
		 */
		"cherry":cherry,
		registerEvent:cherry.registerEvent,
		/* 隐藏title bar的返回 */
		hideBackBtn:function(){
			var setNavigationBack=new cherry.NativeOperation("case","setProperty",["backButtonHidden","1"]);
			setNavigationBack.dispatch();
			cherry.flushOperations();

		},
		/*
		 * getDeviceToken()
		 * 
		 * @description:返回 设备64 位tokenapns 发消息用 @return :64位token 或空串
		 * @type:string @param:callback 回调函数
		 */
		getDeviceToken:function(callback){
						   if($.isFunction(callback)){

							   var getdeviceTokeyNative = new cherry.NativeOperation("application", "getDeviceToken", []).dispatch();			

							   var cherryScript = new cherry.ScriptOperation(function(){
								   var deveiceToken="";
								   deveiceToken=getdeviceTokeyNative.returnValue;	

								   callback.apply(this,[deveiceToken]);

							   });

							   cherryScript.addDependency(getdeviceTokeyNative);		
							   cherryScript.dispatch();
							   cherry.flushOperations();

						   }else{
							   alert("请传入正确的回调函数");
						   }
					   },
	   /*
		 * getClientVersion @description:返回 设备版本号 @return
		 * :客户端版本号 或空串 @type:string
		 */
		getClientFullVersion:function(callback){
							 if($.isFunction(callback)){

								 if(_getMobileAgent()["mobile"]) {
									 var getClientVersionNative = new cherry.NativeOperation("application", "getClientFullVersion", []).dispatch();			

									 var cherryScript = new cherry.ScriptOperation(function(){
										 var clientVersion="";
										 clientVersion=getClientVersionNative.returnValue;	

										 callback.apply(this,[clientVersion]);

									 });

									 cherryScript.addDependency(getClientVersionNative);		
									 cherryScript.dispatch();
									 cherry.flushOperations();
									 return
								 }
								 if (opts.browerDebug) {
									 callback.apply(this,["0.0"]);
								 }

							 }else{
								 alert("请传入正确的回调函数");
							 }
						 },
		/*
		 * getClientVersion @description:返回 设备版本号 @return :客户端版本号 或空串
		 * @type:string
		 */
		getClientVersion:function(callback){
							 if($.isFunction(callback)){

								 if(_getMobileAgent()["mobile"]) {
									 var getClientVersionNative = new cherry.NativeOperation("application", "getClientVersion", []).dispatch();			

									 var cherryScript = new cherry.ScriptOperation(function(){
										 var clientVersion="";
										 clientVersion=getClientVersionNative.returnValue;	

										 callback.apply(this,[clientVersion]);

									 });

									 cherryScript.addDependency(getClientVersionNative);		
									 cherryScript.dispatch();
									 cherry.flushOperations();
									 return
								 }
								 if (opts.browerDebug) {
									 callback.apply(this,["0.0"]);
								 }

							 }else{
								 alert("请传入正确的回调函数");
							 }
						 },
		/*
		 * getServerUrl 得到当前请求url
		 */
		getServerUrl:function(){
						 return	document.location.protocol + "//"+ document.location.host;
					 },
		/*
		 * jumpToLogin @description:跳转首页登陆页 @param:objcet
		 * {"redirecUrl":"登录成功后跳转url",redirectXmlUrl:"跳转容器xml"}
		 */
		jumpToLogin:function(para){
				var homeUrl=$.hori.getconfig().serverBaseUrl+"viewhome/html/login.html?data-application="+$.hori.getconfig().appKey;;
				// 本地存储redirectUrl
				var redirectUrl=para.redirecUrl;
				if(typeof(para.redirectXmlUrl)!="undefined"){
					localStorage.setItem("loginRedirectXmlUrl", para.redirectXmlUrl);
				}
				
				localStorage.setItem("loginRedirectUrl", redirectUrl);
				
				
				$.hori.loadPage(homeUrl);		
				

					 },
		getCookies:function(callback){ // 获取客户端外壳存储的Cookies信息
			if($.isFunction(callback)){
				var getCookiesNative = new cherry.NativeOperation("application", "getCookies", []).dispatch();			

				var cherryScript = new cherry.ScriptOperation(function(){
					var cookies="";
					cookies=getCookiesNative.returnValue.replace(/\\u003d/gi,'=');// 替换转义空格为原始内容
					callback.apply(this,[cookies]);
				});

				cherryScript.addDependency(getCookiesNative);		
				cherryScript.dispatch();
				cherry.flushOperations();

			}else{
				alert("请传入正确的回调函数");
			}
		},
		runApp:function(packageName,className,callback){ // 清除客户端外壳存储的Cookies信息
			if($.isFunction(callback)){
				var runAppNative = new cherry.NativeOperation("application", "runApp", [packageName,className]).dispatch();			

				var cherryScript = new cherry.ScriptOperation(function(){
					var returnValue="";
					returnValue=runAppNative.returnValue;		
					callback.apply(this,[returnValue]);
				});

				cherryScript.addDependency(runAppNative);		
				cherryScript.dispatch();
				cherry.flushOperations();

			}else{
				alert("请传入正确的回调函数");
			}
		},
		clearCookies:function(callback){ // 清除客户端外壳存储的Cookies信息
			if($.isFunction(callback)){
				var clearCookiesNative = new cherry.NativeOperation("application", "clearCookies", []).dispatch();			

				var cherryScript = new cherry.ScriptOperation(function(){
					var returnValue="";
					returnValue=clearCookiesNative.returnValue;		
					callback.apply(this,[returnValue]);
				});

				cherryScript.addDependency(clearCookiesNative);		
				cherryScript.dispatch();
				cherry.flushOperations();

			}else{
				alert("请传入正确的回调函数");
			}
		},
		ajax:function(args){
				if(typeof(args["type"])=="undefined"){
					args.type="get";
				}
				if(typeof(args["data"])=="undefined"){
					args.data="";
				}
				if(typeof(args["url"])=="undefined"){
					alert("参数URL是必须参数请输入");
					return ;
				}
				if(typeof(args["success"])=="undefined" || !($.isFunction(args["success"]))){
					alert("参数success是必须参数，只能是函数");
					return ;
				}
				if(typeof(args["error"])=="undefined" || !($.isFunction(args["error"]))){
					alert("参数error 是必须参数,只能是函数");
					return ;
				}
				var type=args.type;
				var url=args.url;
				var data=args.data;
				var success=args.success;
				var error=args.error;
				var headers = args.headers;
				var addHeaders = false;
				if(headers == undefined){ // 是否添加headers
					addHeaders = false;
				}else{
					addHeaders = true;
				}
				var url = args.url;
				//转换url中多余 /,以兼容ios路径中/多个无法解析问题
				url = url.substring(0,url.indexOf("://")+ 3) + url.substring(url.indexOf("://")+ 3).replace(/\/{2,}/g,"/");
				// 补全请求地址，默认添加appKey参数
				if(url.indexOf("?") != -1){
					url = url + "&data-application=" + $.hori.getconfig().appKey;
				}else{
					url = url + "?data-application=" + $.hori.getconfig().appKey;
				}
				if(opts.browerDebug){
					if(addHeaders){ // 添加headers
						$.ajax({
							url:url,
							data:args.data,
							type:args.type,
							headers: headers,
							success:function(returnData){
								success.apply(this,[returnData]);
							},
							error:function(returnData){
								error.apply(this,[returnData]);
							},
							cache:false
						});
					}else{
						$.ajax({
							url:url,
							data:args.data,
							type:args.type,
							success:function(returnData){
								success.apply(this,[returnData]);
							},
							error:function(returnData){
								error.apply(this,[returnData]);
							},
							cache:false
						});
					}
				}else{
					if($.isFunction(success)){
		
						
						var requestDataOpration = new cherry.NativeOperation("application", "invokeAjax", [type,url,data]).dispatch();			
		
						var cherryScript = new cherry.ScriptOperation(function(){
							var returnData="";
							returnData=requestDataOpration.returnValue;	
							// {"success":true,"data":"","msg":""}
							var returnJson=$.parseJSON(returnData);
							if(returnJson.success){
								success.apply(this,[returnJson.data]);
							}else{
								error.apply(this,[returnJson.msg]);	
							}
							
		
						});
		
						cherryScript.addDependency(requestDataOpration);		
						cherryScript.dispatch();
						cherry.flushOperations();
		
					}
				}
				
		
			}
	};
	// rend hori
	//增加删除本地localstorage的方法，配合客户端远程擦除
	cherry.WipeData = function(){
		var sucessFlag=1;
		try{
			localStorage.clear();
			return sucessFlag;
		}catch(e){
			sucessFlag=0;
			return sucessFlag;
		}

	}



	var hori=$.extend({},horiPub,opts);
	jQuery.extend({hori:hori});
	

})(jQuery)
