package com.sc.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.util.Properties;

/**
 * Global��������
 * @author Durton
 * @date 2013-12-9 ����12:00:28
 */
public class Global {
	private static String path;//�����·��
	/**
	 * �õ�ϵͳ ��·��
	 * @return
	 */
	public static String getPath() {
		if(StrUtil.isNullOrEmpty(path)) {
			try {
				File classPath = new File(Thread.currentThread().getContextClassLoader().getResource("").toURI().getPath());
				path = classPath.getParentFile().getParent();//��·��
				//path = "E:\\apache-tomcat-6.0.33\\webapps\\ChemicalBus";
			} catch (URISyntaxException e) {
				e.printStackTrace();
			}
		}
        return path;
	}
	/**
	 * ��ȡglobal.propertiesֵ
	 * @param name
	 * @param fileName
	 * @return
	 */
	public static String getProperty(String name) {
		return getProperty(name, "global.properties");
	}
	/**
	 * ��ȡpropertiesֵ
	 * @param name
	 * @param fileName
	 * @return
	 */
	public static String getProperty(String name, String fileName) {
		String res = null;
		try {
			InputStream is = new FileInputStream(getPath() + "/WEB-INF/" + fileName);
			Properties p = new Properties();
			p.load(is); 
			if(p.containsKey(name)) {
				res = p.getProperty(name, "");
				res = new String(res.getBytes("ISO-8859-1"), "GBK");//�����������
			}
			is.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}
}
