package com.sc.chemical.dao;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;

import com.sc.chemical.model.ApplicationEnterpriseInfo;
import com.sc.common.dao.BaseDao;

public class ApplicationEnterpriseInfoDao extends BaseDao<ApplicationEnterpriseInfo>{

	@Override
	protected Class<?> getModelClass() {
		return ApplicationEnterpriseInfo.class;
	}

	@Override
	public String getTableName() {
		return "C_APPLICATIONENTERPRISEINFO";
	}
	
	/**
	 * 删除主表附表
	 * @param ids 
	 * @return int
	 */
	public int dataDel(String ids) {
		//删除主表信息sql
		String sql = "DELETE FROM " + this.getTableName() 
			+ " WHERE SCID IN ('" + ids.replace(",", "','") + "')";
		//删除附表信息sql
		String sql2="DELETE FROM C_APPRAISALINFO WHERE GLID IN (" +
				"SELECT SCID FROM C_APPLICATIONENTERPRISEINFO  " +
				"WHERE SCID IN ('" + ids.replace(",", "','") + "'))";
		Connection conn = null;  
        QueryRunner queryRunner = new QueryRunner(true);
		try {
			//获取连接
			conn = this.getDataSource().getConnection();
			ApplicationEnterpriseInfoDao a=new ApplicationEnterpriseInfoDao();
			a.executeNoQuery(sql2);
			return queryRunner.update(conn, sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
		    try {
				DbUtils.close(conn);
			} catch (SQLException e) {
				e.printStackTrace();
			}  
		}
		return 1;
	}
}
