/**
 * 提示框
 * @param str
 * @return
 */
sc.alert = function(str) {
	setTimeout(function() {
		var d = dialog({
		    content: str,
		    okValue: "确定",
		    ok: function() {}
		});
		d.showModal();
	}, 100);
}
/**
 * 得到URL参数
 * @param name 参数名
 * @return
 */
sc.getUrlQuery = function(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	var r = window.location.search.substr(1).match(reg);
	if (r != null) return unescape(r[2]); return null;
}

/**
 * 收藏本项
 * @param e
 * @return
 */
sc.collectPage = function() {
    var 
        title = document.title || '设计师网址导航',
        url = window.location.href;
    
    try {
        if(window.sidebar && window.sidebar.addPanel) {
            window.sidebar.addPanel(title, url, '');
        }else if(window.external) {
            window.external.AddFavorite(url, title);
        }else {
            throw 'NOT_SUPPORTED';
        }
    }catch(err) {
        alert('您的浏览器不支持自动收藏，请使用Ctrl+D进行收藏');
    }

    e.preventDefault();
}

/**
 * 设为首页
 * @return
 */
sc.setFrontPage = function() {
    try {
        if(window.netscape) {
            netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
            
            Components.classes['@mozilla.org/preferences-service;1']
            .getService(Components. interfaces.nsIPrefBranch)
            .setCharPref('browser.startup.homepage',window.location.href); 
            
            alert('成功设为首页');
            
        }else if(window.external) {
            document.body.style.behavior='url(#default#homepage)';   
            document.body.setHomePage(location.href);
        }else {
            throw 'NOT_SUPPORTED';
        }
    }catch(err) {
        alert('您的浏览器不支持或不允许自动设置首页, 请通过浏览器菜单设置');
    }

    e.preventDefault();
}

//回车事件
sc.enterClick = function(fun) {
	if (event.keyCode == 13) {
		fun();
	}
}

//---------------------------------------------------  
//日期格式化  
//格式 YYYY/yyyy/YY/yy 表示年份  
//MM/M 月份  
//W/w 星期  
//dd/DD/d/D 日期  
//hh/HH/h/H 时间  
//mm/m 分钟  
//ss/SS/s/S 秒  
//---------------------------------------------------  
sc.dateFormat = function(formatStr, date) {
	if(!date) {
		date = new Date();
	}
	var str = formatStr;
	var Week = [ '日', '一', '二', '三', '四', '五', '六' ];

	str = str.replace(/yyyy|YYYY/, date.getFullYear());
	str = str.replace(/yy|YY/,
			(date.getYear() % 100) > 9 ? (date.getYear() % 100).toString()
					: '0' + (date.getYear() % 100));
	var month = date.getMonth() + 1;
	str = str.replace(/MM/, month > 9 ? month.toString()
			: '0' + month);
	str = str.replace(/M/g, date.getMonth());

	str = str.replace(/w|W/g, Week[date.getDay()]);

	str = str.replace(/dd|DD/, date.getDate() > 9 ? date.getDate().toString()
			: '0' + date.getDate());
	str = str.replace(/d|D/g, date.getDate());

	str = str.replace(/hh|HH/, date.getHours() > 9 ? date.getHours().toString()
			: '0' + date.getHours());
	str = str.replace(/h|H/g, date.getHours());
	str = str.replace(/mm/, date.getMinutes() > 9 ? date.getMinutes()
			.toString() : '0' + date.getMinutes());
	str = str.replace(/m/g, date.getMinutes());

	str = str.replace(/ss|SS/, date.getSeconds() > 9 ? date.getSeconds()
			.toString() : '0' + date.getSeconds());
	str = str.replace(/s|S/g, date.getSeconds());

	return str;
}   