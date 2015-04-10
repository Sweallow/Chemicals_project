package com.sc.common.service;

import com.google.gson.Gson;
import com.sc.common.dao.BaseDao;
import com.sc.common.model.FormData;
import com.sc.common.util.StrUtil;


/**
 * 基础service
 * @author Durton
 *
 * @date 2014-10-22 下午10:18:18
 */
public abstract class BaseService<T> {
	
	public abstract BaseDao<T> getDao();
	
	/**
	 * 得到列表数据
	 * @param startIndex
	 * @param pageSize
	 * @param filter
	 * @param order
	 * @return
	 */
	public String getTableData(String startIndex, String pageSize, String filter, String order) {
		
		return getDao().getPageData(StrUtil.toInt(startIndex), StrUtil.toInt(pageSize), filter, order);
	}
	/**
	 * 加载表单数据
	 * @param formDataStr
	 * @return
	 */
	public String loadFormData(String formDataStr) {
		Gson g = new Gson();
		FormData fd = g.fromJson(formDataStr, FormData.class);
		FormData fd1 = getDao().dataQuery(fd);
		return StrUtil.toJson(fd1);
	}
	/**
	 * 保存表单数据
	 * @param fd
	 * @return
	 */
	public String saveFormData(String formDataStr) {
		Gson g = new Gson();
		FormData fd = g.fromJson(formDataStr, FormData.class);
		getDao().dataSave(fd);
		return "";
	}
	/**
	 * 删除表单数据
	 * @param ids
	 * @return
	 */
	public String deleteFormData(String ids) {
		getDao().dataDelete(ids);
		return "";
	}
	/**
	 * 上移下移
	 * @param scid
	 * @param filter
	 * @param flag
	 * @return
	 */
	public String updateShowOrder(String scid, String filter, String upOrDown, String order) {
		getDao().updateShowOrder(scid, filter, upOrDown, order);
		return "";
	}
	
}
