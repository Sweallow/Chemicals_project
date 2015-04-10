package com.sc.sys.servlet;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * �û���¼״̬����
 * 
 * @author Durton
 * 
 * @date 2014-4-17 ����09:03:18
 */
public class VisitFilter implements javax.servlet.Filter {
	public void destroy() {

	}

	public void doFilter(ServletRequest req, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		String url = request.getRequestURI();
		String userId = "";
		// ���е�¼ҳ�桢ajax
		if ((-1 == url.toUpperCase().indexOf("/SC/SYS") && -1 == url
				.toUpperCase().indexOf("/SG"))
				|| -1 != url.toUpperCase().indexOf("/LOGIN")
				|| -1 != url.toUpperCase().indexOf("/COMMON")
				|| -1 != url.indexOf("servlet/ServiceBreak")) {
			chain.doFilter(request, response);
			return;
		}
		Object user = null;
		try {
			HttpSession session = request.getSession();
			user = session.getAttribute("scuser");
		} catch (Exception e) {
			request.getRequestDispatcher("/").forward(request, response);
			return;
		}

		if (user == null || "".equals(user)) {// ���ʳ�ʱ
			request.getRequestDispatcher("/sc/sys/Login.jsp").forward(request,
					response);
			return;
		}
		chain.doFilter(req, response);
		return;
	}

	public void init(FilterConfig arg0) throws ServletException {

	}
}
