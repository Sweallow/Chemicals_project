package com.sc.report.dao;

import com.sc.common.dao.BaseDao;
import com.sc.report.model.C_information;

public class InformationDao extends BaseDao<C_information> {
	
	@Override
	protected Class<?> getModelClass() {
		return C_information.class;
	}

	@Override
	public String getTableName() {
		return "C_INFORMATION";
	}
	
	/*
	 * public int dataDel(String ids) {
		//删除主表信息sql
		String sql = "DELETE FROM " + this.getTableName() 
			+ " WHERE SCID IN ('" + ids.replace(",", "','") + "')";
		//删除附表信息sql
		String sql2="DELETE FROM C_EXAMINE WHERE ID IN (" +
				"SELECT SCID FROM C_INFORMATION  " +
				"WHERE SCID IN ('" + ids.replace(",", "','") + "'))";
		Connection conn = null;
        QueryRunner queryRunner = new QueryRunner(true);
		try {
			//获取连接
			conn = this.getDataSource().getConnection();
			InformationDao a=new InformationDao();
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
	}*/
	

}
