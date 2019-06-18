package com.gps.common.util;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Pattern;

/**
 * 在此类中添加与日期操作有关的工具函数 . 本类不可实例化 ,所有方法为静态 ,所有属性为静态常量 
 * @author 王平 2008.09.24
 */
public class DateUtil {
	/**
	 * 默认的日期格式 . 
	 */
	public static final String DEFAULT_REGEX = "yyyy-MM-dd";
	/**
	 * TIME_FIELD : 年
	 */
	public static final int YEAR = Calendar.YEAR;
	/**
	 * TIME_FIELD : 月
	 */
	public static final int MONTH = Calendar.MONTH;
	/**
	 * TIME_FIELD : 日
	 */
	public static final int DATE = Calendar.DATE ;
	/**
	 * TIME_FIELD : 小时
	 */
	public static final int HOUR = Calendar.HOUR;
	/**
	 * TIME_FIELD : 分钟
	 */
	public static final int MINUTE = Calendar.MINUTE;
	/**
	 * TIME_FIELD : 秒 
	 */
	public static final int SECOND = Calendar.SECOND;
	/**
	 * TIME_FIELD : 毫秒
	 */
	public static final int MILLISECOND = Calendar.MILLISECOND;
	/**
	 * 默认的DateFormat 实例
	 */
	public static final DateFormat DEFAULT_FORMAT = new SimpleDateFormat(DEFAULT_REGEX);
	
	
	/**
	 * date:年月日
	 */
	private static java.text.SimpleDateFormat dateformat = new java.text.SimpleDateFormat(
	"yyyy-MM-dd");
	
	/**
	 * time:时分秒
	 */
	private static java.text.SimpleDateFormat timeformat = new java.text.SimpleDateFormat(
	"hh-mm-ss");
	
	/**
	 * datetime年月日 时分秒
	 */
	private static java.text.SimpleDateFormat datetimeformat = new java.text.SimpleDateFormat(
	"yyyy-MM-dd hh:mm:ss");
	
	static {
		DEFAULT_FORMAT.setLenient(false);
	}
	private DateUtil(){
		
	}
	/**
	 * 时间对象格式化成String , 
	 * @param date 待解析时间对象
	 * @return 传入时间的默认格式的字符串形式 ,直接解析 ,遇到任何错误返回"&nbsp;"
	 */
	public static String formatNbsp(java.util.Date date){
		return formatWith(date ,"&nbsp;");
	}
	/**
	 * 时间对象格式化成String , 
	 * @param date 待解析时间对象
	 * @return 传入时间的默认格式的字符串形式 ,直接解析 ,遇到任何错误返回"&nbsp;"
	 */
	public static String formatNbsp(java.util.Date date, String regex){
		return formatWith(date ,regex ,"&nbsp;");
	}
	/**
	 * 时间对象格式化成String .
	 * @param date 待解析时间对象
	 * @return 传入时间的默认格式的字符串形式 ,直接解析 ,遇到任何错误返回null
	 */
	public static String formatNull(java.util.Date date){
		return formatWith(date ,null);
	}
	/**
	 * 时间对象格式化成String .
	 * @param date 待解析时间对象
	 * @return 传入时间的默认格式的字符串形式 ,直接解析 ,遇到任何错误返回""
	 */
	public static String formatMaskNull(java.util.Date date){
		return formatWith(date ,"");
	}
	/**
	 * 时间对象格式化成String .
	 * @param date 待解析时间对象
	 * @return 传入时间的默认格式的字符串形式 ,直接解析 ,遇到任何错误返回""
	 */
	public static String formatMaskNull(java.util.Date date ,String regex){
		return formatWith(date ,regex ,"");
	}
	/**
	 * 时间对象格式化成String .
	 * @param date 待解析时间对象
	 * @param replaceWith 解析遇到错误时需要返回的默认值
	 * @return 传入时间的默认格式的字符串形式 ,直接解析 ,遇到任何错误返回replaceWith
	 */
	public static String formatWith(java.util.Date date, String defaultValue){
		try{
			return DEFAULT_FORMAT.format(date);
		}catch(Exception e){
			return defaultValue;
		}
	}
	/**
	 * 时间对象格式化成String .
	 * @param date 待解析时间对象
	 * @param replaceWith 解析遇到错误时需要返回的默认值
	 * @return 传入时间的默认格式的字符串形式 ,直接解析 ,遇到任何错误返回replaceWith
	 */
	public static String formatWith(java.util.Date date ,String regex , String defaultValue){
		try{
			return format(date,regex);
		}catch(Exception e){
			return defaultValue;
		}
	}
	/**
	 * 时间对象格式化成String ,等同于java.text.DateFormat.format();
	 * @param date 需要格式化的时间对象
	 * @return 转化结果 
	 */
	public static String format(java.util.Date date){
		return DEFAULT_FORMAT.format(date);
	}
	/**
	 * 时间对象格式化成String ,等同于java.text.DateFormat.format();
	 * @param date 需要格式化的时间对象
	 * @return 转化结果 
	 */
	public static String getDateString(java.sql.Timestamp stamp){
		return dateformat.format(stamp);
	}
	/**
	 * 时间对象格式化成String ,等同于java.text.SimpleDateFormat.format();
	 * @param date 需要格式化的时间对象
	 * @param regex 定义格式的字符串
	 * @return 转化结果
	 */
	public static String format(java.util.Date date ,String regex){
		DateFormat fmt = new SimpleDateFormat(regex);
		fmt.setLenient(false);
		return fmt.format(date);
	}
	/**
	 * 在指定的时间段上增加一定数值
	 * @param date 原来的时间
	 * @param TIME_FIELD 参照本类中常量定义内容.
	 * @param num 想要增加的数值
	 * @return 增加后的时间
	 */
	public static java.util.Date add(java.util.Date date,int TIME_FIELD ,int num){
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(TIME_FIELD, num);
		return cal.getTime() ;
	}
	/**
	 * 增加整年
	 * @author 王平 
	 * @param date
	 * @param years
	 * @return
	 */
	public static java.util.Date addYears(java.util.Date date,int years){
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.YEAR, years);
		return cal.getTime() ;
	}
	/**
	 * 解析字符串成时间 ,遇到错误返回null不抛异常
	 * @param source
	 * @return 解析结果
	 */
	public static java.util.Date parse(String source){
		try{
			return DEFAULT_FORMAT.parse(source);
		}catch(Exception e){
			return null;
		}
	}
	/**
	 * 解析字符串成时间 ,遇到错误返回null不抛异常
	 * @param source
	 * @param 格式表达式
	 * @return 解析结果
	 */
	public static java.util.Date parse(String source ,String regex){
		try{
			DateFormat fmt = new SimpleDateFormat(regex);
			fmt.setLenient(false);
			return fmt.parse(source);
		}catch(Exception e){
			return null;
		}
	}
	/**
	 * 取得当前时间的Timestamp对象 ;
	 * @return
	 */
	public static java.sql.Timestamp getTimestamp(){
		return new java.sql.Timestamp(System.currentTimeMillis());
	}
	/**
	 * 取得time时间的Timestamp对象 ;
	 * @return
	 */
	public static java.sql.Timestamp getTimestamp(String time ,String pattern){
		try{
			return getTimestampEx(time ,pattern);
		} catch(Exception e){
			return null;
		}
	}
    /**
	 * 解析字符串成时间 ,遇到错误抛异常
	 * @param source
	 * @param 格式表达式
	 * @return 解析结果
	 * @throws ParseException 
	 */
	public static java.util.Date parseEx(String source ,String regex) throws ParseException{
			DateFormat fmt = new SimpleDateFormat(regex); 
			fmt.setLenient(false);
			return fmt.parse(source);
	}
	/**
	 * 取得time时间的Timestamp对象 ;
	 * @return
	 * @throws ParseException 
	 */
	public static java.sql.Timestamp getTimestampEx(String time ,String pattern) throws ParseException{
		return new java.sql.Timestamp(parseEx(time ,pattern).getTime());
	}
	/**
	 * 尝试解析时间字符串 ,if failed return null;
	 * @author wangp
	 * @since 2008.12.20
	 * @param time
	 * @return
	 */
	public static Timestamp parseTimestamp(String time) {
		Timestamp stamp = null;
		if(time==null||"".equals(time))
			return null;
		Pattern p3 = Pattern.compile("\\b\\d{2}[.-]\\d{1,2}([.-]\\d{1,2}){0,1}\\b");
		if(p3.matcher(time).matches()){
			time = (time.charAt(0)=='1'||time.charAt(0)=='0'?"20":"19")+time;
		}
		
		stamp = DateUtil.getTimestamp(time, "yyyy-MM-dd");
		if(stamp==null)
			stamp = DateUtil.getTimestamp(time, "yyyy.MM.dd");
		if(stamp == null)
			stamp = DateUtil.getTimestamp(time, "yyyy-MM");
		if(stamp == null)
			stamp = DateUtil.getTimestamp(time, "yyyy.MM");
		if(stamp == null)
			stamp = DateUtil.getTimestamp(time, "yyyy-MM-dd");
		if(stamp == null)
			stamp = DateUtil.getTimestamp(time, "yyyy.MM.dd");
		if(stamp == null)
			stamp = DateUtil.getTimestamp(time, "yyyy-MM.dd");
		if(stamp == null)
			stamp = DateUtil.getTimestamp(time, "yyyy.MM-dd");
		if(stamp == null)
			stamp = DateUtil.getTimestamp(time, "yyyyMMdd");
		if(stamp == null)
			stamp = DateUtil.getTimestamp(time, "yyyyMM");
		if(stamp == null)
			stamp = DateUtil.getTimestamp(time, "yyyy");
		if(stamp == null)
			stamp = DateUtil.getTimestamp(time, "yyyy年");
		return stamp;
	}
	
	
	 /**
     * 返回指定年份中指定月份的天数
     * @author xiachangsong
     * @param 年份year
     * @param 月份month
     * @return 指定月的总天数
     */
    public static String getMonthLastDay(int year,int month){
		int[][] day={{0,30,28,31,30,31,30,31,31,30,31,30,31},
						{0,31,29,31,30,31,30,31,31,30,31,30,31}};
		if(year%4==0 && year%100!=0 || year%400==0){
			return day[1][month]+"";
		}
		else{
			return day[0][month]+"";
		}
	}
    
    
    /**
	 * 将 TimeStamp 对象转化成"yyyy-MM-dd"格式字符串
	 * @author 张懿勉
	 * @since 2008-11-28
	 * @param t
	 * @return
	 */
	public static String toDateString(Timestamp t){
		if( t== null)
			return "";
		else
			return dateformat.format(t);
	}
	
	/**
	 * 将 Date 对象转化成"yyyy-MM-dd"格式字符串
	 * @author 张懿勉
	 * @since 2008-11-28
	 * @param t
	 * @return
	 */
	public static String toDateString(Date t){
		if( t== null)
			return "";
		else
			return dateformat.format(t);
	}
	
	/**
	 * 将 TimeStamp 对象转化成"hh-mm-ss"格式字符串
	 * @author 张懿勉
	 * @since 2008-11-28
	 * @param t
	 * @return
	 */
	public static String toTimeString(Timestamp t){
		if( t== null)
			return "";
		else
			return timeformat.format(t);
	}
	
	/**
	 * 将 Date 对象转化成"hh-mm-ss"格式字符串
	 * @author 张懿勉
	 * @since 2008-11-28
	 * @param t
	 * @return
	 */
	public static String toTimeString(Date t){
		if( t== null)
			return "";
		else
			return timeformat.format(t);
	}
	
	/**
	 * 将 TimeStamp 对象转化为"yyyy-MM-dd hh-mm-ss"格式字符串
	 * @author 张懿勉
	 * @since 2008-11-28
	 * @param t
	 * @return
	 */
	public static String toDateTimeString(Timestamp t){
		if( t== null)
			return "";
		else
			return datetimeformat.format(t);
	}
	
	/**
	 * 将 Date 对象转化为"yyyy-MM-dd hh-mm-ss"格式字符串
	 * @author 张懿勉
	 * @since 2008-11-28
	 * @param t
	 * @return
	 */
	public static String toDateTimeString(Date t){
		if( t== null)
			return "";
		else
			return datetimeformat.format(t);
	}
	
	/**
	 * 将 String 对象转换为 Timestamp 对象
	 * 格式为"yyyy-MM-dd" 或 "yyyy-MM-dd hh-mm-ss"
	 * 已经处理为String 为null的情况
	 * @author 张懿勉
	 * @since 2008-11-28
	 * @param s
	 * @return
	 */
	public static Timestamp toTimestamp(String s){
		if( s==null)
			return null;
		else if( s.length()==10)
			return Timestamp.valueOf(s+" 00:00:00");
		else if( s.length()==19)
			return Timestamp.valueOf(s);
		else 
			return null;
	}

	/**
	 * 返回系统当前时间的 Timestamp 对象
	 * @author 张懿勉
	 * @since 2008-11-28
	 * @return
	 */
	public static Timestamp getCurrentTimestamp(){
		return new Timestamp(System.currentTimeMillis());
	}
	
	/**
	 * 获得当前年月
	 * @author 张懿勉
	 * @return
	 */
	public static String getCurrentYearMonth(){
		return getCurrentYear()+getCurrentMonth();
	}
	
	/**
	 * 返回系统当前时间的 Date 对象
	 * @author 张懿勉
	 * @since 2008-11-28
	 * @return
	 */
	public static Date getCurrentDate(){
		return new Date(System.currentTimeMillis());	
	}
	
	/**
	 * 获得当前日期的年份
	 */
	public static String getCurrentYear(){
		return getCurrentYear(getCurrentDate());
	}
	
	/**
	 * 返回当前的月份
	 */
	public static String getCurrentMonth(){
		return getCurrentMonth(getCurrentDate());
	}
	
	/**
	 * 根据Date 返回当前的年份
	 * @return
	 */
	public static String getCurrentMonth(Date date){
		return toDateString(date).substring(5, 7);
	}
	
	/**
	 * 根据Date 返回当前的年份
	 * @return
	 */
	public static String getCurrentMonth(Timestamp date){
		return toDateString(date).substring(5, 7);
	}
	
	/**
	 * 根据Date 返回当前的年份
	 * @return
	 */
	public static String getCurrentYear(Date date){
		return toDateString(date).substring(0, 4);
	}
	
	/**
	 * 根据Date 返回当前的年份
	 * @return
	 */
	public static String getCurrentYear(Timestamp date){
		return toDateString(date).substring(0, 4);
	}
	
	public static void main(String[] args) {
		System.out.println(formatNull(parse("1972年92月03","yyyy年MM月dd")));
		try {
				String date = "19729203";
	           // 如果输入日期不是8位的,判定为false. 
	            int year = Integer.parseInt(date.substring(0, 4));
	            int month = Integer.parseInt(date.substring(4, 6)) - 1;
	            int day = Integer.parseInt(date.substring(6));
	            Calendar calendar = Calendar.getInstance();
	            // 当 Calendar 处于 non-lenient 模式时，如果其日历字段中存在任何不一致性，它都会抛出一个异常。
	            calendar.setLenient(false);
	            calendar.set(Calendar.YEAR, year);
	            calendar.set(Calendar.MONTH, month);
	            calendar.set(Calendar.DATE, day);
	           // 如果日期错误,执行该语句,必定抛出异常.
	            calendar.get(Calendar.YEAR);
	            toDateString(getCurrentTimestamp());
	            System.out.println(format(calendar.getTime()));
		} catch (IllegalArgumentException e) {
	            e.printStackTrace();
	        }
	        
	       
	}
	
}
