package com.sc.role.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sc.common.dao.BaseDao;
import com.sc.common.service.BaseService;
import com.sc.common.util.StrUtil;
import com.sc.role.dao.RoleDao;
import com.sc.role.model.Role;
import com.sc.sys.model.Organise;
import com.sc.sys.model.Tree;

public class RoleService extends BaseService<Role> {
	private RoleDao roledao = new RoleDao();

	@Override
	public BaseDao<Role> getDao() {
		return roledao;
	}

	/**
	 * 得到所有菜单,菜单树用
	 * 
	 * @param userid
	 * @return
	 */
	public String getAllRole4Tree(String userid) {
		List<Role> list = roledao.getDatas(0, Integer.MAX_VALUE, "",
				"ORDER BY SCSHOWORDER");
		List<Tree> treeList = new ArrayList<Tree>();

		for (Role o : list) {
			Tree t = new Tree();
			t.setId(o.getscid());
			t.setpId("");
			t.setName(o.getRoleName());

			treeList.add(t);
		}
		return StrUtil.toJson(treeList);
	}
	/**
	 * 得到角色对应菜单
	 * @param roleid
	 * @return
	 */
	public String getRoleMenus(String roleid) {
		List<Map<String, Object>> list = roledao.getRoleMenus(roleid);
		List<String> list1 = new ArrayList<String>();
		for(Map<String, Object> map : list) {
			list1.add(map.get("MENUID").toString());
		}
		return StrUtil.toJson(list1);
	}
	/**
	 * 保存角色菜单
	 * @param roleid
	 * @param menuids
	 * @return
	 */
	public String saveRoleMenu(String roleid, String menuids) {
		String[] menus = menuids.substring(1).split(",");
		roledao.saveRoleMenu(menus, roleid);
		return null;
	}
}