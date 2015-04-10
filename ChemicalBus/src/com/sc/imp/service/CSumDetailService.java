package com.sc.imp.service;

import com.sc.common.dao.BaseDao;
import com.sc.common.service.BaseService;
import com.sc.imp.dao.SumDetailDao;
import com.sc.imp.model.SumDetail;

public class CSumDetailService extends BaseService<SumDetail>{
	private static SumDetailDao sdd=new SumDetailDao();
	
	public BaseDao<SumDetail> getDao() {
		return sdd;
	}
}