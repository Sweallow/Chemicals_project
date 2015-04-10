package com.sc.common.model;

import java.util.List;

/**
 * 
 * <p>
 * 类描述：分页数据
 * </p>
 * 
 * @ClassName Pager
 * @Description 
 * @author 邓守祥
 * @date 2014-3-19 下午02:39:54
 */
public class Pager {
	private int total;//数据总条数据
	private List rows;//数据List
	
	public Pager(int total, List rows) {
		this.total = total;
		this.rows = rows;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public List getRows() {
		return rows;
	}

	public void setRows(List rows) {
		this.rows = rows;
	}
}
