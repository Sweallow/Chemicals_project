package com.sc.imp.service;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import jxl.Sheet;
import jxl.Workbook;
import com.sc.common.dao.BaseDao;
import com.sc.common.service.BaseService;
import com.sc.common.util.StrUtil;
import com.sc.imp.dao.SumDao;
import com.sc.imp.model.Sum;

public class ImpExcelService extends BaseService<Sum> {

	private static SumDao sum = new SumDao();

	public BaseDao<Sum> getDao() {
		return sum;
	}
	/**
	 * excel文件解析
	 * @return list集合
	 */
	public static List<String> readExcel(InputStream is) {
		//定义一个sql集
		List<String> sqls = new ArrayList<String>();
		try {
			//传入excel文件
			//InputStream is = new FileInputStream(file);
			//简历工作薄
			Workbook rwb = Workbook.getWorkbook(is);
			//获取excel表格的sheet页
			Sheet st = rwb.getSheet(0);
			//获得sheet页的行数
			int rows = st.getRows();
			//pid是字表里的外键，实则是主表里的主键，要和主表的主键一致
			String pid = UUID.randomUUID().toString();//c_sum表里的scid对应的c_sum_detail里面的pid的值
			// 获取行，进行循环
			for (int k = 0; k < rows; k++) {
				//因为是在第三行开始有序号，所以当K（行）大于等于3时才能进行数据的录入
				if (k >= 3) {
					//取得第一列的序号值
					String index = st.getCell(0, k).getContents().toString().trim();//序号	
					//如果循环到内容有“鉴定机构名称”这一行时，进行如下操作
					if (index.contains("鉴定机构名称")) {
						//获取第一个冒号后面的数据并且去空格
						String company = index.split("：")[1].trim().split(" ")[0].trim();//鉴定机构
						//获取第二个冒号后面的数据
						String sdate = index.split("：")[2].trim();//鉴定日期
						//执行sql语句，将这三个字段添加到c_sum表中
						String sql = "insert into c_sum (scid,company,sdate) values ('"
								+ pid + "', '"
								+ company + "', '"
								+ sdate + "')";
						sqls.add(sql);
					} else {
						//如果序号不为空的话，证明从这一行开始有数据
						if (!StrUtil.isNullOrEmpty(index)) {
							//获取第K行，第一列的数据
							String cname = st.getCell(1, k).getContents().toString().trim();//中文名
							//获取第K行，第二列的数据
							String cnameS = st.getCell(2, k).getContents().toString().trim();//中文别名
							//获取第K行，第三列的数据
							String ename = st.getCell(3, k).getContents().toString().trim();//英文名
							//随机生成ID
							String scid = UUID.randomUUID().toString();//主键
							//执行SQL语句，将这几个字段添加到c_sum_detail表中去
							String cellSql = "insert into c_sum_detail (scid,cname,cnameS,ename, pid, scCreateDate) values('"
									+ scid + "', '"
									+ cname + "', '"
									+ cnameS + "', '" + ename + "', '" + pid + "', '" + StrUtil.dateFormat(new Date(), "yyyy-MM-dd HH:mm:ss") + "')";
							sqls.add(cellSql);
						}
					}
				}
			}
			//关闭服务
			rwb.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		//返回sql语句集
		return sqls;
	}
	/**
	 * @param sqls
	 * @return int[]数组
	 */
	public static int[] saveImportData(List<String> sqls) {
		return sum.executeNoQuery(sqls);
	}
}