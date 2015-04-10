package com.sc.common.service;

import com.google.gson.Gson;
import com.sc.common.dao.BaseDao;
import com.sc.common.model.FormData;
import com.sc.common.util.StrUtil;


/**
 * ����service
 * @author Durton
 *
 * @date 2014-10-22 ����10:18:18
 */
public abstract class BaseService<T> {
	
	public abstract BaseDao<T> getDao();
	
	/**
	 * �õ��б�����
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
	 * ���ر�����
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
	 * ���������
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
	 * ɾ��������
	 * @param ids
	 * @return
	 */
	public String deleteFormData(String ids) {
		getDao().dataDelete(ids);
		return "";
	}
	/**
	 * ��������
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
