sc.form = {};
/**
 * 表单-新增
 */
sc.form.add = function(saveFun) {
	//表单清空
	sc.form.dlgReset();
	//打开对话框
	sc.form.dlgShow(saveFun);
}
/**
 * 表单-修改
 */
sc.form.edit = function(saveFun) {
	var row = $('#dg').datagrid('getSelections');
	if(row.length == 0) {
		sc.alert("请选择要修改的数据。");
		return;
	} else if(row.length > 1) {
		sc.alert("一次只能修改一条数据。");
		return;
	} else {
		sc.form.dlgReset();//清空表单数据
		scDlg.find("#scid").val(row[0].scid);//设置数据主键
		sc.form.dlgDataLoad();//加载表单数据
		sc.form.dlgShow(saveFun);//显示对话框
	}
}
/**
 * 表单-删除
 */
sc.form.del = function(afterDel) {
	var row = $('#dg').datagrid('getSelections');
	if(row.length == 0) {
		sc.alert("请选择要删除的数据。");
		return;
	}
	if(row) {
		var d = dialog({
			lock:true,
		    title: '提示',
		    content: '确认删除选中数据？',
		    okValue: "确定",
		    ok: function() {
				var ids = "";
				for(var i = 0; i < row.length; i++) {
					ids += "," + row[i].scid
				}
				ServiceBreakSyn(scClassName, "deleteFormData", [ids.substring(1)]);
				sc.form.dgDataLoad();//加载列表数据
				if(afterDel) {
					afterDel();
				}
		    },
		    cancelValue: "取消",
			cancel: function () {} 
		});
		d.showModal();
	}
}
/**
 * 详细表单-保存
 */
sc.form.dlgSave = function(beforeSaveFun, afterSaveFun) {
	//表单保存前事件
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
	sc.form.dgDataLoad();//加载列表数据
	//保存后事件
	if(afterSaveFun) {
		var res = afterSaveFun();
		if(res == false) {
			return res;
		}
	}
}
/**
 * 详细表单-数据加载
 */
sc.form.dlgDataLoad = function() {
	//得到ID
	var scid = scDlg.find("#scid").val();
	if(scid == null) {
		scAlert("主键字段空！");
		return;
	}
	//得到并封装数据字段
	var columnArr = new Array(scDlg.find(".scSave").length);
	for(var i = 0; i < scDlg.find(".scSave").length; i++) {
		var columnName = scDlg.find(".scSave").eq(i).attr("id");
		var columnValue = scDlg.find(".scSave").eq(i).val();
		
		var column = {columnName: columnName, columnValue: columnValue};
		columnArr[i] = column;
	}
	var tableObj = {scid: scid, columns: columnArr};
	//读取表单数据，并为表单赋值
	ServiceBreak(scClassName, "loadFormData", [JSON.stringify(tableObj)], function(data) {
		for(var j = 0; j < data.columns.length; j++) {
			var column = data.columns[j];
			scDlg.find("#" + column.columnName).val(column.columnValue);
		}
	});
}
/**
 * 详细表单-清空
 */
sc.form.dlgReset = function() {
	scDlg.find(".scSave").val("");
	scDlg.find("#scid").val("");
}
/**
 * 详细表单-对话框打开
 */
sc.form.dlgShow = function(saveFun) {
	scDlg.show();
	var d = dialog({
		lock:true,
	    title: '新增' + formName,
	    content: scDlg,
	    okValue: "确定",
	    ok: function() {
			var a = saveFun();
			return a;
	    },
	    cancelValue: "取消",
		cancel: function () {} 
	});
	d.showModal();
}



/**
 * 分页元件初始化
 */
sc.form.dgPagerInit = function() {
	// 得到分页元件
	var p = $("#dg").datagrid('getPager');
	// 设置初始属性
	$(p).pagination({
		total : 0,
		pageSize : pageSize,
		pageNumber : pageNumber,
		layout : [ 'sep', 'first', 'prev', 'sep', 'manual', 'sep',
				'next', 'last', 'sep' ],
		onSelectPage : function(pn, pageSize) {
			pageNumber = pn;// 页号改变
			sc.form.dgDataLoad();
		}
	});
}
/**
 * 列表数据加载
 */
sc.form.dgDataLoad = function() {
	var startIndex = (pageNumber - 1) * pageSize;
	if(!order) {
		order = '';
	}
	ServiceBreak(scClassName, "getTableData", [startIndex + "", pageSize + "", filter, order], 
			function(pager) {
		if(pager != null && pager != 'null') {
			$('#dg').datagrid('loadData', pager);//列表数据
		}
	});
}
/**
 * 打印数据准备
 */
sc.form.printData = function() {
	/*
	[
	["1","[cellId0]","科技成果名称"],
	["1","[cellId12]",""],
	["1","[cellId13]","备注"],
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
 * 上移
 * @returns
 */
sc.dlgDataUp = function() {
	var row = $('#dg').datagrid('getSelections');
	if(row.length == 0) {
		scAlert("请选择要上移的数据。");
		return;
	} else if(row.length > 1) {
		scAlert("一次只能上移一条数据。");
		return;
	} else {
		ServiceBreakSyn(scClassName, "updateShowOrder", 
				[ row[0].scid, filter, '1', order ]);
		sc.form.dgDataLoad();
	}
}
/**
 * 下移
 * @returns
 */
sc.dlgDataDown = function() {
	var row = $('#dg').datagrid('getSelections');
	if(row.length == 0) {
		scAlert("请选择要下移的数据。");
		return;
	} else if(row.length > 1) {
		scAlert("一次只能下移一条数据。");
		return;
	} else {
		ServiceBreakSyn(scClassName, "updateShowOrder", 
				[ row[0].scid, filter, '-1', order ]);
		sc.form.dgDataLoad();
	}
}