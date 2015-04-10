/**
 * ��ʾ��
 * @param str
 * @return
 */
sc.alert = function(str) {
	setTimeout(function() {
		var d = dialog({
		    content: str,
		    okValue: "ȷ��",
		    ok: function() {}
		});
		d.showModal();
	}, 100);
}
/**
 * �õ�URL����
 * @param name ������
 * @return
 */
sc.getUrlQuery = function(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	var r = window.location.search.substr(1).match(reg);
	if (r != null) return unescape(r[2]); return null;
}

/**
 * �ղر���
 * @param e
 * @return
 */
sc.collectPage = function() {
    var 
        title = document.title || '���ʦ��ַ����',
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
        alert('�����������֧���Զ��ղأ���ʹ��Ctrl+D�����ղ�');
    }

    e.preventDefault();
}

/**
 * ��Ϊ��ҳ
 * @return
 */
sc.setFrontPage = function() {
    try {
        if(window.netscape) {
            netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
            
            Components.classes['@mozilla.org/preferences-service;1']
            .getService(Components. interfaces.nsIPrefBranch)
            .setCharPref('browser.startup.homepage',window.location.href); 
            
            alert('�ɹ���Ϊ��ҳ');
            
        }else if(window.external) {
            document.body.style.behavior='url(#default#homepage)';   
            document.body.setHomePage(location.href);
        }else {
            throw 'NOT_SUPPORTED';
        }
    }catch(err) {
        alert('�����������֧�ֻ������Զ�������ҳ, ��ͨ��������˵�����');
    }

    e.preventDefault();
}

//�س��¼�
sc.enterClick = function(fun) {
	if (event.keyCode == 13) {
		fun();
	}
}

//---------------------------------------------------  
//���ڸ�ʽ��  
//��ʽ YYYY/yyyy/YY/yy ��ʾ���  
//MM/M �·�  
//W/w ����  
//dd/DD/d/D ����  
//hh/HH/h/H ʱ��  
//mm/m ����  
//ss/SS/s/S ��  
//---------------------------------------------------  
sc.dateFormat = function(formatStr, date) {
	if(!date) {
		date = new Date();
	}
	var str = formatStr;
	var Week = [ '��', 'һ', '��', '��', '��', '��', '��' ];

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