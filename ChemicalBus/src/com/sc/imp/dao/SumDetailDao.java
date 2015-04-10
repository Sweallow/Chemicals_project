package com.sc.imp.dao;

import com.sc.common.dao.BaseDao;
import com.sc.imp.model.SumDetail;

public class SumDetailDao extends BaseDao<SumDetail>{

	@Override
	protected Class<?> getModelClass() {
		return SumDetail.class;
	}
	@Override
	protected String getTableName() {
		return "C_SUM_DETAIL";
	}
}