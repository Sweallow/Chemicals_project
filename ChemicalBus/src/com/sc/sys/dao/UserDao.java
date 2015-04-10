package com.sc.sys.dao;

import com.sc.common.dao.BaseDao;
import com.sc.sys.model.User;

public class UserDao extends BaseDao<User> {

	@Override
	protected Class<?> getModelClass() {
		return User.class;
	}

	@Override
	protected String getTableName() {
		return "SC_USER";
	}
	/**
	 * –ﬁ∏ƒ√‹¬Î
	 * @param md5
	 * @param scid
	 */
	public void updatePwd(String md5, String scid) {
		String sql = "update sc_user set password = '" + md5 + "' where scid = '" + scid + "'";
		this.executeNoQuery(sql);
	}
	/**
	 * √‹¬Î÷ÿ÷√
	 * @param ids
	 */
	public void pwdReset(String ids) {
		String sql = "update sc_user set password = 'c4ca4238a0b923820dcc509a6f75849b' " +
				"where scid in ('" + ids.replace(",", "','") + "')";
		this.executeNoQuery(sql);
	}
}
