package com.sc.imp.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import com.sc.imp.service.ImpExcelService;

public  class ExcelImpServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
				doPost(request, response);
	}
	//����Excel��servlet����
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		DiskFileItemFactory f = new DiskFileItemFactory();//���̶���
		//f.setRepository(new File("/temp")); //������ʱĿ¼
		f.setSizeThreshold(1024*8); //8k�Ļ�����,�ļ�����8K�򱣴浽��ʱĿ¼
		ServletFileUpload upload = new ServletFileUpload(f);//��������request�Ķ���
		upload.setHeaderEncoding("GBK"); //�����ļ�������
		upload.setFileSizeMax(1024 * 1024 * 5);// ����ÿ���ļ����Ϊ5M
		upload.setSizeMax(1024 * 1024 * 10);// һ��������ϴ�10M
		String path = getServletContext().getRealPath("//sg//upimg");//��ȡ�ļ�Ҫ�����Ŀ¼
		try {
			List<FileItem> list = upload.parseRequest(request);// ����
			if(list.size() > 0) {
				FileItem fi = list.get(0);//�ļ�����
				List<String> sqls = ImpExcelService.readExcel(fi.getInputStream());
				ImpExcelService.saveImportData(sqls);
				//���ؽ��
				out.print("true");
				out.flush();
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}