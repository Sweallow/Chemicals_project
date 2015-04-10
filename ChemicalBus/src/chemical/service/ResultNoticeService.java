package chemical.service;

import chemical.dao.ChemicalApplicationDao;
import chemical.dao.ResultNoticeDao;
import chemical.model.ChemicalApplication;
import chemical.model.ResultNotice;

import com.sc.common.dao.BaseDao;
import com.sc.common.service.BaseService;
import com.sc.sys.model.User;


public class ResultNoticeService extends BaseService<ResultNotice>{
	private ResultNoticeDao resultNoticeDao=new ResultNoticeDao();
	
	@Override
	public BaseDao<ResultNotice> getDao() {
		return resultNoticeDao;
	}
}