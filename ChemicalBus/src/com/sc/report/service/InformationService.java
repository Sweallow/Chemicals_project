package com.sc.report.service;

import java.util.ArrayList;
import java.util.List;

import com.sc.common.dao.BaseDao;
import com.sc.common.service.BaseService;
import com.sc.report.dao.InformationDao;
import com.sc.report.model.C_information;

public class InformationService extends BaseService<C_information> {
	private InformationDao dataDao = new InformationDao();

	@Override
	public BaseDao<C_information> getDao() {
		return dataDao;
	}
	
	/**
	 * 删除通知书
	 * @param ids
	 * @return
	 */
	public int delFormData(String ids) {
		List<String> sqls = new ArrayList<String>();
//		String sql = "DELETE FROM " + this.getTableName() 
//				+ " WHERE SCID IN ('" + ids.replace(",", "','") + "')";
		//删除通知书主表信息sql
		String sql = "DELETE FROM C_INFORMATION WHERE SCID IN ('" + ids.replace(",", "','") + "')";
		//删除通知书附表信息sql
		String sql2="DELETE FROM C_EXAMINE WHERE ID IN (" +
				"SELECT SCID FROM C_INFORMATION  " +
				"WHERE SCID IN ('" + ids.replace(",", "','") + "'))";
		sqls.add(sql2);
		sqls.add(sql);
		dataDao.executeNoQuery(sqls);
		return 1;
	}

	//删
	/*public String delFormData(String ids) {
		//getDao().dataDelete(ids);
		dataDao.dataDel(ids);
		return "";
	}*/

}
