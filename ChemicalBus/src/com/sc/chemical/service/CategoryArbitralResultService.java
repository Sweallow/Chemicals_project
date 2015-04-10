package com.sc.chemical.service;

import com.sc.chemical.dao.CategoryArbitralResultDao;
import com.sc.chemical.model.CategoryArbitralResult;
import com.sc.common.dao.BaseDao;
import com.sc.common.service.BaseService;

public class CategoryArbitralResultService extends BaseService<CategoryArbitralResult>{
	private CategoryArbitralResultDao dataDao = new CategoryArbitralResultDao();
	@Override
	public BaseDao<CategoryArbitralResult> getDao() {
		return dataDao;
	}
	
}
