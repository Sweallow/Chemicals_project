package com.sc.role.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.sc.common.dao.BaseDao;
import com.sc.common.util.StrUtil;
import com.sc.role.model.Role;

public class RoleDao extends BaseDao<Role>{
	private static RoleDao  dao;
	@Override
	protected Class<?> getModelClass() {
		return Role.class;
	}

	@Override
	protected String getTableName() {
		return "SC_ROLE";
	}
	
	/**
	 * 得到角色对应菜单
	 * @return
	 */
	public List<Map<String, Object>> getRoleMenus(String roleid) {
		String sql = "SELECT MENUID FROM SC_ROLE_MENU WHERE ROLEID = '" + roleid + "'";
		List<Map<String, Object>> list = this.executQuery(sql);
		return list;
	}
	/**
	 * 保存角色菜单
	 * @param menus
	 * @param roleid
	 */
	public void saveRoleMenu(String[] menus, String roleid) {
		List<String> sqls = new ArrayList<String>();
		String delSql = "DELETE FROM SC_ROLE_MENU WHERE ROLEID = '" + roleid + "'";
		sqls.add(delSql);
		
		String curDate = StrUtil.dateFormat(new Date());//当前时间
		for(int i = 0; i < menus.length; i++) {
			String insertSql = "INSERT INTO SC_ROLE_MENU (ROLEID, MENUID, SCCREATEDATE) " +
					"VALUES ('" + roleid + "', '" + menus[i] + "', '" + curDate + "')";
			sqls.add(insertSql);
		}
		this.executeNoQuery(sqls);
	}
}