package cn.crazy.doctor.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Random;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil {

	public static boolean isMobileNo(String mobile) {
		if (mobile == null)
			return false;

		//        Pattern p = Pattern.compile("^((13[0-9])|(15[^4,\\D])|(18[0-9])|(170))\\d{8}$"); 
		Pattern p = Pattern.compile("^1[0-9]{10}$");
		Matcher m = p.matcher(mobile);
		return m.matches();
	}

	public static String getWeekDayChar(int day) {
		String result = "";
		switch (day) {
		case 0:
			result = "日";
			break;

		case 1:
			result = "一";
			break;

		case 2:
			result = "二";
			break;

		case 3:
			result = "三";
			break;

		case 4:
			result = "四";
			break;

		case 5:
			result = "五";
			break;

		case 6:
			result = "六";
			break;
		}

		return result;
	}

	/**
	* 用特殊的字符连接字符串
	* 
	* @param strings
	*            要连接的字符串数组
	* @param spilit_sign
	*            连接字符
	* @return 连接字符串
	*/
	public static String stringConnect(Object[] strings, String spilit_sign) {
		String str = "";
		for (int i = 0; i < strings.length; i++) {
			str += strings[i].toString() + spilit_sign;
		}
		if (!str.equals(""))
			str = str.substring(0, str.length() - 1);
		return str;
	}

	public static String stringConnect(List objs, String splite_sign) {
		String str = "";
		for (int i = 0; i < objs.size(); i++) {
			str += objs.get(i).toString() + splite_sign;
		}
		if (!str.equals(""))
			str = str.substring(0, str.length() - 1);
		return str;
	}

	public static String StringConnect(Set objs, String splite_sign) {
		StringBuilder sb = new StringBuilder();
		for (Object obj : objs) {
			sb.append(obj.toString());
		}
		return sb.toString();
	}

	public static String stringConnectWithSqureBrackets(Object[] strings, String spilit_sign) {
		String str = "";
		for (int i = 0; i < strings.length; i++) {
			str += "[" + strings[i].toString() + "]" + spilit_sign;
		}
		if (!str.equals(""))
			str = str.substring(0, str.length() - 1);
		return str;
	}

	/**
	* 分割字符串
	* 
	* @param str
	*            要分割的字符串
	* @param spilit_sign
	*            字符串的分割标志
	* @return 分割后得到的字符串数组
	*/
	public static String[] stringSpilit(String str, String spilit_sign) {
		String[] spilit_string = str.split(spilit_sign);
		if (spilit_string[0].equals("")) {
			String[] new_string = new String[spilit_string.length - 1];
			for (int i = 1; i < spilit_string.length; i++)
				new_string[i - 1] = spilit_string[i];
			return new_string;
		} else
			return spilit_string;
	}

	public static boolean isNumber(String str) {
		for (int i = str.length(); --i >= 0;) {
			if (!Character.isDigit(str.charAt(i))) {
				return false;
			}
		}
		return true;
	}
	
	public static String getRandomString(int length) { //length表示生成字符串的长度
	    String base = "abcdefghijklmnopqrstuvwxyz0123456789";   
	    Random random = new Random();   
	    StringBuffer sb = new StringBuffer();   
	    for (int i = 0; i < length; i++) {   
	        int number = random.nextInt(base.length());   
	        sb.append(base.charAt(number));   
	    }   
	    return sb.toString();   
	 } 

	// SHA1签名生成
	public static String sha1(String str){
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("SHA-1");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		md.update(str.getBytes());
		byte[] digest = md.digest();

		StringBuffer hexstr = new StringBuffer();
		String shaHex = "";
		for (int i = 0; i < digest.length; i++) {
			shaHex = Integer.toHexString(digest[i] & 0xFF);
			if (shaHex.length() < 2) {
				hexstr.append(0);
			}
			hexstr.append(shaHex);
		}
		return hexstr.toString();
		
	}
	
	/**
	 * 首字母大写
	 */
    public static String captureName(String name) {
   //     name = name.substring(0, 1).toUpperCase() + name.substring(1);
//        return  name;
        char[] cs=name.toCharArray();
        cs[0]-=32;
        return String.valueOf(cs);
        
    }
}
