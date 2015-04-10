package com.sc.arbitrationApply.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sc.arbitrationApply.dao.ArbitrationApplyDao;
import com.sc.arbitrationApply.model.ArbirtationApply;
import com.sc.common.dao.BaseDao;
import com.sc.common.service.BaseService;
import com.sc.common.util.StrUtil;

public class ArbirtationApplyService extends BaseService<ArbirtationApply>{
	private ArbitrationApplyDao arbitrationApplyDao = new ArbitrationApplyDao();
	private String CName = arbitrationApplyDao.getTableName();
	
	@Override
	public BaseDao<ArbirtationApply> getDao() {
		return arbitrationApplyDao;
	}
	
	//审核状态修改
	public String updateScstatus(String scstatus, String scid){
		int rs = arbitrationApplyDao.executeNoQuery("update "+CName+" set scstatus = '"+scstatus+"' where scid = '"+scid+"'");
		if(rs>0){
			return "success";
		}else{
			return "false";
		}
	}
	
	//驳回原因填写
	public String updateReason(String reason, String scid){
		int rs = arbitrationApplyDao.executeNoQuery("update "+CName+" set theReason = '"+reason+"' where scid = '"+scid+"'");
		if(rs>0){
			return "success";
		}else{
			return "false";
		}
	}
	
	//统计分析
	public String selTotal(String str){
		List<int[]> dataList = new ArrayList<int[]>();
		List<Map<String,Object>> listYear = arbitrationApplyDao.executQuery("SELECT SUBSTRING (scCreatedate, 0, 5) AS YEAR FROM "+CName+" WHERE scStatus='1' GROUP BY SUBSTRING (scCreatedate, 0, 5)");
		int[] yearCol = new int[listYear.size()];
		for(int i=0; i<listYear.size(); i++){
			yearCol[i] = Integer.valueOf(listYear.get(i).get("YEAR").toString());
		}
		List<Map<String,Object>> listCount = arbitrationApplyDao.executQuery("SELECT COUNT (*) AS COUNT, SUBSTRING ( scCreatedate, 0, 5 ) AS YEAR, SUBSTRING ( scCreatedate, 6, 2 ) AS MONTH FROM "+CName+ " WHERE scStatus='1' GROUP BY SUBSTRING ( scCreatedate, 0, 5 ), SUBSTRING ( scCreatedate, 6, 2 )");
		for(int n=0; n<listYear.size(); n++){
			int[] data = new int[13];
			data[0] = yearCol[n];
			for(int i=0;i<listCount.size();i++){
				int year = Integer.valueOf(listCount.get(i).get("YEAR").toString());
				int month = Integer.valueOf(listCount.get(i).get("MONTH").toString().split("-")[0]);
				int count = Integer.valueOf(listCount.get(i).get("COUNT").toString());
				if(year == yearCol[n]){
					data[month] = count;
				}
			}
			dataList.add(data);
		}
		return StrUtil.toJson(dataList);
	}
	
	//判断申请对象是否已填写通知书，若已填写则返回对应通知书的scid
	public String isNotice(String appScid){
		List<Map<String,Object>> list = arbitrationApplyDao.executQuery("SELECT scid AS SCID FROM c_resultNotice WHERE appScid = '"+appScid+"'");
		String scid = "";
		if(list.size()>0){
			scid = list.get(0).get("SCID").toString();
		}
		return scid;
	}
}
