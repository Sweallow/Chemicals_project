package com.sc.common.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ServiceBreak extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("text/html;charset=GBK");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String curUser = "";
		if(request.getSession().getAttribute("scuser") != null) {
			curUser = request.getSession().getAttribute("scuser").toString();
		}
		
		String className = request.getParameter("_c");//类名
	    String method = request.getParameter("_m");//方法名
	    //得到被调方法的参数
		Enumeration paramNames = request.getParameterNames();
		Map<String, String> paramMap = new HashMap<String, String>();
	    while (paramNames.hasMoreElements())
	    {
			String paramName = (String)paramNames.nextElement();
			if (!paramName.startsWith("_p"))
				continue;
			paramMap.put(paramName, request.getParameter(paramName));
	    }
	    
	    //得到参数类型数组、参数数组
	    Class<?>[] mType = new Class[paramMap.size()];
	    String[] paramArr = new String[paramMap.size()];
	    for(int j = 0; j < paramMap.size(); j++) {
	    	mType[j] = String.class;
	    	String param = paramMap.get("_p" + j);
	    	if(paramMap.get("_p" + j).equals("scUser")) {//如果是scuser则自动替换为当前用户信息
	    		param = curUser;
	    	}
	    	paramArr[j] = param;
	    }
	    
	    try {
			Class<?> c = Class.forName(className);
			Method m = c.getMethod(method, mType);
			Object result = m.invoke(c.newInstance(), paramArr);//执行方法
			//返回结果
			out.print(result);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
