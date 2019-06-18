package com.gps.common.util;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 在此类中添加与日期操作有关的工具函数 . 本类不可实例化 ,所有方法为静态 ,所有属性为静态常量
 * 
 * @author 王平 2008.09.24
 */
public class MathUtil {
	private MathUtil() {

	}

	/**
	 * 将传入的字符串转成int型数据 . 遇到任何错误返回0
	 * 
	 * @param str
	 *            待解析的字符串
	 * @return 解析结果
	 */
	public static int parseInt0(String str) {
		return parseInt(str, 0);
	}

	/**
	 * 将传入的字符串转成int型数据 . 遇到任何错误返回replaceWith
	 * 
	 * @param str
	 *            待解析的字符串
	 * @param defaultValue
	 *            遇到错误时的替换数字 .
	 * @return 解析结果
	 */
	public static int parseInt(String str, int defaultValue) {
		try {
			defaultValue = Integer.parseInt(str);
		} catch (Exception e) {
		}
		return defaultValue;
	}

	/**
	 * 将传入的BigDecimal转成int型数据 . 遇到任何错误返回0
	 * 
	 * @param dec
	 * @return 解析结果
	 */
	public static int parseInt(BigDecimal dec) {
		if (dec == null)
			return 0;
		else
			return dec.intValue();
	}

	/**
	 * 将传入的BigDecimal转成double型数据 . 遇到任何错误返回0
	 * 
	 * @param dec
	 * @return 解析结果
	 */
	public static double parseDbl(BigDecimal dec) {
		if (dec == null)
			return 0;
		else
			return dec.doubleValue();
	}

	public static String formatDoubleToString(double dec) {

		String number = "0";

		try {
			DecimalFormat myformat1 = new DecimalFormat("0.00");// 使用系统默认的格式
			number = myformat1.format(dec);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return number;
	}

	/**
	 * 将传入的字符串转成int型数据 . 遇到任何错误返回0
	 * 
	 * @param str
	 *            待解析的字符串
	 * @return 解析结果
	 */
	public static int parseInt(String str) {
		return parseInt(str, 0);
	}

	/**
	 * 将传入的字符串转成double型数据 . 遇到任何错误返回0
	 * 
	 * @param str
	 *            待解析的字符串
	 * @return 解析结果
	 */
	public static double parseDbl0(String str) {
		return parseDbl(str, 0);
	}

	/**
	 * 将传入的字符串转成double型数据 . 遇到任何错误返回0
	 * 
	 * @param str
	 *            待解析的字符串
	 * @return 解析结果
	 */
	public static double parseDbl(String str) {
		return parseDbl(str, 0);
	}

	/**
	 * 将传入的字符串转成double型数据 . 遇到任何错误返回replaceWith
	 * 
	 * @param str
	 *            待解析的字符串
	 * @param defaultValue
	 *            遇到错误时的替换数字 .
	 * @return 解析结果
	 */
	public static double parseDbl(String str, double defaultValue) {
		try {
			defaultValue = Double.parseDouble(str);
		} catch (Exception e) {
		}
		return defaultValue;
	}

	/**
	 * 获取传入数字的字符串形式 , 如果是0则返回&nbsp;
	 * 
	 * @param dbl
	 *            待转化数字
	 * @return 转化结果
	 */
	public static String toStr0Nbsp(double dbl) {
		return toStr(dbl, 0, "&nbsp;");
	}

	/**
	 * 将参数dbl转成字符串 , 当dbl==dbl2时 ,返回 replaceWith
	 * 
	 * @param dbl
	 *            待转化的数字
	 * @param dbl2
	 *            需要过滤的数字
	 * @param defaultValue
	 *            用于替换被过滤数字的字符串
	 * @return 转化结果
	 */
	public static String toStr(double dbl, double dbl2, String defaultValue) {
		return dbl == dbl2 ? defaultValue : String.valueOf(dbl);
	}

	/**
	 * 返回保留n位小数的形式 ,不足补0 四舍五入;
	 * 
	 * @param a
	 * @param n
	 * @return
	 */
	public static String cut(double a, int n) {
		if (n < 0)
			n = 0;
		java.math.BigDecimal dbl_num = new java.math.BigDecimal(a).setScale(n, java.math.BigDecimal.ROUND_HALF_UP);
		return String.valueOf(dbl_num);
	}

	/**
	 * 返回保留n位小数的形式 ,不足补0 四舍五入;
	 * 
	 * @param a
	 * @param n
	 * @return
	 */
	public static String cut(java.math.BigDecimal a, int n) {
		if (n < 0)
			n = 0;
		if (a == null)
			a = java.math.BigDecimal.ZERO;
		java.math.BigDecimal dbl_num = a.setScale(n, java.math.BigDecimal.ROUND_HALF_UP);
		return String.valueOf(dbl_num);
	}

	/**
	 * 返回保留n位小数的形式 ,不足补0 四舍五入;
	 * 
	 * @param a
	 * @param n
	 * @return
	 */
	public static String cut(String a, int n) {
		if (n < 0)
			n = 0;
		double tem = parseDbl(a);
		java.math.BigDecimal dbl_num = new java.math.BigDecimal(tem).setScale(n, java.math.BigDecimal.ROUND_HALF_UP);
		return String.valueOf(dbl_num);
	}

	/**
	 * 判断传入的字符串是不是个数字;是就返回true
	 * 
	 * @author wangp
	 * @since 2008.12.16
	 * @param str
	 * @return
	 */
	public static boolean isNum(String str) {
		try {
			Double.parseDouble(str);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}

	public static float parseFloat(String str) {
		return parseFloat(str, 0);
	}

	public static float parseFloat(String str, float b) {
		try {
			return Float.parseFloat(str);
		} catch (Exception e) {
			return b;
		}
	}

	/**
	 * 将传入的BigDecimal转成float型数据 . 遇到任何错误返回0
	 * 
	 * @param dec
	 * @return 解析结果
	 */
	public static float parseFloat(BigDecimal dec) {
		if (dec == null)
			return 0F;
		else
			return dec.floatValue();
	}

	/**
	 * 取得值等于传入数字的Bigdecimal对象 ,传入null或""返回null
	 * 
	 * @author wangp
	 * @since 2009.04.30
	 * @param parameter
	 * @return
	 */
	public static BigDecimal getBigDecimal(String parameter) {
		BigDecimal res = null;
		if (!StringUtil.isEmpty(parameter))
			res = new BigDecimal(parameter);
		return res;
	}

	/**
	 * 取得值等于传入数字的Bigdecimal对象 ,传入null或""返回null
	 * 
	 * @author wangp
	 * @since 2009.04.30
	 * @param parameter
	 * @return
	 */
	public static BigDecimal getBigDecimalZero(String parameter) {
		BigDecimal res = new BigDecimal(0);
		if (!StringUtil.isEmpty(parameter))
			res = new BigDecimal(parameter);
		return res;
	}

	/**
	 * 取得值等于传入数字的Bigdecimal对象 ,传入null或""返回null
	 * 
	 * @author wangp
	 * @since 2009.04.30
	 * @param parameter
	 * @return
	 */
	public static BigDecimal getBigDecimalNull(BigDecimal dec) {
		if (dec == null)
			return new BigDecimal(0);
		else
			return dec;
	}

	/**
	 * 取得值等于传入数字的Bigdecimal对象 ,传入null或""返回值==a的Bigdecimal对象
	 * 
	 * @author wangp
	 * @since 2009.04.30
	 * @param parameter
	 * @return
	 */
	public static BigDecimal getBigDecimal(String parameter, double a) {
		BigDecimal res = null;
		if (!StringUtil.isEmpty(parameter))
			res = new BigDecimal(parameter);
		return res != null ? res : BigDecimal.valueOf(a);
	}

	/**
	 * 遇到错误返回0L
	 * 
	 * @author 王平
	 * @since 2009.04.30
	 * @param str
	 * @return
	 */
	public static long parseLong(String str) {
		return parseLong(str, 0l);
	}

	/**
	 * 遇到错误返回defaultValue
	 * 
	 * @author 王平
	 * @since 2009.04.30
	 * @param str
	 * @return
	 */
	public static long parseLong(String str, long defaultValue) {
		try {
			defaultValue = Long.parseLong(str);
		} catch (Exception e) {
		}
		return defaultValue;
	}

	/**
	 * 将传入的BigDecimal转成long型数据 . 遇到任何错误返回0
	 * 
	 * @param dec
	 * @return 解析结果
	 */
	public static long parseLong(BigDecimal dec) {
		if (dec == null)
			return 0L;
		else
			return dec.longValue();
	}

	/**
	 * 提供精确的小数位四舍五入处理.
	 * 
	 * @author xiachagnsong
	 * @param v
	 *            需要四舍五入的数字
	 * @param scale
	 *            小数点后保留几位
	 */
	public static double round(double v, int scale) {
		if (scale < 0) {
			throw new IllegalArgumentException("The scale must be a positive integer or zero");
		}
		BigDecimal b = new BigDecimal(v);
		return b.setScale(scale, BigDecimal.ROUND_HALF_UP).doubleValue();
	}

	/**
	 * 全角转半角
	 * 
	 * @param input
	 * @return
	 */
	public static String ToDBC(String input) {
		String returnString = "";
		if (StringUtil.isEmpty(input)) {
			return "";
		}
		char c[] = input.toCharArray();
		if (c != null && c.length > 0) {
			for (int i = 0; i < c.length; i++) {
				if (c[i] == '\u3000') {
					c[i] = '	';
				} else if (c[i] > '\uFF00' && c[i] < '\uFF5F') {
					c[i] = (char) (c[i] - 65248);

				}
			}
			returnString = new String(c);
		}
		return returnString;
	}

	/**
	 * 半角转全角
	 * 
	 * @param input
	 *            String.
	 * @return 全角字符串.
	 */
	public static String ToSBC(String input) {
		char c[] = input.toCharArray();
		if (c != null && c.length > 0) {
			for (int i = 0; i < c.length; i++) {
				if (c[i] == ' ') {
					c[i] = '\u3000';
				} else if (c[i] < '\177') {
					c[i] = (char) (c[i] + 65248);
				}
			}
		}
		return new String(c);
	}

	/**
	 * 根据比例算出具体的值 例：比例为1：5，true，data=1,那么结果是：5 比例为1：5，false，data=5,那么结果是：1
	 * 
	 * @param rate
	 * @param isFirst
	 * @param data
	 * @return
	 */
	public static int rateMultiInt(String rate, boolean isFirst, BigDecimal data) {
		BigDecimal res = new BigDecimal(0);
		rate = StringUtil.clear(ToDBC(rate));
		try {
			Pattern p = Pattern.compile("\\d{1}:\\d{1}");// 定义整则表达式
			Matcher m = p.matcher(rate);
			if (m.matches()) {
				String[] arr_rate = rate.split(":");
				BigDecimal b1 = new BigDecimal(arr_rate[0]);
				BigDecimal b2 = new BigDecimal(arr_rate[1]);
				if (isFirst) {
					// res =
					// b2.multiply(getBigDecimalNull(data)).divide(b1).setScale(Constants.newScale_0,
					// Constants.roundingMode);
				} else {
					// res =
					// b1.multiply(getBigDecimalNull(data)).divide(b2).setScale(Constants,
					// Constants.roundingMode);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return parseInt(res);
	}

	public static void main(String[] args) {
		System.out.println(rateMultiInt("1：5", true, new BigDecimal(1)));
		System.out.println(rateMultiInt("1: 5", true, new BigDecimal(1)));
	}
}
