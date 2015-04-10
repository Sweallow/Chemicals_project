/**
 * 异步Ajax
 * @return
 */
var ServiceBreak = function(className, method, arg, callback) {
	var params = scGetParams(className, method, arg);
	$.ajax({
		type: "POST",
		url: sc.basePath + "/servlet/ServiceBreak",
		data: params,
		async: true,
		success: function(data){
			var obj = null;
			try {
				obj = JSON.parse(data);
			} catch (e) {
				obj = data;
			}
			if(callback != null) {
				callback(obj);
			}
		}
	});
}
/**
 * 同步Ajax
 * @return
 */
var ServiceBreakSyn = function(className, method, arg) {
	var res = null;
	var params = scGetParams(className, method, arg);
	$.ajax({
		type: "POST",
		url: sc.basePath + "/servlet/ServiceBreak",
		data: params,
		async: false,
		success: function(data) {
			try {
				res = JSON.parse(data);
			} catch (e) {
				res = data;
			}
		}
	});
	return res;
}
/**
 * 得到调用所需参数
 * @param className 类名
 * @param method 方法名
 * @param arg 参数
 * @return
 */
var scGetParams = function(className, method, arg) {
	var params = "_c="+className+"&_m="+method;
	if(arg!=null) {
		var p;
		for(var i=0; i<arg.length; i++) {
			params +="&_p"+i+"=";
			if(typeof(arg[i])!="undefined") {
				if(typeof(arg[i]) != "string") {
					p = JSON.stringify(arg[i]);
				} else {
					p = arg[i];
				}
				p = p.replace(/\%/g,"%25");
				p = p.replace(/\&/g,"%26");
				p = p.replace(/\#/g,"%23");
				p = p.replace(/\+/g,"%2B");
				params += p;
			}
		}
	}
	return params;
}