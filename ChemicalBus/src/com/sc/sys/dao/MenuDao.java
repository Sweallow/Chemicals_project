package com.sc.sys.dao;

import com.sc.common.dao.BaseDao;
import com.sc.sys.model.Menu;
/**
 * ²Ëµ¥Dao
 * @author Durton
 *
 * @date 2014-12-8 ÏÂÎç2:20:58
 */
public class MenuDao extends BaseDao<Menu> {

	@Override
	protected Class<?> getModelClass() {
		return Menu.class;
	}

	@Override
	protected String getTableName() {
		return "SC_MENU";
	}

}
