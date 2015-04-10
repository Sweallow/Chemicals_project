package com.sc.sys.service;

import com.sc.common.dao.BaseDao;
import com.sc.common.service.BaseService;
import com.sc.sys.dao.ParamDao;
import com.sc.sys.model.Param;
public class ParamService extends BaseService<Param> {
	private ParamDao dataDao = new ParamDao();

	@Override
	public BaseDao<Param> getDao() {
		return dataDao;
	}

}
