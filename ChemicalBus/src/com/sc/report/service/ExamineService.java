package com.sc.report.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sc.common.dao.BaseDao;
import com.sc.common.model.Column;
import com.sc.common.model.FormData;
import com.sc.common.service.BaseService;
import com.sc.common.util.StrUtil;
import com.sc.report.dao.ExamineDao;
import com.sc.report.model.C_examine;

public class ExamineService extends BaseService<C_examine> {
	private ExamineDao dataDao = new ExamineDao();

	@Override
	public BaseDao<C_examine> getDao() {
		return dataDao;
	}
	
	/**
	 * 保存
	 * @param mainDataStr
	 * @param subDataStr
	 * @return
	 */
	public String dataSave(String mainDataStr, String subDataStr) {
		List<String> sqls = new ArrayList<String>();
		Gson g = new Gson();
		FormData mainData = g.fromJson(mainDataStr, FormData.class);
		String sql = "";		
		String columnNames = "";
		String columnValues = "";
		String updateColumns = "";
		for(int i = 0; i < mainData.getColumns().size(); i++) {
			Column c = mainData.getColumns().get(i);
			columnNames += "," + c.getColumnName();
			columnValues += ", '" + c.getColumnValue() + "'";
			updateColumns += "," + c.getColumnName() + " = '" + c.getColumnValue() + "'";
		}
		if(StrUtil.isNullOrEmpty(mainData.getScid())) {
			//新增
			mainData.setScid(UUID.randomUUID().toString());	
			sql = "INSERT INTO C_INFORMATION "  + 
					"(SCID " + columnNames + ", SCCREATEDATE, SCSHOWORDER ) SELECT '" + 
					mainData.getScid() + "'" + columnValues + ", '" + StrUtil.dateFormat(new Date()) 
					+ "', ISNULL(MAX(SCSHOWORDER) + 1, 0) FROM C_INFORMATION";
		} else {
			//修改
			sql = "UPDATE C_INFORMATION SET " + updateColumns.substring(1) + 
					" WHERE SCID = '" + mainData.getScid() + "'";
		}
		sqls.add(sql);
		Gson gson = new Gson();
        List<C_examine> list = gson.fromJson(subDataStr, new TypeToken<List<C_examine>>() {}.getType());
        //先根据主表scid清空对应附表数据
        String delSql = "DELETE FROM C_EXAMINE WHERE ID = '" + mainData.getScid() + "'";
        sqls.add(delSql);
        for(C_examine a : list) {
        	/*String fSql = "INSERT INTO C_EXAMINE " +
        			"(SCID, ID, RISK_CATEGORIES, CLASSIFICATION_RESULTS, AUDIT_OPINION, REMARKS, SCCREATEDATE,SCSHOWORDER) " 
        		+ "VALUES ('" 
        		+ UUID.randomUUID().toString() + "','" + mainData.getScid() + "', '" +  a.getRisk_categories() + "', '"
        		+ a.getClassification_results() + "', '" + a.getAudit_opinion() + "', '" + a.getRemarks() + "', '"
        		+ StrUtil.dateFormat(new Date()) + "', 0)";*/
        	//附表插入数据时，加入SCSHOWORDER，作为排序依据
        	String fSql ="INSERT INTO C_EXAMINE "  + 
			"(SCID, ID, RISK_CATEGORIES, CLASSIFICATION_RESULTS, " +
			"AUDIT_OPINION, REMARKS, SCCREATEDATE,SCSHOWORDER ) SELECT '"
			+ UUID.randomUUID().toString() + "','" + mainData.getScid() + "', '" +  a.getRisk_categories() + "', '"
    		+ a.getClassification_results() + "', '" + a.getAudit_opinion() + "', '" + a.getRemarks() + "', '"
			+ StrUtil.dateFormat(new Date()) + "', ISNULL(MAX(SCSHOWORDER) + 1, 0) FROM C_EXAMINE";
//        	System.out.println("****副表:***fSql==========="+fSql);
        	sqls.add(fSql);
        }
        dataDao.executeNoQuery(sqls);
		return null;
	}
	
	/**
	 * 查询附表数据，返回到前台显示在附表表格
	 * @param scid
	 * @return
	 */
	public String getAppraisalInfoDatas(String scid) {
		String res = "";
		//查询附表数据时按照SCSHOWORDER排序，按对应位置取值，再写入表格
		String sql = "SELECT CLASSIFICATION_RESULTS, AUDIT_OPINION, " +
    			"REMARKS FROM C_EXAMINE WHERE ID = '" + scid + "' ORDER BY SCSHOWORDER";
		List<Map<String, Object>> list = dataDao.executQuery(sql);
		res = StrUtil.toJson(list);
//		System.out.println("sql========"+sql);
//		System.out.println("res+++++++++====="+res);
		return res;
	}

}
