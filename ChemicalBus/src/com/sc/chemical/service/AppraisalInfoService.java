package com.sc.chemical.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sc.chemical.dao.AppraisalInfoDao;
import com.sc.chemical.model.AppraisalInfo;
import com.sc.common.dao.BaseDao;
import com.sc.common.model.Column;
import com.sc.common.model.FormData;
import com.sc.common.service.BaseService;
import com.sc.common.util.StrUtil;
/**
 * @author: Chenmin
 * @description:
 * @date:
 */
public class AppraisalInfoService extends BaseService<AppraisalInfo>{
	private AppraisalInfoDao dataDao = new AppraisalInfoDao();
	@Override
	public BaseDao<AppraisalInfo> getDao() {
		return dataDao;
	}
	/**
	 * @author: Chenmin
	 * @description:新增申请单位信息
	 * @return:String
	 */
	public String dataSave(String mainDataStr, String subDataStr) {
		//System.out.println("*********"+mainDataStr);
		//System.out.println("*********"+subDataStr);
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
		//System.out.println("****************"+updateColumns);
		if(StrUtil.isNullOrEmpty(mainData.getScid())) {
			//主表数据新增
			mainData.setScid(UUID.randomUUID().toString());
			sql = "INSERT INTO C_APPLICATIONENTERPRISEINFO "  + 
					"(SCID " + columnNames + ", SCCREATEDATE, SCSHOWORDER) select '" + 
					mainData.getScid() + "'" + columnValues + ", '" + StrUtil.dateFormat(new Date()) 
					+"', ISNULL(MAX(SCSHOWORDER) + 1, 0) FROM C_APPLICATIONENTERPRISEINFO";
		} else {
			//修改
			sql = "UPDATE C_APPLICATIONENTERPRISEINFO SET " + updateColumns.substring(1) + 
					" WHERE SCID = '" + mainData.getScid() + "'";// + " and scStatus <> 1"
			
		}
		//System.out.println("**********主表sql:=======" + sql);
		sqls.add(sql);
		
		Gson gson = new Gson();
        List<AppraisalInfo> list = gson.fromJson(subDataStr,
                new TypeToken<List<AppraisalInfo>>() {
                }.getType());
        String delSql = "delete from c_appraisalInfo where glid = '" + mainData.getScid() + "'";
        sqls.add(delSql);
        for(AppraisalInfo a : list) {
        	//副表数据新增
        	String fSql = "INSERT INTO C_APPRAISALINFO (SCID, NUMB, CHEMICALNAME, APPRAISALORGANIZATIONNAME, " +
        			"REPORTISSUEDDATE, APPRAISALTYPE, GLID, SCCREATEDATE, SCSTATUS, SCSHOWORDER) select '"
        		+ UUID.randomUUID().toString() + "','" + a.getNumb() + "', '" +  a.getChemicalName() + "', '"
        		+ a.getAppraisalOrganizationName()+ "', '" + a.getReportIssuedDate() + "', '" + a.getAppraisalType() + "', '"
        		+ mainData.getScid() + "', '" + StrUtil.dateFormat(new Date()) + "', 0, ISNULL(MAX(SCSHOWORDER) + 1, 0) FROM C_APPRAISALINFO";
        //	System.out.println("**********副表sql:======="+fSql);
        	sqls.add(fSql);
        }
        dataDao.executeNoQuery(sqls);
        
		return null;
	}
	/**
	 * @author: Chenmin
	 * @description:获取子表信息,返回给前台
	 * @return String:
	 */
	public String getAppraisalInfoDatas(String scid) {
		String res = "";
		String sql = "SELECT NUMB, CHEMICALNAME, APPRAISALORGANIZATIONNAME, " +
        			"REPORTISSUEDDATE, APPRAISALTYPE, SCSTATUS from C_APPRAISALINFO WHERE GLID = '" + scid + "' order by SCSHOWORDER ";//
		List<Map<String, Object>> list = dataDao.executQuery(sql);
		res = StrUtil.toJson(list);
	//	System.out.println("返回给前台的json:*res:====="+res);
		return res;
	}
}
