package chemical.dao;

import chemical.model.ChemicalApplication;

import com.sc.common.dao.BaseDao;
import com.sc.sys.model.User;

public class ChemicalApplicationDao extends BaseDao<ChemicalApplication>{

	@Override
	protected Class<?> getModelClass() {
		return ChemicalApplication.class;
	}

	@Override
	public String getTableName() {
		return "c_chemicalApplication";
	}

}
