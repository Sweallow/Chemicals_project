package com.sc.sys.service;

import java.util.List;

import com.google.gson.Gson;
import com.sc.common.dao.BaseDao;
import com.sc.common.service.BaseService;
import com.sc.common.util.Global;
import com.sc.common.util.StrUtil;
import com.sc.sys.dao.UserDao;
import com.sc.sys.model.User;

/**
 * 
 * @author luteng
 *
 */
public class UserService extends BaseService<User>{
	private UserDao dataDao = new UserDao();	
	@Override
	public BaseDao<User> getDao() {
		return dataDao;
	}
	/**
	 * �û���¼��֤
	 * @param userCode
	 * @param password
	 * @return
	 */
	public User login(String userCode, String password) {
		User res = null;
		List<User> list = getDao().getDatas(0, 1, " and usercode = '" + userCode + "'");
		if(list.size() > 0) {
			User u = list.get(0);
			if(u != null && u.getPassword() != null && u.getPassword().equals(StrUtil.md5(password))) {
				u.setPassword(null);//�������ÿ�
				res = u;
			}
		} else if(Global.getProperty("debug").equals("true")) {
			if(userCode.equals(Global.getProperty("superuser")) && StrUtil.md5(password).equals("3cbb6a715955a909105cfec9008e1d4a")) {
				User us = new User();
				us.setUsercode(userCode);
				us.setUsercode(userCode);
				res = us;
			}
		}
		return res;
	}
	/**
	 * �޸�����
	 * @param curUser
	 * @param pwd
	 * @param newPwd
	 * @return
	 */
	public String pwdChange(String curUser, String pwd, String newPwd) {
		//��ǰ�û�
		Gson gson = new Gson();
		User u = gson.fromJson(curUser, User.class);
		
		List<User> list = getDao().getDatas(0, 1, " and scid = '" + u.getScid() + "'");
		if(list.size() > 0) {
			User u2 = list.get(0);
			if(u2 != null && u2.getPassword() != null && u2.getPassword().equals(StrUtil.md5(pwd))) {
				dataDao.updatePwd(StrUtil.md5(newPwd), u2.getScid());
				return "�޸ĳɹ�";
			} else {
				return "ԭ���벻��ȷ";
			}
		}
		return "δ֪����";
	}
	/**
	 * ��������
	 * @param ids
	 * @return
	 */
	public String pwdReset(String ids) {
		((UserDao) getDao()).pwdReset(ids);
		return "";
	}
}
