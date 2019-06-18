package com.gps.common.util;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 
 * 提供与字符串操作有关的通用方法 ,全部方法都是静态方法 ,全部变量都是静态常量 . 
 * @author 王平 . 2008.11.07
 *
 */

public class StringUtil {
	
	private static final String COLOR_RED = "#df0000";
	private StringUtil(){
		// TOINIT
	}
	public static String toUpperCase(String instr){
		return instr == null ? instr : instr.toUpperCase();
	}
	/**
	 * 过滤 ;当instr==null时返回长度为0的""; 
	 * <br> 与 nvl(...)系的区别在于只处理null ,不处理长度为0的"";
	 * @param instr
	 * @return
	 */
	public static String nvl2(String instr){
		return instr==null?"":instr;
	}
	/**
	 * 过滤 ;当instr==null时返回长度为0的""; 
	 * <br> 与 nvl(...)系的区别在于只处理null ,不处理长度为0的"";
	 * @param instr
	 * @return
	 */
	public static Object nvl2(Object instr){
		return instr==null?"":instr;
	}
	/**
	 * 过滤 ,把null和长度为0的""当成同一种情况处理;
	 * <br>当instr==null||"".equals(instr)时返回defaultValue ;其它情况返回 instr
	 * @param instr
	 * @param defaultValue
	 * @return
	 */
	public static String nvl(String instr ,String defaultValue){
		return instr == null || "".equals(instr) ? defaultValue : instr ;
	}
	/**
	 * 过滤 ; 当instr==null||instr.equals(tagstr)时返回defaultValue ;其它情况返回 instr
	 * <br> 与 nvl(...)系的区别在于只处理null ,不处理长度为0的"";
	 * @param instr
	 * @param tagstr
	 * @param defaultValue
	 * @return
	 */
	public static String nvl2(String instr ,String tagstr ,String defaultValue){
		return instr == null || instr.equals(tagstr) ? defaultValue : instr ;
	}
	
	
	/**
	 * 过滤 ,把null和长度为0的""当成同一种情况处理;
	 * <br>当instr==null||"".equals(instr)时返回defaultValue ;其它情况返回 instr
	 * @param instr
	 * @param defaultValue
	 * @return
	 */
	public static String nvl(Object instr ,String defaultValue){
		return instr == null || "".equals(instr.toString()) ? defaultValue : instr.toString() ;
	}
	/**
	 * 过滤 ,instr==null时返回defaultvalue;
	 * <br>把null和长度为0的""当成同一种情况处理;
	 * @param instr
	 * @param defaultValue
	 * @return
	 */
	public static Object nvl(Object instr ,Object defaultValue){
		return instr == null || "".equals(instr.toString()) ? defaultValue : instr ;
	}
	/**
	 * 不会抛NullPointerException 的trim() 
	 * <br> 传入null会返回null
	 * @param str
	 * @return
	 */
	public static String trim(String str){
			if(str==null)
				return str;
		return str.trim();
	}
	/**
	 * backColorForChange 为合同变更页面提供的提示背景色 ;
	 * <br>提供给HTML页面 ,如果obj==null&&obj1==null或者是obj.equals(obj1)那么会返回一段 style='background-color:color;' 代码 ;否则返回'';
	 * <br> 如果传入的color==null那么返回红色背景 ;
	 * @param obj
	 * @param obj1
	 * @return
	 */
	public static String backColor4C(String obj ,String obj1 ,String color){
		if(obj==null)
			return back4CPro(obj1 == null ,color == null ? COLOR_RED : color);
		return back4CPro(obj.equals(obj1) ,color == null ? COLOR_RED : color);
	}
	/**
	 * backColorForChange 为合同变更页面提供的提示背景色 ;
	 * <br>提供给HTML页面 ,如果obj==null&&obj1==null或者是obj.equals(obj1)那么会返回一段 style='background-color:color;' 代码 ;否则返回'';
	 * <br> 如果传入的color==null那么返回红色背景 ;
	 * @param obj
	 * @param obj1
	 * @return
	 */
	public static String backColor4C(Date obj ,Date obj1 ,String color){
		if(obj==null)
			return back4CPro(obj1 == null ,color == null ? COLOR_RED : color);
		if(obj1==null)
			return back4CPro(obj == null ,color == null ? COLOR_RED : color);
		return back4CPro(DateUtil.format(obj).equals(DateUtil.format(obj1)) ,color == null ? COLOR_RED : color);
	}
	/**
	 * backColorForChange 为合同变更页面提供的提示背景色 ;
	 * <br>提供给HTML页面 ,如果obj==null&&obj1==null或者是obj.equals(obj1)那么会返回一段 style='background-color:color;' 代码 ;否则返回'';
	 * <br> 如果传入的color==null那么返回红色背景 ;
	 * @param obj
	 * @param obj1
	 * @return
	 */
	public static String backColor4C(BigDecimal obj ,BigDecimal obj1 ,String color){
		if(obj==null)
			return back4CPro(obj1 == null ,color == null ? COLOR_RED : color);
		if(obj1==null)
			return back4CPro(obj == null ,color == null ? COLOR_RED : color);
		return backColor4C(obj.doubleValue() ,obj1.doubleValue() ,color);
	}
	/**
	 * backColorForChange 为合同变更页面提供的提示背景色 ;
	 * <br>提供给HTML页面 ,如果obj==null&&obj1==null或者是obj.equals(obj1)那么会返回一段 style='background-color:color;' 代码 ;否则返回'';
	 * <br> 如果传入的color==null那么返回红色背景 ;
	 * @param obj
	 * @param obj1
	 * @return
	 */
	public static String backColor4C(double obj ,double obj1 ,String color){
		return back4CPro(obj==obj1 ,color == null ? COLOR_RED : color);
	}
	public static String back4CPro(boolean flag ,String color){
		return flag == true ?"" : " style='color:"+color+"' ";
	}
	/**
	 * 是否 null 或者长度为0的字符串
	 * @author wangp
	 * @since 2008.12.02
	 * @param str
	 * @return
	 */
	public static boolean isEmpty(String str){
		return str==null||"".equals(str);
	}
	public static String apadLeft(double a ,int b ,int len){
		return apadLeft(String.valueOf(a) ,String.valueOf(b) ,len);
	}
	public static String apadRight(double a ,int b ,int len){
		return apadRight(String.valueOf(a) ,String.valueOf(b) ,len);
	}
	public static String apadLeft(String str ,String str2 ,int len){
		if(str==null||str.length()==len||str2==null)
			return str;
		if(str.length() > len)
			return str.substring(str.length()-len ,len);
		return apadpro(str ,str2 ,len ,true);
	}
	public static String apadRight(String str ,String str2 ,int len){
		if(str==null||str.length()==len||str2==null)
			return str;
		if(str.length() > len)
			return str.substring(0 ,len);
		return apadpro(str ,str2 ,len ,false);
	}
	private static String apadpro(String a ,String b ,int len ,boolean appendleft){
		int f = len - a.length();
		for(int i=0;i<f;i++){
			a = appendleft == true ? b+a : a+b;
		}
		return a;
	}
	/**
	 * 把数组里的元素用tg连接后返回 ,如果tg==null会被替换成""
	 * @author 王平
	 * @since 2009.01.08
	 * @param res 9,2,2,2 ,,,,,
	 * @param tg
	 * @return
	 */
	public static String concat(String[] res ,String tg) {
		StringBuffer sb = new StringBuffer();
		if(res == null)
			return null;
		tg = nvl2(tg);
		for(int i=0;i<res.length;i++){
			sb.append(res[i]).append(tg);
		}
		if(sb.length()>0)
			sb.deleteCharAt(sb.length()-1);
		return sb.toString();
	}
	/**
	 * 把数组里的元素用tg连接后返回，遇到数组中null元素时忽略 ,如果tg==null会被替换成"" ，
	 * @author 王平
	 * @since 2009.01.08
	 * @param res 9,2,2,2 ,,,,,
	 * @param tg
	 * @return
	 */
	public static String concatMaskNull(String[] res ,String tg) {
		StringBuffer sb = new StringBuffer();
		if(res == null)
			return null;
		for(int i=0;i<res.length;i++){
			if(res[i]==null)
				continue;
			sb.append(res[i]).append(nvl2(tg));
		}
		if(sb.length()>0)
			sb.deleteCharAt(sb.length()-1);
		return sb.toString();
	}
	/**
	 * 比较 str1 和 str2 如果都是 null 或者 str1.equals(str2) 返回 true 表示一样 ;
	 * @author wangp
	 * @since 2009.01.10
	 * @param str1
	 * @param str2
	 * @return
	 */
	public static boolean compStr(String str1, String str2) {
		if(str1 == null && str2 == null)
			return true ;
		if(str1 != null && str1.equals(str2))
			return true ;
		return false;
	}
	/**
	 * 比较obj1 和 obj2 如果都是null或者obj1的数值内容==obj2的数值内容 ,或者obj1代表的时间==obj2代表的时间 返回true ;表示逻辑"一样"
	 * @author 王平
	 * @since 2009.01.10
	 * @param obj1
	 * @param obj2
	 * @return
	 */
	public static boolean compStr(Object obj1, Object obj2) {
		if(obj1 == obj2)
			return true;
		if(obj1 == null&& obj2 == null)
			return true ;
		if(obj1 != null && obj1.equals(obj2))
			return true ;
		if(obj1 instanceof java.math.BigDecimal && obj2 instanceof java.math.BigDecimal)
			return ((java.math.BigDecimal)obj1).compareTo((java.math.BigDecimal)obj2) == 0;
		return false;
	}
	/**
	 * 取内容的toString
	 * @author wangp
	 * @since 2009.01.10
	 * @param obj1
	 * @return
	 */
	public static String toString(Object obj1) {
		if(obj1 == null)
			return null;
		if(obj1 instanceof java.util.Date)
			return DateUtil.format((java.util.Date)obj1);
		if(obj1 instanceof java.math.BigDecimal)
			return String.valueOf(((java.math.BigDecimal)obj1).doubleValue());
		return obj1.toString();
	}

	/**
	 * 转小写
	 * @author wangp
	 * @since 2009.01.10
	 * @param str
	 * @return
	 */
	public static String toLowerCase(String str) {
		return str==null?null:str.toLowerCase();
	}
	/**
	 * 首字母大写 ,其余不变
	 * @author wangp
	 * @since 2009.01.10
	 * @param string
	 * @return
	 */
	public static String toUpperCaseFirst(String str) {
		if(str == null)
			return null;
		if(str.length()==0)
			return str;
		String pre = String.valueOf(str.charAt(0));
		return str.replaceFirst(pre, pre.toUpperCase());
	}
	
	/**
	 * 首字母小写 ,其余不变
	 * @author wangp
	 * @since 2009.04.30
	 * @param string
	 * @return
	 */
	public static String toLowerCaseFirst(String str) {
		if(str == null)
			return null;
		if(str.length()==0)
			return str;
		String pre = String.valueOf(str.charAt(0));
		return str.replaceFirst(pre, pre.toLowerCase());
	}
	/**
	 * 清除字符串中所有的空格 ,传入null返回null
	 * @author wangp
	 * @since 2009.02.06
	 * @param str
	 * @return
	 */
	public static String clear(String str){
		return clear(str ," ");
	}
	/**
	 * 清除str中出现的所有str2字符序列 直到结果中再也找不出str2为止
	 * str2 == null时 返回str
	 * @author wangp
	 * @since 2009.02.06
	 * @param str 原始字符串
	 * @param str2 清除的目标
	 * @return
	 */
	public static String clear(String str ,String str2){
		if(str == null)
			return str ;
		if(str2 == null)
			return str ;
		String reg = "("+str2+")+";
		Pattern p = Pattern.compile(reg);
		Matcher m = null;
		while ((m = p.matcher(str)).find()){
			str = str.replaceAll(reg, "");
		}
		return str;
	}
	/**
	 * 从身份证号码中解析性别 
	 * @author wangp
	 * @since 2009.02.10
	 * @param cert
	 * @return
	 * @throws Exception 
	 */
	public static String getSexCert(String cert) throws Exception{
		if(!Verify(cert))
			throw new Exception("不是合法的身份证号码");
		cert = uptoeighteen(cert);
		int a = Integer.parseInt(cert.substring(16,17));
		String res = "男";
		if( a%2 == 0 )
			res = "女";
		return res;
	}
	/**
	 * 从身份证号码中解析生日
	 * @author wangp
	 * @since 2009.02.10
	 * @param cert
	 * @return
	 * @throws Exception 
	 */
	public static Date getBirthCert(String cert) throws Exception{
		if(!Verify(cert))
			throw new Exception("不是合法的身份证号码");
		cert = uptoeighteen(cert);
		return DateUtil.parse(cert.substring(6,14),"yyyyMMdd");
	}
	public static final int[] wi = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2,1}; 


	// verify digit 
	public static final String[] vi = {"1","0","X","9","8","7","6","5","4","3","2"}; 

	/**
	  * Description : 判断身份证号是否有效，支持15位、18位和新的带X身份证号格式
	  * @author kevin
	  * @since 2008-8-22
	  * @param str：字符串
	  * @param 
	  * @return boolean
	  * @throws Throwable
	 */
	public static boolean Verify(String idcard) { 
		if (idcard.length() == 15) { 
			idcard = uptoeighteen(idcard); 
		} 
		if (idcard.length() != 18) { 
			return false; 
		} 
		String verify = idcard.substring(17, 18).toUpperCase(); 
		String tmp = getVerify(idcard);
		if (verify.equals(tmp)&&DateUtil.parse(idcard.substring(6, 14), "yyyyMMdd")!=null) { 
			return true; 
		} 
		return false; 
	} 

	/**
	 * 获得身份证号的第十八位校验码 ,如果传入的参数不是18位则返回null
	 * @author wangp
	 * @since 2009.04.30
	 * @param eightcardid
	 * @return
	 */
	public static String getVerify(String eightcardid) { 
		int remaining = 0; 
		int ai = 0;
		if (eightcardid.length() == 18) { 
			eightcardid = eightcardid.substring(0, 17); 
		}
		if (eightcardid.length() == 17) { 
			int sum = 0; 
			for (int i = 0; i < 17; i++) { 
				String k = eightcardid.substring(i, i + 1); 
				ai = Integer.parseInt(k); 
				sum = sum + wi[i] *ai; 
			} 
			remaining = sum % 11; 
		} 

		return vi[remaining]; 
	} 

	/**
	 * 身份证号 15位 升 18 位
	 * @author wangp
	 * @since 2009.04.30
	 */ 
	public static String uptoeighteen(String cert) { 
		if(cert.length()==18)
			return cert.toUpperCase();
		if(cert.length()!=15)
			return cert;
		String eightcardid = cert.substring(0,6); 
		eightcardid = eightcardid + DateUtil.formatMaskNull(DateUtil.parse("19"+cert.substring(6,12),"yyyyMMdd"),"yyyyMMdd"); 
		eightcardid = eightcardid + cert.substring(12,15);
		eightcardid = eightcardid + getVerify(eightcardid); 
		return eightcardid; 
	}
	/**
	 * 将一个数组转换成id 为 如 1,2,3 或 '1','2','3'
	 * @author xiachangsong
	 * @param strArr 数组
	 * @param type  0,1数字 ，2字符
	 * @return
	 */
	public static String formatStrToIds(String [] strArr,int type){
		StringBuffer sb = new StringBuffer("");
		
		if(strArr==null || strArr.length <=0){
			if(type==2){
				sb.append("'-1'");
			}else{
				sb.append("-1");
			}
			return sb.toString();
		}
		
		for (int i = 0; i < strArr.length; i++) {
			if(type==2){
				if(i==0){
					sb.append("'").append(strArr[i]).append("'");
				}else{
					sb.append(",'").append(strArr[i]).append("'");
				}
			}else{
				if(i==0){
					sb.append(strArr[i]);
				}else{
					sb.append(",").append(strArr[i]);
				}
			}
		}		
		return sb.toString();
	}
	
	
	/**
	 * 将一个数组转换成id 为 如 1,2,3 或 '1','2','3'
	 * @author xiachangsong
	 * @param strArr 数组
	 * @param type  0,1数字 ，2字符
	 * @return
	 */
	public static String formatStrToIds(List strArr,int type){
		StringBuffer sb = new StringBuffer("");
		
		if(strArr==null || strArr.size() <=0){
			if(type==2){
				sb.append("'-1'");
			}else{
				sb.append("-1");
			}
			
			return sb.toString();
		}
		
		for (int i = 0; i < strArr.size(); i++) {
			if(type==2){
				if(i==0){
					sb.append("'").append(strArr.get(i)).append("'");
				}else{
					sb.append(",'").append(strArr.get(i)).append("'");
				}
			}else{
				if(i==0){
					sb.append(strArr.get(i));
				}else{
					sb.append(",").append(strArr.get(i));
				}
			}
		}		
		return sb.toString();
	}
	
	
	/**
	 * 返回当前年月的前几年与后几年的集合
	 * @param previous  前面几年
	 * @param after 后面几年
	 */
	public static ArrayList getYearList(int previous,int after){
		
		ArrayList<String> yearList = new ArrayList<String>();
		int year = MathUtil.parseInt(DateUtil.format(new Date(),"yyyy" )) ;
		
		for(int i= year-previous;i<= year+after;i++){
			yearList.add(String.valueOf(i));
		}
		return yearList;
	}
	/**
	 * 找到第一个没有左边a的b,返回它的位置 ,这个方法只能支持转义符
	 * @author wangp
	 * @since 2009-06-11
	 * @param sb
	 * @return
	 */
	public static int indexOfBBeforeA_X(CharSequence sb,String a,String b){
		Pattern pattern4indexOfEndCut = Pattern.compile("\\"+a+"|\\"+b);
		Matcher matcher4indexOfEndCut ;
		matcher4indexOfEndCut = pattern4indexOfEndCut.matcher(sb);
		int i = 0;
		int index = 0;
		int res = -1;
		String s = null;
		while(matcher4indexOfEndCut.find(index)){
			s = matcher4indexOfEndCut.group();
			index = matcher4indexOfEndCut.end();
			if(a.equals(s))
				i++;
			else 
				i--;
			if(i<0){
				res = index;
				break;
			}
		}
		return res;
	}
	
	/**
	 * 如果str的长度超过了c则取c-sub.length长度,然后拼上sub结尾
	 * @author wangp
	 * @since 2009.06.11 
	 * @param str
	 * @param c
	 * @param sub
	 * @return
	 */
	public static String suojin(String str,int c ,String sub){
		if(isEmpty(str))
			return str;
		if(str.length()<=c)
			return str;
		sub=nvl2(sub);
		c = c-sub.length();
		c = c > str.length()?0:c;
		str = str.substring(0,c);
		return str+sub;
	}
	
	/**
	 * 如果str的长度超过了12,取前9位然后拼上...
	 * @author wangp
	 * @since 2009.06.11 
	 * @param str
	 * @param c
	 * @param sub
	 * @return
	 */
	public static String suojin(String str){
		return suojin(str,12,"…");
	}
	
	/**
	 * 如果str的长度超过了length,取前length位然后拼上...
	 * @author yimian
	 * @since 2009.06.11 
	 * @param str
	 * @param length
	 * @return
	 */
	public static String suojin(String str,int length){
		return suojin(str,length,"…");
	}
	
	/**
	 * 取得字符串的长度 ，此方法的返回值总是与Oracle 10g中 可插入的字段长度值相同
	 * @author wangp
	 * @since 2009.06.15
	 * @param tmpStr
	 * @return
	 */
	public static int getData_length(String str) {
		if(isEmpty(str))
			return 0;
		int res = 0 ;
		for(int i=0;i<str.length();i++){
			if(str.charAt(i)<=255) 
				res += 1;
			else 
				res += 2;
		}
		return res;
	}
	public static String nvl(String a, String b,
			String c) {
		return isEmpty(a)?b:c;
	}
	
	/**
	 * 传入列序号(从0开始) ,返回用英文字母表示的序号(excel中的表示形式)
	 * @author wangp
	 * @since 2009.08.18
	 * @param index 从0开始
	 * @return
	 */
	public static String getExcelIndex(int index){
		String [] str = new String[]{"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
		int l = 0;
		String res = "";
		st: for(int i=0;i<26;i++){
			for(int j=0;j<26;j++,l++){
				if(l == index){
					res += str[j];
					break st;
				}
			}
			res=str[i];
		}
		return res;
	}
	/**
	 * 类似于String.substr ；不同在于传入的长度参数为oracle中的长度定义数
	 * @param data
	 * @param len
	 * @return
	 */
	public static String substr(String str, int len) {
		if(isEmpty(str))
			return str;
		int res = 0 ;
		int l = 0;
		for(int i=0;i<str.length();i++){
			if(str.charAt(i)<=255) 
				res += 1;
			else 
				res += 2;
			if(res > len )
				break;
			l ++ ;
		}
		return str.substring(0, l);
	}
	
	/**
	 * 通过对象和对象的属性获得属性值
	 * @param proName
	 * @param obj
	 * @return
	 */
	public static Object reflectByProperty(String proName,Object obj) {
		Object proValue = null;
		try {
//			System.out.println("proName:" + proName);
			Field  f = obj.getClass().getDeclaredField(proName.toLowerCase());
			f.setAccessible(true);
			proValue = f.get(obj);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return proValue;
	}
	
	/**
	 * 通过对象和对象的属性获得属性值 返回String
	 * @param proName
	 * @param obj
	 * @return
	 */
	public static String reflectByPropertyReStr(String proName,Object obj) {
		Object proValue = reflectByProperty(proName,obj);
		return StringUtil.nvl(proValue, "");
	}
	
	/**
	 * 通过对象和对象的属性获得属性值 返回int
	 * @param proName
	 * @param obj
	 * @return
	 */
	public static int reflectByPropertyReInt(String proName,Object obj) {
		Object proValue = reflectByProperty(proName,obj);
		return Integer.parseInt(StringUtil.nvl(proValue, "999999"));
	}
	
	/**
	 * 生成符合条件的sql语句,解决in问题
	 * @param sqlParam
	 * @param columnName
	 * @return
	 */
	public static String getSqlIn( String sqlParam, String columnName ){
		int buff_length = 0;
		int spIndex = 500;
		if(sqlParam==null || "".equals(sqlParam)){
			return "";
		}
		String[] str_arr = sqlParam.split(",");
		int width = str_arr.length;
        int arr_width = width/spIndex;
        if(width%spIndex!=0){
        	arr_width += 1;
        }
        StringBuffer buffer = new StringBuffer("");
        for(int i=0;i<arr_width;i++){
        	buffer.append(" " + columnName + " IN(");
        	for(int j=i*spIndex,k=0;j<width && k<spIndex;j++,k++){
        		buffer.append("'" + str_arr[j] + "',");
        	}
        	buff_length = buffer.length();
        	buffer = buffer.delete(buff_length-1, buff_length).append(") OR");
        }
        return buffer.substring(0, buffer.length()-2);
    } 
}
