package chemical.service;

import chemical.dao.ChemicalApplicationDao;
import chemical.model.ChemicalApplication;

import com.sc.common.dao.BaseDao;
import com.sc.common.service.BaseService;

public class ArbitrationAuditService extends BaseService<ChemicalApplication>{
	ChemicalApplicationDao cadao=new ChemicalApplicationDao();
	
	@Override
	public BaseDao<ChemicalApplication> getDao() {
		return cadao;
	}
	
	
	/*//ÉóºË×´Ì¬ÐÞ¸Ä
		public String updateScstatus(String scstatus, String scid){
			int rs = cadao.executeNoQuery("update "+CName+" set scstatus = '"+scstatus+"' where scid = '"+scid+"'");
			if(rs>0){
				return "success";
			}else{
				return "false";
			}
		}*/
	
		
	/*public boolean auditPass(String scid){
		String sql="update c_chemicalApplication set scStatus='1' where scid='"+scid+"'";
		int i=cadao.executeNoQuery(sql);
		if(i>0){
			return true;
		}
		return false;
	}
	
	public boolean auditNotPass(String scid){
	
		String sql="update c_chemicalApplication set scStatus='-1' where scid='"+scid+"'";
		int i=cadao.executeNoQuery(sql);
		if(i>0){
			return true;
		}
		return false;
	}*/
	
	/*public boolean saveRejectReason(String scid,String reason){
		String	sql="update c_chemicalApplication set theReason='"+reason+"'where scid='"+scid+"'";
		int i=cadao.executeNoQuery(sql);
		if(i>0){
			return true;
		}
		return false;
	}*/
	
	public boolean judgeSuccessRe(String scid){
		String sql="select noticeId from c_chemicalApplication where applicationCount='"+scid+"'";
		int i=cadao.executeNoQuery(sql);
		if(i>0){
			return true;
		}
		return false;		
	}
}
