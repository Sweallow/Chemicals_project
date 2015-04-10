package com.sc.arbitrationApply.dao;

import com.sc.common.dao.BaseDao;
import com.sc.arbitrationApply.model.ArbirtationApply;

public class ArbitrationApplyDao extends BaseDao<ArbirtationApply> {

	@Override
	protected Class<?> getModelClass() {
		return ArbirtationApply.class;
	}

	@Override
	public String getTableName() {
		return "C_ARBITRATION_APPLY";
	}

}
