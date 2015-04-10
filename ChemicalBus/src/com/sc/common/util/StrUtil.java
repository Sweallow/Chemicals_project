package com.sc.common.util;

import java.security.MessageDigest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.google.gson.Gson;

/**
 * 字符串工具类
 * @author Durton
 * @date 2013-12-4 下午01:37:39
 */
public class StrUtil {
	/**
	 * 字符串空判断
	 * @param str
	 * @return
	 */
	public static boolean isNullOrEmpty(String str) {
		boolean res = false;
		if(str == null || str.equals("")) {
			res = true;
		}
		return res;
	}
	
	/**
	 * 日期转字符串
	 * @param d
	 * @return
	 */
	public static String dateFormat(Date d) {
		String res = null;
		res = dateFormat(d, "yyyy-MM-dd HH:mm:ss S");
		return res;
	}
	/**
	 * 日期转字符串
	 * @param d
	 * @return
	 */
	public static String dateFormat(Date d, String format) {
		String res = null;
		DateFormat df = new SimpleDateFormat(format);
		res = df.format(d);
		return res;
	}
	/**
	 * Base64编码
	 * @param str
	 * @return
	 */
	public static String getBase64(String str) {
		if (isNullOrEmpty(str)) {
			return null;
		}
		return new BASE64Encoder().encode(str.getBytes());
	}

	/**
	 * Base64解码
	 * @param str
	 * @return
	 */
	public static String getFromBase64(String str) {
		if (isNullOrEmpty(str)) {
			return null;
		}
		try {
			return new String(new BASE64Decoder().decodeBuffer(str));
		} catch (Exception e) {
			return null;
		}
	}
	/**
	 * MD5加密
	 * @param str
	 * @return
	 */
	public static String md5(String str) {
		String res = null;
		if(!isNullOrEmpty(str)) {
			MessageDigest md5 = null;
			try {
				md5 = MessageDigest.getInstance("MD5");
				byte[] md5Byte = md5.digest(str.getBytes());
				StringBuffer sb = new StringBuffer(md5Byte.length * 2); 
				for (int i = 0; i < md5Byte.length; i++) {  
					sb.append(Character.forDigit((md5Byte[i] & 240) >> 4, 16)); 
					sb.append(Character.forDigit(md5Byte[i] & 15, 16));  
				}
				res = sb.toString();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return res;
	}
	/**
	 * 首字母转大写
	 * @param str
	 * @return
	 */
    public static String toUpperCaseFirstChar(String str)
    {
        if(Character.isUpperCase(str.charAt(0))) {
        	return str;
        } else {
			return (new StringBuilder()).append(
					Character.toUpperCase(str.charAt(0))).append(
					str.substring(1)).toString();
        }
    }
    /**
     * 将对象转成String
     * @param o
     * @return
     */
    public static String toJson(Object o) {
    	Gson g = new Gson();
    	return g.toJson(o);
    }
    /**
     * 字符串转int
     * @param str
     * @return
     */
    public static int toInt(String str) {
    	int res = 0;
    	if(!isNullOrEmpty(str)) {
    		res = Integer.parseInt(str);
    	}
    	return res;
    }
}
