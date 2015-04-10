package com.sc.chemical.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sc.chemical.dao.ApplicationEnterpriseInfoDao;
import com.sc.chemical.model.ApplicationEnterpriseInfo;
import com.sc.common.dao.BaseDao;
import com.sc.common.service.BaseService;
import com.sc.common.util.StrUtil;

public class ApplicationEnterpriseInfoService extends BaseService<ApplicationEnterpriseInfo> {
	private ApplicationEnterpriseInfoDao dataDao = new ApplicationEnterpriseInfoDao();
	private String tableName = dataDao.getTableName();
	
	@Override
	public BaseDao<ApplicationEnterpriseInfo> getDao() {
		return dataDao;
	}
	
	/**
	 * @author: Chenmin
	 * @description:更新审核状态
	 * @@param scStatus
	 * @@param scid
	 * @@return String
	 */
	public String updateScstatus(String scStatus, String scid){
		int rs = dataDao.executeNoQuery("update " + tableName + " set scStatus = '" + scStatus + "' where scid = '" + scid + "'");
		if(rs>0){
			return "success";
		}else{
			return "false";
		}
	}
	
	/**
	 * @author: Chenmin
	 * @description: 更新驳回原由
	 * @@param reason
	 * @@param scid
	 * @@return String
	 */
	public String updateReason(String reason, String scid){
		int rs = dataDao.executeNoQuery("update " + tableName + " set theReason = '" + reason + "' where scid = '" + scid + "'");
		if(rs>0){
			return "success";
		}else{
			return "false";
		}
	}
	
	/**
	 * @author: Chenmin
	 * @description:统计信息
	 * @@param str
	 * @@return String
	 */
	public String selTotal(String str){
		List<int[]> dataList = new ArrayList<int[]>();
		List<Map<String,Object>> listYear = dataDao.executQuery("SELECT SUBSTRING (scCreatedate, 0, 5) AS YEAR FROM " + tableName + " GROUP BY substring (scCreatedate, 0, 5)");
		int[] yearCol = new int[listYear.size()];
		for(int i=0; i<listYear.size(); i++){
			yearCol[i] = Integer.valueOf(listYear.get(i).get("YEAR").toString());
		}
		List<Map<String,Object>> listCount = dataDao.executQuery("SELECT COUNT (0) AS COUNT, SUBSTRING (scCreatedate, 0, 5 ) AS YEAR, SUBSTRING ( scCreatedate, 6, 2 ) AS MONTH FROM " + tableName +  " GROUP BY SUBSTRING ( scCreatedate, 0, 5 ), SUBSTRING ( scCreatedate, 6, 2 )");
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
				//System.out.println("*******************"+listCount.get(i));
			}
			dataList.add(data);
		}
		
		return StrUtil.toJson(dataList);
	}
	
	//删
	public String delFormData(String ids) {
		dataDao.dataDel(ids);
		return "";
	}
}
