sc.form = {};
/**
 * ��-����
 */
sc.form.add = function(saveFun) {
	//�����
	sc.form.dlgReset();
	//�򿪶Ի���
	sc.form.dlgShow(saveFun);
}
/**
 * ��-�޸�
 */
sc.form.edit = function(saveFun) {
	var row = $('#dg').datagrid('getSelections');
	if(row.length == 0) {
		sc.alert("��ѡ��Ҫ�޸ĵ����ݡ�");
		return;
	} else if(row.length > 1) {
		sc.alert("һ��ֻ���޸�һ�����ݡ�");
		return;
	} else {
		sc.form.dlgReset();//��ձ�����
		scDlg.find("#scid").val(row[0].scid);//������������
		sc.form.dlgDataLoad();//���ر�����
		sc.form.dlgShow(saveFun);//��ʾ�Ի���
	}
}
/**
 * ��-ɾ��
 */
sc.form.del = function(afterDel) {
	var row = $('#dg').datagrid('getSelections');
	if(row.length == 0) {
		sc.alert("��ѡ��Ҫɾ�������ݡ�");
		return;
	}
	if(row) {
		var d = dialog({
			lock:true,
		    title: '��ʾ',
		    content: 'ȷ��ɾ��ѡ�����ݣ�',
		    okValue: "ȷ��",
		    ok: function() {
				var ids = "";
				for(var i = 0; i < row.length; i++) {
					ids += "," + row[i].scid
				}
				ServiceBreakSyn(scClassName, "deleteFormData", [ids.substring(1)]);
				sc.form.dgDataLoad();//�����б�����
				if(afterDel) {
					afterDel();
				}
		    },
		    cancelValue: "ȡ��",
			cancel: function () {} 
		});
		d.showModal();
	}
}
/**
 * ��ϸ��-����
 */
sc.form.dlgSave = function(beforeSaveFun, afterSaveFun) {
	//������ǰ�¼�
	if(beforeSaveFun) {
		var res = beforeSaveFun();
		if(res == false) {
			return res;
		}
	}
	var scid = $("#scid").val();
	var columnArr = new Array($(".scSave").length);
	for(var i = 0; i < $(".scSave").length; i++) {
		var columnName = $(".scSave").eq(i).attr("id");
		var columnValue = $(".scSave").eq(i).val();
		var column = {columnName: columnName, columnValue: columnValue};
		columnArr[i] = column;
	}
	var tableObj = {scid: scid, columns: columnArr};
	ServiceBreakSyn(scClassName, "saveFormData", [JSON.stringify(tableObj)]);
	if(!scid) {
		pageNumber = 1;
	}
	sc.form.dgDataLoad();//�����б�����
	//������¼�
	if(afterSaveFun) {
		var res = afterSaveFun();
		if(res == false) {
			return res;
		}
	}
}
/**
 * ��ϸ��-���ݼ���
 */
sc.form.dlgDataLoad = function() {
	//�õ�ID
	var scid = scDlg.find("#scid").val();
	if(scid == null) {
		scAlert("�����ֶοգ�");
		return;
	}
	//�õ�����װ�����ֶ�
	var columnArr = new Array(scDlg.find(".scSave").length);
	for(var i = 0; i < scDlg.find(".scSave").length; i++) {
		var columnName = scDlg.find(".scSave").eq(i).attr("id");
		var columnValue = scDlg.find(".scSave").eq(i).val();
		
		var column = {columnName: columnName, columnValue: columnValue};
		columnArr[i] = column;
	}
	var tableObj = {scid: scid, columns: columnArr};
	//��ȡ�����ݣ���Ϊ����ֵ
	ServiceBreak(scClassName, "loadFormData", [JSON.stringify(tableObj)], function(data) {
		for(var j = 0; j < data.columns.length; j++) {
			var column = data.columns[j];
			scDlg.find("#" + column.columnName).val(column.columnValue);
		}
	});
}
/**
 * ��ϸ��-���
 */
sc.form.dlgReset = function() {
	scDlg.find(".scSave").val("");
	scDlg.find("#scid").val("");
}
/**
 * ��ϸ��-�Ի����
 */
sc.form.dlgShow = function(saveFun) {
	scDlg.show();
	var d = dialog({
		lock:true,
	    title: '����' + formName,
	    content: scDlg,
	    okValue: "ȷ��",
	    ok: function() {
			var a = saveFun();
			return a;
	    },
	    cancelValue: "ȡ��",
		cancel: function () {} 
	});
	d.showModal();
}



/**
 * ��ҳԪ����ʼ��
 */
sc.form.dgPagerInit = function() {
	// �õ���ҳԪ��
	var p = $("#dg").datagrid('getPager');
	// ���ó�ʼ����
	$(p).pagination({
		total : 0,
		pageSize : pageSize,
		pageNumber : pageNumber,
		layout : [ 'sep', 'first', 'prev', 'sep', 'manual', 'sep',
				'next', 'last', 'sep' ],
		onSelectPage : function(pn, pageSize) {
			pageNumber = pn;// ҳ�Ÿı�
			sc.form.dgDataLoad();
		}
	});
}
/**
 * �б����ݼ���
 */
sc.form.dgDataLoad = function() {
	var startIndex = (pageNumber - 1) * pageSize;
	if(!order) {
		order = '';
	}
	ServiceBreak(scClassName, "getTableData", [startIndex + "", pageSize + "", filter, order], 
			function(pager) {
		if(pager != null && pager != 'null') {
			$('#dg').datagrid('loadData', pager);//�б�����
		}
	});
}
/**
 * ��ӡ����׼��
 */
sc.form.printData = function() {
	/*
	[
	["1","[cellId0]","�Ƽ��ɹ�����"],
	["1","[cellId12]",""],
	["1","[cellId13]","��ע"],
	["1","[cellId14]",""]
	]
	*/
	var str = '[';
	for(var i = 0; i < $(".scSave").length; i++) {
		var columnName = $(".scSave").eq(i).attr("id");
		var columnValue = $(".scSave").eq(i).val();
		var column = "";
		if(i == 0) {
			column = '["1","[' + columnName + ']","' + columnValue + '"]';
		} else {
			column = ',["1","[' + columnName + ']","' + columnValue + '"]';
		}
		str += column;
	}
	str += "]";
	sc.alert(str);
}


/**
 * ����
 * @returns
 */
sc.dlgDataUp = function() {
	var row = $('#dg').datagrid('getSelections');
	if(row.length == 0) {
		scAlert("��ѡ��Ҫ���Ƶ����ݡ�");
		return;
	} else if(row.length > 1) {
		scAlert("һ��ֻ������һ�����ݡ�");
		return;
	} else {
		ServiceBreakSyn(scClassName, "updateShowOrder", 
				[ row[0].scid, filter, '1', order ]);
		sc.form.dgDataLoad();
	}
}
/**
 * ����
 * @returns
 */
sc.dlgDataDown = function() {
	var row = $('#dg').datagrid('getSelections');
	if(row.length == 0) {
		scAlert("��ѡ��Ҫ���Ƶ����ݡ�");
		return;
	} else if(row.length > 1) {
		scAlert("һ��ֻ������һ�����ݡ�");
		return;
	} else {
		ServiceBreakSyn(scClassName, "updateShowOrder", 
				[ row[0].scid, filter, '-1', order ]);
		sc.form.dgDataLoad();
	}
}