package com.sc.sys.service;

import com.sc.common.dao.BaseDao;
import com.sc.common.service.BaseService;
import com.sc.sys.dao.ParamTypeDao;
import com.sc.sys.model.ParamType;

public class ParamTypeService extends BaseService<ParamType> {
	private ParamTypeDao dataDao =new ParamTypeDao();
	@Override
	public BaseDao<ParamType> getDao() {
		return dataDao;
	}

}
