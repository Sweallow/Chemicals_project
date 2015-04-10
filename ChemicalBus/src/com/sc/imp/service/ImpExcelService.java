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
	 * excel�ļ�����
	 * @return list����
	 */
	public static List<String> readExcel(InputStream is) {
		//����һ��sql��
		List<String> sqls = new ArrayList<String>();
		try {
			//����excel�ļ�
			//InputStream is = new FileInputStream(file);
			//����������
			Workbook rwb = Workbook.getWorkbook(is);
			//��ȡexcel����sheetҳ
			Sheet st = rwb.getSheet(0);
			//���sheetҳ������
			int rows = st.getRows();
			//pid���ֱ���������ʵ�����������������Ҫ�����������һ��
			String pid = UUID.randomUUID().toString();//c_sum�����scid��Ӧ��c_sum_detail�����pid��ֵ
			// ��ȡ�У�����ѭ��
			for (int k = 0; k < rows; k++) {
				//��Ϊ���ڵ����п�ʼ����ţ����Ե�K���У����ڵ���3ʱ���ܽ������ݵ�¼��
				if (k >= 3) {
					//ȡ�õ�һ�е����ֵ
					String index = st.getCell(0, k).getContents().toString().trim();//���	
					//���ѭ���������С������������ơ���һ��ʱ���������²���
					if (index.contains("������������")) {
						//��ȡ��һ��ð�ź�������ݲ���ȥ�ո�
						String company = index.split("��")[1].trim().split(" ")[0].trim();//��������
						//��ȡ�ڶ���ð�ź��������
						String sdate = index.split("��")[2].trim();//��������
						//ִ��sql��䣬���������ֶ���ӵ�c_sum����
						String sql = "insert into c_sum (scid,company,sdate) values ('"
								+ pid + "', '"
								+ company + "', '"
								+ sdate + "')";
						sqls.add(sql);
					} else {
						//�����Ų�Ϊ�յĻ���֤������һ�п�ʼ������
						if (!StrUtil.isNullOrEmpty(index)) {
							//��ȡ��K�У���һ�е�����
							String cname = st.getCell(1, k).getContents().toString().trim();//������
							//��ȡ��K�У��ڶ��е�����
							String cnameS = st.getCell(2, k).getContents().toString().trim();//���ı���
							//��ȡ��K�У������е�����
							String ename = st.getCell(3, k).getContents().toString().trim();//Ӣ����
							//�������ID
							String scid = UUID.randomUUID().toString();//����
							//ִ��SQL��䣬���⼸���ֶ���ӵ�c_sum_detail����ȥ
							String cellSql = "insert into c_sum_detail (scid,cname,cnameS,ename, pid, scCreateDate) values('"
									+ scid + "', '"
									+ cname + "', '"
									+ cnameS + "', '" + ename + "', '" + pid + "', '" + StrUtil.dateFormat(new Date(), "yyyy-MM-dd HH:mm:ss") + "')";
							sqls.add(cellSql);
						}
					}
				}
			}
			//�رշ���
			rwb.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		//����sql��伯
		return sqls;
	}
	/**
	 * @param sqls
	 * @return int[]����
	 */
	public static int[] saveImportData(List<String> sqls) {
		return sum.executeNoQuery(sqls);
	}
}