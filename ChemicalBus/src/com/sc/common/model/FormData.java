package com.sc.common.model;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import com.sc.common.util.StrUtil;

/**
 * 表单数据类
 * @author Durton
 * @date 2014-1-2 下午01:20:08
 */
public class FormData {
	private String tableName;
	private String scid;
	private List<Column> columns;
	private String filter;
	
	public FormData() {
		super();
	}
	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getScid() {
		return scid;
	}

	public void setScid(String scid) {
		this.scid = scid;
	}

	public List<Column> getColumns() {
		return columns;
	}

	public void setColumns(List<Column> columns) {
		this.columns = columns;
	}

	public String getFilter() {
		return filter;
	}

	public void setFilter(String filter) {
		this.filter = filter;
	}
	/**
	 * 生成保存语句
	 * @return
	 */
	public String toSaveSql() {
		String res = null;
		
		String columnNames = "";
		String columnValues = "";
		String updateColumns = "";
		for(int i = 0; i < this.columns.size(); i++) {
			Column c = this.columns.get(i);
			columnNames += "," + c.getColumnName();
			columnValues += ", '" + c.getColumnValue() + "'";
			updateColumns += "," + c.getColumnName() + " = '" + c.getColumnValue() + "'";
		}
		if(this.scid == null || this.scid.equals("")) {//插入语句insert
			res = "INSERT INTO " + this.tableName + 
					"(SCID " + columnNames + ", SCCREATEDATE, SCSHOWORDER) select '" + 
					UUID.randomUUID() + "'" + columnValues + ", '" + StrUtil.dateFormat(new Date()) + "', ISNULL(MAX(SCSHOWORDER) + 1, 0) FROM " + this.tableName;
		} else {//更新语句update
			res = "UPDATE " + this.tableName + " set " + updateColumns.substring(1) + 
				" WHERE SCID = '" + this.scid + "'";
		}
		return res;
	}
	/**
	 * 生成查询语句
	 * @return
	 */
	public String toQuerySql() {
		String columnNames = "";
		for(int i = 0; i < this.columns.size(); i++) {
			Column c = this.columns.get(i);
			columnNames += "," + c.getColumnName();
		}
		String sql = "SELECT " + columnNames.substring(1) + " FROM " + 
					this.tableName + " WHERE SCID = '" + this.scid + "'";
		return sql;
	}
}
