package com.sc.sys.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * 系统初始化
 * @author Durton
 *
 * @date 2014-12-15 上午8:59:54
 */
public class SysInit implements ServletContextListener {

	public void contextDestroyed(ServletContextEvent arg0) {
		
	}

	public void contextInitialized(ServletContextEvent arg0) {
		System.out.println("系统启动完成");
	}

}
