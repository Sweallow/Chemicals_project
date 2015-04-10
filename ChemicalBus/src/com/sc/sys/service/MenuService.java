package com.sc.sys.service;

import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.sc.common.dao.BaseDao;
import com.sc.common.service.BaseService;
import com.sc.common.util.Global;
import com.sc.common.util.StrUtil;
import com.sc.sys.dao.MenuDao;
import com.sc.sys.model.Menu;
import com.sc.sys.model.Tree;
import com.sc.sys.model.User;

/**
 * �˵�Service
 * @author Durton
 *
 * @date 2014-12-8 ����2:21:16
 */
public class MenuService extends BaseService<Menu> {
	private MenuDao dataDao = new MenuDao();
	
	@Override
	public BaseDao<Menu> getDao() {
		return dataDao;
	}
	/**
	 * �õ�һ���˵�
	 * @param curUser ��ǰ�û�
	 * @return
	 */
	public String getTopMenu(String curUser) {
		//��ǰ�û�
		Gson gson = new Gson();
		User u = gson.fromJson(curUser, User.class);
		
		String filter = " AND (PMENU IS NULL OR PMENU = '')";
		if(!("true".equals(Global.getProperty("debug")) 
				&& u.getUsercode().equals(Global.getProperty("superuser")))) {
			filter += " and scid in (select menuid from sc_role_menu where roleid = '" + u.getRoleid() + "')";
		}
		List<Menu> list = getDao().getDatas(0, Integer.MAX_VALUE, filter, " order by scShowOrder");
		return StrUtil.toJson(list);
	}
	/**
	 * �õ��Ӳ˵�
	 * @param pMenuid ���˵�ID
	 * @param curUser ��ǰ�û�
	 * @return
	 */
	public String getChildMenu(String pMenuid, String curUser) {
		//��ǰ�û�
		Gson gson = new Gson();
		User u = gson.fromJson(curUser, User.class);
		
		String filter = " AND PMENU = '" + pMenuid + "' ";
		if(!("true".equals(Global.getProperty("debug")) 
				&& u.getUsercode().equals(Global.getProperty("superuser")))) {
			filter += " and scid in (select menuid from sc_role_menu where roleid = '" + u.getRoleid() + "')";
		}
		List<Menu> list = getDao().getDatas(0, Integer.MAX_VALUE, filter, " order by scShowOrder");
		return StrUtil.toJson(list);
	}
	/**
	 * �õ����в˵�,�˵�����
	 * @param userid
	 * @return
	 */
	public String getAllMenus4Tree(String userid) {
		List<Menu> list = getDao().getDatas(0, Integer.MAX_VALUE, "", "order by scShowOrder");
		List<Tree> treeList = new ArrayList<Tree>();
		
		for(Menu m : list) {
			Tree t = new Tree();
			t.setId(m.getScid());
			t.setpId(m.getpMenu());
			t.setName(m.getMenuName());
			
			treeList.add(t);
		}
		return StrUtil.toJson(treeList);
	}
}
