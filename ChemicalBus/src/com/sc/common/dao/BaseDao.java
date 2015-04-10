package com.sc.common.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;

import com.sc.common.model.Column;
import com.sc.common.model.FormData;
import com.sc.common.model.Pager;
import com.sc.common.util.Global;
import com.sc.common.util.StrUtil;

/**
 * 基础DAO
 * @author Durton
 *
 * @date 2014-4-17 下午11:21:19
 */
public abstract class BaseDao<T> {
	protected ResultSetHandler<List<T>> rsh = null;
	
	protected abstract Class<?> getModelClass();//得到类名
	protected abstract String getTableName();//得到表名
	
	public static DataSource ds;
	/**
	 * 得到数据源
	 * @return
	 */
	public DataSource getDataSource() {
		try {
			if(ds == null) {
				Context ctx = new InitialContext();
				ds = (DataSource)ctx.lookup(Global.getProperty("dbname"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ds;
	}
	
	/**
	 * 得到用户结果集Handler
	 * @return
	 */
	public ResultSetHandler<List<T>> getMenuRsh() {
		if(rsh == null) {
			rsh = new BeanListHandler<T>((Class<T>) this.getModelClass());
		}
		return rsh;
	}
	/**
	 * 得到数据集
	 * @param startIndex 起始
	 * @param pageSize 每页数量
	 * @param sql sql语句
	 * @return
	 */
	public List<T> getDatasBySql(String sql) {
		try {
			//创建一个QueryRunner，以dataSource为参数
			DataSource dataSource = this.getDataSource();
			QueryRunner run = new QueryRunner(dataSource);
			//执行query，通过handler得到结果
			List<T> list = (List<T>) run.query(sql, rsh);
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 得到数据集
	 * @param startIndex 起始第数
	 * @param pageSize 每页显示第数
	 * @param filter 过滤条件
	 * @return
	 */
	public List<T> getDatas(int startIndex, int pageSize,
			String filter) {
		return getDatas(startIndex, pageSize, filter, "");
	}
	/**
	 * 得到数据集
	 * @param startIndex 起始第数
	 * @param pageSize 每页显示第数
	 * @param filter 过滤条件
	 * @return
	 */
	public List<T> getDatas(int startIndex, int pageSize,
			String filter, String order) {
		
		order = (StrUtil.isNullOrEmpty(order) ? " ORDER BY SCSHOWORDER DESC" : order);
		filter = (StrUtil.isNullOrEmpty(filter) ? "" : filter);
		
		String tableName = this.getTableName();//表名
		  
		String sql = "select top " + pageSize + " * from " + tableName 
				+ " where scid not in (select top " + startIndex + " scid from " 
				+ tableName + " where 1=1 " + filter + order + ")" + filter + order;
		System.out.println(sql);
		try {
			//创建一个QueryRunner，以dataSource为参数
			DataSource dataSource = this.getDataSource();
			QueryRunner run = new QueryRunner(dataSource);
			//执行query，通过handler得到结果
			List<T> list = (List<T>) run.query(sql, this.getMenuRsh());
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 得到数据总条数
	 * @param tableName
	 * @param filter
	 * @return
	 */
	public int getDataCount(String filter) {
		String tableName = this.getTableName();//表名
		String sql = "SELECT COUNT(0) AS TOTAL FROM " + tableName + " WHERE 1=1 " + filter;
		Connection conn = null;
		try {
			conn = this.getDataSource().getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next()) {
				return rs.getInt("TOTAL");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
		    //使用帮助类，我们不需要检查非空
		    try {
				DbUtils.close(conn);
			} catch (SQLException e) {
				e.printStackTrace();
			}  
		}
		return 0;
	}
	/**
	 * 执行更新SQL
	 * @param sql
	 * @return
	 */
	public int executeNoQuery(String sql) {
		Connection conn = null;  
        QueryRunner queryRunner = new QueryRunner(true);  
		try {
			conn = this.getDataSource().getConnection();
			return queryRunner.update(conn, sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
		    try {
				DbUtils.close(conn);
			} catch (SQLException e) {
				e.printStackTrace();
			}  
		}
		return 0;
	}
	/**
	 * 得到列表数据
	 * @param startIndex
	 * @param pageSize
	 * @param filter
	 * @return
	 */
	public String getPageData(int startIndex, int pageSize,
			String filter) {
		return getPageData(startIndex, pageSize, filter, "");
	}
	/**
	 * 得到列表数据
	 * @param startIndex
	 * @param pageSize
	 * @param filter
	 * @return
	 */
	public String getPageData(int startIndex, int pageSize,
			String filter, String order) {
		List<T> list = this.getDatas(startIndex, pageSize, filter, order);
		int total = this.getDataCount(filter);
		Pager p = new Pager(total, list);
		return StrUtil.toJson(p);
	}
	/**
	 * 查询语句执行
	 * @param sql
	 * @return 对象
	 * @throws SQLException 
	 */
	public List<Map<String, Object>> executQuery(String sql){
		try {
			//创建一个QueryRunner，以dataSource为参数
			DataSource dataSource = this.getDataSource();
			QueryRunner run = new QueryRunner(dataSource);
			//执行query，通过handler得到结果
			List<Map<String, Object>> list = (List<Map<String, Object>>) run.query(sql, new MapListHandler());
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 批处理
	 * @param sqls
	 * @return
	 */
	public int[] executeNoQuery(List<String> sqls) {
		Connection conn = null;
		try {
			conn = this.getDataSource().getConnection();
			Statement st = conn.createStatement();
			for(String sql : sqls) {
				st.addBatch(sql);
			} 
			return st.executeBatch();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
		    try {
				DbUtils.close(conn);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	/**
	 * 数据保存
	 * @param fd
	 * @return
	 */
	public int dataSave(FormData fd) {
		fd.setTableName(this.getTableName());
		return this.executeNoQuery(fd.toSaveSql());
	}
	/**
	 * 数据删除
	 */
	public int dataDelete(String ids) {
		String sql = "delete from " + this.getTableName() 
			+ " where scid in ('" + ids.replace(",", "','") + "')";
		return this.executeNoQuery(sql);
	}
	/**
	 * 上移/下移
	 * @param scid 选中数据主键
	 * @param filter 过滤条件
	 * @param upOrDown 上移1；下移-1
	 * @return
	 */
	public int updateShowOrder(String scid, String filter, String upOrDown, String order) {
		String sign = "";
		if (upOrDown != null
				&& ((upOrDown.equals("1") && order.toUpperCase().contains("DESC")) || (upOrDown
						.equals("-1") && !order.toUpperCase().contains("DESC")))) {
			sign = ">=";// 上移
			order = " ORDER BY SCSHOWORDER";
		} else {
			// 下移
			sign = "<=";
			order = " ORDER BY SCSHOWORDER DESC";
		}
        String selSql = "SELECT top 2 * FROM " + this.getTableName() + " T WHERE T.SCSHOWORDER " + sign + 
        		" (SELECT T1.SCSHOWORDER FROM " + this.getTableName() + " T1 WHERE T1.SCID = '" + scid + 
        		"') " + filter + order;
System.out.println(selSql);
        List<Map<String, Object>> list = this.executQuery(selSql);
        List<String> sqls = new ArrayList<String>();
        if(list.size() == 2) {
        	String scid1 = list.get(0).get("SCID").toString();
			String scShowOrder1 = list.get(0).get("SCSHOWORDER").toString();
			
			String scid2 = list.get(1).get("SCID").toString();
			String scShowOrder2 = list.get(1).get("SCSHOWORDER").toString();
			
			String saveSql1 = "UPDATE " + this.getTableName() + " SET SCSHOWORDER = " 
				+ scShowOrder2 + " WHERE SCID = '" + scid1 + "'";
			sqls.add(saveSql1);
			String saveSql2 = "UPDATE " + this.getTableName() + " SET SCSHOWORDER = " 
				+ scShowOrder1 + " WHERE SCID = '" + scid2 + "'";
			sqls.add(saveSql2);
        }
        this.executeNoQuery(sqls);
		return 1;
	}
	/**
	 * 查询表单数据
	 * @param fd
	 * @return
	 */
	public FormData dataQuery(FormData fd) {
		fd.setTableName(this.getTableName());
		Connection conn = null;
		try {
			conn = this.getDataSource().getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(fd.toQuerySql());
			if(rs.next()) {
				for(Column c : fd.getColumns()) {
					c.setColumnValue(rs.getString(c.getColumnName()));
				}
				return fd;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
		    try {
				DbUtils.close(conn);
			} catch (SQLException e) {
				e.printStackTrace();
			}  
		}
		return null;
	}
}
