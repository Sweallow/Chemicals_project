package com.sc.sys.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sc.common.util.StrUtil;
import com.sc.sys.model.User;
import com.sc.sys.service.UserService;

/**
 * ��¼
 * 
 * @author Durton
 * 
 * @date 2014-12-15 ����9:22:25
 */
public class LoginServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=GBK");

		String userCode = request.getParameter("userCode");// �û���
		String password = request.getParameter("password");// ����
		User u = new UserService().login(userCode, password);// ��½��֤
		if (u != null) {
			// д��session
			HttpSession session = request.getSession();
			session.setAttribute("scuser", StrUtil.toJson(u));
		}
		PrintWriter out = response.getWriter();
		out.print(StrUtil.toJson(u));
		out.flush();
		out.close();
	}
}
