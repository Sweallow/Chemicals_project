package com.sc.dangerClassifyReport.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sc.common.dao.BaseDao;
import com.sc.common.service.BaseService;
import com.sc.common.util.StrUtil;
import com.sc.dangerClassifyReport.dao.DangerClassifyReportDao;
import com.sc.dangerClassifyReport.model.DangerClassifyReport;

public class DangerClassifyReportService extends BaseService<DangerClassifyReport> {

	private DangerClassifyReportDao dataDao = new DangerClassifyReportDao();
	private String ClName = dataDao.getTableName();
	
	@Override
	public BaseDao<DangerClassifyReport> getDao() {
		return dataDao;
	}

	/**
	 * @param 数据统计
	 * @return
	 */
	public String selTotal(String str) {
		List<int[]> dataList = new ArrayList<int[]>();
		List<Map<String, Object>> listYear = dataDao
				.executQuery("SELECT SUBSTRING (scCreatedate, 0, 5) AS YEAR FROM "
						+ ClName + " GROUP BY substring (scCreatedate, 0, 5)");
		int[] yearCol = new int[listYear.size()];
		for (int i = 0; i < listYear.size(); i++) {
			yearCol[i] = Integer
					.valueOf(listYear.get(i).get("YEAR").toString());
		}
		List<Map<String, Object>> listCount = dataDao
				.executQuery("SELECT COUNT (*) AS COUNT, SUBSTRING ( scCreatedate, 0, 5 ) AS YEAR, SUBSTRING ( scCreatedate, 6, 2 ) AS MONTH "
						+ "FROM "
						+ ClName
						+ " GROUP BY SUBSTRING ( scCreatedate, 0, 5 ), SUBSTRING ( scCreatedate, 6, 2 )");
		for (int n = 0; n < listYear.size(); n++) {
			int[] data = new int[13];
			data[0] = yearCol[n];
			for (int i = 0; i < listCount.size(); i++) {
				int year = Integer.valueOf(listCount.get(i).get("YEAR")
						.toString());
				int month = Integer.valueOf(listCount.get(i).get("MONTH")
						.toString().split("-")[0]);
				int count = Integer.valueOf(listCount.get(i).get("COUNT")
						.toString());
				if (year == yearCol[n]) {
					data[month] = count;
				}
//				System.out.println("*******************" + listCount.get(i));
			}
			dataList.add(data);
		}
		return StrUtil.toJson(dataList);
	}
	
	/**
	 * 更新审核状态
	 * @param scstatus
	 * @param scid
	 * @return
	 */
	public String updateScstatus(String scstatus, String scid) {
		int rs = dataDao.executeNoQuery("UPDATE " + ClName + " SET SCSTATUS = '" 
				+ scstatus + "' WHERE SCID = '" + scid + "'");
		if (rs > 0) {
			return "success";
		} else {
			return "false";
		}
	}
	
	/**
	 * 更新驳回原因
	 * @param reason
	 * @param scid
	 * @return
	 */
	public String updateReason(String reason, String scid) {
		int rs = dataDao.executeNoQuery("update " + ClName
				+ " set back_reason = '" + reason + "' where scid = '" + scid + "'");
		if (rs > 0) {
			return "success";
		} else {
			return "false";
		}
	}
	
	/**
	 * 单选按钮----获取状态名（固体/液体/气体/其它）
	 * @param scid
	 * @return
	 */
	/*public String getstatusName(String scid) {
		String res = "";
		String sql = "SELECT status_name from C_DANGER_CLASSIFY_REPORT WHERE scid = '" + scid + "'";
		List<Map<String, Object>> list = dataDao.executQuery(sql);
		res = StrUtil.toJson(list);
		return res;
	}*/
	
	/**
	 * 判断申请对象是否已填写通知书，若已填写则返回对应通知书的scid
	 * @param appScid
	 * @return
	 */
	public String isNotice(String appScid){
		List<Map<String,Object>> list = dataDao.executQuery("SELECT scid AS SCID FROM C_information WHERE appScid = '"+appScid+"'");
		String scid = "";
		if(list.size()>0){
			scid = list.get(0).get("SCID").toString();
		}
		return scid;
	}
	
	/**
	 * 删除填报信息及其审核通过的通知书
	 * @param ids
	 * @return
	 */
	public String delFormDatas(String ids) {
		List<String> sqls = new ArrayList<String>();
		//删除相应填报信息
		String sql1="DELETE FROM C_DANGER_CLASSIFY_REPORT WHERE SCID IN ('" + ids.replace(",", "','") + "')";
		//删除填报信息相关的通知书
		String sql2="DELETE FROM C_INFORMATION WHERE APPSCID IN (SELECT SCID FROM C_DANGER_CLASSIFY_REPORT WHERE SCID IN ('" + ids.replace(",", "','") + "'))";
		//删除通知书附表信息
		String sql3="DELETE FROM C_EXAMINE WHERE ID IN (SELECT SCID FROM C_INFORMATION WHERE APPSCID IN (SELECT SCID FROM C_DANGER_CLASSIFY_REPORT WHERE SCID IN ('" + ids.replace(",", "','") + "')))";
		sqls.add(sql3);
		sqls.add(sql2);
		sqls.add(sql1);
		dataDao.executeNoQuery(sqls);
		return "";
	}
}
