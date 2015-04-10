package com.sc.sys.service;

import java.util.ArrayList;
import java.util.List;

import com.sc.common.dao.BaseDao;
import com.sc.common.service.BaseService;
import com.sc.common.util.StrUtil;
import com.sc.sys.dao.OrganiseDao;
import com.sc.sys.model.Organise;
import com.sc.sys.model.Tree;
public class OrganiseService extends BaseService<Organise> {
	private OrganiseDao dataDao = new OrganiseDao();
	@Override
	public BaseDao<Organise> getDao() {
		return dataDao;
	}
	/**
	 * 得到所有菜单,菜单树用
	 * @param userid
	 * @return
	 */
	public String getAllOrganse4Tree(String userid) {
		List<Organise> list = getDao().getDatas(0, Integer.MAX_VALUE, "", "ORDER BY SCSHOWORDER");
		List<Tree> treeList = new ArrayList<Tree>();
		
		for(Organise o : list) {
			Tree t = new Tree();
			t.setId(o.getScid());
			t.setpId(o.getPorgid());
			t.setName(o.getOrgname());
			
			treeList.add(t);
		}
		return StrUtil.toJson(treeList);
	}
}
