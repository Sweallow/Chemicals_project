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
	//导入Excel的servlet方法
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		DiskFileItemFactory f = new DiskFileItemFactory();//磁盘对象
		//f.setRepository(new File("/temp")); //设置临时目录
		f.setSizeThreshold(1024*8); //8k的缓冲区,文件大于8K则保存到临时目录
		ServletFileUpload upload = new ServletFileUpload(f);//声明解析request的对象
		upload.setHeaderEncoding("GBK"); //处理文件名中文
		upload.setFileSizeMax(1024 * 1024 * 5);// 设置每个文件最大为5M
		upload.setSizeMax(1024 * 1024 * 10);// 一共最多能上传10M
		String path = getServletContext().getRealPath("//sg//upimg");//获取文件要保存的目录
		try {
			List<FileItem> list = upload.parseRequest(request);// 解析
			if(list.size() > 0) {
				FileItem fi = list.get(0);//文件内容
				List<String> sqls = ImpExcelService.readExcel(fi.getInputStream());
				ImpExcelService.saveImportData(sqls);
				//返回结果
				out.print("true");
				out.flush();
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}