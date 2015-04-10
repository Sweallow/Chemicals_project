package com.sc.common.model;

import java.util.List;

/**
 * 
 * <p>
 * ����������ҳ����
 * </p>
 * 
 * @ClassName Pager
 * @Description 
 * @author ������
 * @date 2014-3-19 ����02:39:54
 */
public class Pager {
	private int total;//������������
	private List rows;//����List
	
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
