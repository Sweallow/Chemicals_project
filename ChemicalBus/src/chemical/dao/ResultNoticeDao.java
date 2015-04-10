package chemical.dao;

import chemical.model.ResultNotice;

import com.sc.common.dao.BaseDao;

/**
 * @author mengru
 *
 */
public class ResultNoticeDao extends BaseDao<ResultNotice>{

	@Override
	protected Class<?> getModelClass() {
		return ResultNotice.class;
	}

	@Override
	protected String getTableName() {
		return "c_resultNotice";
	}
}
