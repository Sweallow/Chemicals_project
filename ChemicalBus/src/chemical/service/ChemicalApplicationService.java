package chemical.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import sun.misc.Request;

import chemical.dao.ChemicalApplicationDao;
import chemical.dao.ResultNoticeDao;

import chemical.model.ChemicalApplication;
import chemical.model.ResultNotice;

import com.sc.common.dao.BaseDao;
import com.sc.common.service.BaseService;
import com.sc.common.util.StrUtil;
import com.sc.sys.model.Menu;
import com.sc.sys.model.Tree;

public class ChemicalApplicationService extends BaseService<ChemicalApplication>{
	private ChemicalApplicationDao chemicleApplicationDao=new ChemicalApplicationDao();
	private String CName = chemicleApplicationDao.getTableName();
	
	@Override
	public BaseDao<ChemicalApplication> getDao() {
		return chemicleApplicationDao;
	}
	
	/**
	 * 数据统计
	 * @param str
	 * @return
	 */
	public String selTotal(String str){
		List<int[]> dataList = new ArrayList<int[]>();
		List<Map<String,Object>> listYear = chemicleApplicationDao.executQuery
				("SELECT SUBSTRING (scCreatedate, 0, 5) AS YEAR FROM "+CName+" GROUP BY SUBSTRING (scCreatedate, 0, 5)");
		int[] yearCol = new int[listYear.size()];
		for(int i=0; i<listYear.size(); i++){
			yearCol[i] = Integer.valueOf(listYear.get(i).get("YEAR").toString());
		}
		List<Map<String,Object>> listCount = chemicleApplicationDao.executQuery
				("SELECT COUNT(*)  AS Count, SUBSTRING ( scCreatedate, 0, 5 ) AS YEAR, SUBSTRING ( scCreatedate, 6, 2 ) AS MONTH " +
						"FROM c_chemicalApplication GROUP BY SUBSTRING ( scCreatedate, 0, 5), SUBSTRING ( scCreatedate, 6, 2 )");
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
	
	//审核状态修改
	public String updateScstatus(String scstatus, String scid){
		int rs = chemicleApplicationDao.executeNoQuery("update "+CName+" set scStatus = '"+scstatus+"' where scid = '"+scid+"'");
		if(rs>0){
			return "success";
		}else{
			return "false";
		}
	}
	
	//驳回原因填写
	public String updateReason(String theReason, String scid){
		int rs = chemicleApplicationDao.executeNoQuery("update "+CName+" set theReason = '"+theReason+"' where scid = '"+scid+"'");
		if(rs>0){
			return "success";
		}else{
			return "false";
		}
	}
	
	
	/**
	 * 判断申请对象是否已填写通知书，若已填写则返回对应通知书的scid
	 * @param appscid
	 * @return
	 */
	public String judgeSuccessRe(String appscid){
		String sql="select scid AS SCID from c_categoryArbitralResult where appId='"+appscid+"'";
		List<Map<String,Object>> list= chemicleApplicationDao.executQuery(sql);
		String scid = "";
		if(list.size()>0){
			scid = list.get(0).get("SCID").toString();
		}
		return scid;
	}
}
