package com.gps.common.util;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

public class BeanHandler<T> {

	private Class<T> poClass;

	/**
	 * @param poClass 要被注入的类
	 */
	public BeanHandler(Class<T> poClass) {
		this.poClass = poClass ;
	} 

	/**
	 * 将Map中的值对注入到指定的类里 
	 * <br>
	 * 要求: map中的key必须与目标Bean中的setXxx方法存在以下关系 即setXxx = "set" + StringUtil.firstCharU(key); 
	 * @author wangp
	 * @since 2009.04.28
	 * @param map 数据来源
	 * @return 注入数据后的类
	 */
	public T handler(Map<String ,Object> map) {
		T o = null;
		try {
			
			o = poClass.newInstance();
			Method[] methods = o.getClass().getMethods();
			for (int i = 0; i < methods.length; i++) {
				Method aMethod = methods[i];
				String name = aMethod.getName();
				if (name.indexOf("set") != 0)
					continue;
				Class _class = aMethod.getParameterTypes()[0];
				name = name.substring(3);
                try{
                    if(_class==Long.class||_class==Long.TYPE){
                        aMethod.invoke(o,new Object[]{MathUtil.parseLong((BigDecimal)map.get(parseName(name)))});
                    } else if(_class==Integer.class||_class==Integer.TYPE){
                        aMethod.invoke(o,new Object[]{MathUtil.parseInt((BigDecimal)map.get(parseName(name)))});
                    } else if(_class==Float.class||_class==Float.TYPE){
                        aMethod.invoke(o,new Object[]{MathUtil.parseFloat((BigDecimal)map.get(parseName(name)))});
                    } else if(_class==Double.class||_class==Double.TYPE){
                        aMethod.invoke(o,new Object[]{MathUtil.parseDbl((BigDecimal)map.get(parseName(name)))});
                    }  else if(_class==BigDecimal.class){
                        aMethod.invoke(o,new Object[]{(BigDecimal)map.get(parseName(name))});
                    } else if(_class==String.class){
                        Object obj=map.get(parseName(name));
                        aMethod.invoke(o,new Object[]{StringUtil.nvl(obj ,null)});
                    } else if(_class==Date.class){
                        aMethod.invoke(o, new Object[]{(Date)map.get(parseName(name))});
                    } else if (_class == Timestamp.class) {
                        aMethod.invoke(o, new Object[]{(Date)map.get(parseName(name))});
                    } else {
                    	throw new RuntimeException("不支持的参数类型: "+_class+" | "+name +" | "+ DateUtil.format((Date)map.get(parseName(name))));
                    }
                }catch(ClassCastException e){
                    throw new RuntimeException("类型转换错误[类名："+o.getClass().getName()+"，字段名："+name+"]",e);
                }
            }
		} catch (InstantiationException e) {
			 throw new RuntimeException("注入失败", e);
		} catch (IllegalAccessException e) {
			 throw new RuntimeException("注入失败", e);
		} catch (InvocationTargetException e) {
			 throw new RuntimeException("注入失败", e);
		}
		return o;
	}
	/**
	 * 将Map中的值对注入到指定的类里
 	 * 要求: request中的key必须与目标Bean中的setXxx方法存在以下关系 即setXxx = "set" + StringUtil.firstCharU(key); 
	 * @author wangp
	 * @since 2009.04.28
	 * @param request 数据来源
	 * @return 注入数据后的类
	 * @throws Exception 
	 */
	public T handler(HttpServletRequest request ,T o) {
		try {
			if(o == null){
				o = poClass.newInstance();
			}
			Method[] methods = o.getClass().getMethods();
			Class _class = null;
			Map map = request.getParameterMap();
			String vTmp = null;
			for (int i = 0; i < methods.length; i++) {
				Method aMethod = methods[i];
				String name = aMethod.getName();
				if (name.indexOf("set") != 0)
					continue;
				name = StringUtil.toLowerCaseFirst(name.substring(3));
				if(!map.containsKey(name)){	//Bean里有这个set方法同时request里有这个参数 ,那么自动注入
           		 	continue ;
           	 	}
				_class = aMethod.getParameterTypes()[0];
                try{
                	vTmp = StringUtil.trim(StringUtil.clear(request.getParameter(name)));
                    if ((_class == Float.class || _class == Float.TYPE)) {
                        aMethod.invoke(o,new Object[]{MathUtil.parseFloat(vTmp)});
                    } else if (_class == Long.class || _class == Long.TYPE) {
                        aMethod.invoke(o,new Object[]{MathUtil.parseLong(vTmp)});
                    } else if (_class == Double.class || _class == Double.TYPE) {
                        aMethod.invoke(o,new Object[]{MathUtil.parseDbl(vTmp)});
                    } else if (_class == BigDecimal.class) {
                        aMethod.invoke(o,new Object[]{MathUtil.getBigDecimal(vTmp,0)});
                    } else if (_class == Integer.class || _class == Integer.TYPE) {
                        aMethod.invoke(o,new Object[]{MathUtil.parseInt(vTmp)});
                    } else if (_class == String.class) {
                        aMethod.invoke(o,new Object[]{vTmp});
                    } else if (_class == Date.class) {
                        aMethod.invoke(o, new Object[]{DateUtil.parse(vTmp)});
                    } else if (_class == Timestamp.class) {
                        aMethod.invoke(o, new Object[]{DateUtil.parseTimestamp(vTmp)});
                    } else {
                    	throw new RuntimeException("不支持的参数类型: "+_class+" | "+name +" | "+ vTmp);
                    }
                }catch(ClassCastException e){
                    throw new RuntimeException("类型转换错误[类名："+o.getClass().getName()+"，字段名："+name+"]",e);
                } catch(Exception e1){
                	throw new Exception("["+name+"]["+vTmp+"]"+e1.getMessage());
                }
            }
		} catch (InstantiationException e) {
			 throw new RuntimeException("注入失败", e);
		} catch (IllegalAccessException e) {
			 throw new RuntimeException("注入失败", e);
		} catch (InvocationTargetException e) {
			 throw new RuntimeException("注入失败", e);
		} catch (Exception e){
			throw new RuntimeException(e);
		}
		return o;
	}
	
    /**
     * 将包含Map对象的List更改为javaBean的List
     * @author wangp
     * @since 2009.04.30
     * @param list 待处理的List
     * @return 注入后的List
     */
	public List<T> handler(List<Map<String,Object>> list){
		List<T> _list=new ArrayList<T>();
		for(int i=0;i<list.size();i++){
			_list.add(this.handler(list.get(i)));
		}
		return _list;
	}
	/**
	 * 将下划线去掉并将其后的第一个字母转换为大写
	 * @param s
	 * @return
	 */
	private String parseName(String s) {
		StringBuffer buffer = new StringBuffer();
		int count = 0;
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			if (c >= 'A' && c <= 'Z') {
				if (count == 0) {
					buffer.append(("" + c).toLowerCase());
					count++;
				} else {
					buffer.append("_").append(("" + c).toLowerCase());
				}
			} else {
				buffer.append(c);
			}
		}
		return buffer.toString().toUpperCase();
	}
	/**
	 * 从srcpo里为o加载同名属性;如果o的属性以_sub结尾则到srcpo中寻找去掉_sub的属性作为原始值 ,然后到request中寻找变更后的值;
	 * @author wangp
	 * @param request
	 * @param srcpo
	 * @param po
	 * @param _sub
	 * @param attriNames
	 * @return
	 * @throws NoSuchMethodException 
	 * @throws SecurityException 
	 */
	@SuppressWarnings("unchecked")
	public T handler(HttpServletRequest request, Object srcpo,
			T o, String _sub ,Map<String ,Boolean>attriMap) throws SecurityException, NoSuchMethodException {
		try {
			if(o == null){
				o = poClass.newInstance();
			}
			Method[] methods = o.getClass().getMethods();
			Method[] srcGetMethods = srcpo.getClass().getMethods();
			Map<String ,Method> srcGetMap = new HashMap<String ,Method>();
			Map<String ,Method> desSetMap = new HashMap<String ,Method>();
			String tmp ;
			for(int i = 0 ;i<srcGetMethods.length;i++){
				tmp = srcGetMethods[i].getName();
				if (tmp.indexOf("get") != 0)
					continue;
				srcGetMap.put(StringUtil.toLowerCaseFirst(tmp.substring(3)), srcGetMethods[i]);
			}
			
			Class _class = null;
			Map<String,String[]> paraMap = request.getParameterMap();
			String paraKey = null;	//与属性对应的参数 key
			String name = null;
			String tmpValue = null;
			for (int i = 0; i < methods.length; i++) {
				Method aMethod = methods[i];
				name = aMethod.getName();
				if (name.indexOf("set") != 0)
					continue;
				name = StringUtil.toLowerCaseFirst(name.substring(3));
				paraKey = name.endsWith(_sub)?name.substring(0,name.lastIndexOf(_sub)):name;
				
				if(!srcGetMap.containsKey(paraKey)){	//Bean里有这个set方法同时request里有这个参数 ,那么自动注入
           		 	continue ;
           	 	}
				//||
				_class = aMethod.getParameterTypes()[0];
                try{
                	aMethod.invoke(o, srcGetMap.get(paraKey).invoke(srcpo, new Object[]{}));	//先装载原始值
                	tmpValue = null;
                	if(name.endsWith(_sub)&&attriMap.containsKey(paraKey)&&paraMap.containsKey(paraKey)){
                		tmpValue = paraMap.get(paraKey) == null ? null : paraMap.get(paraKey)[0];
	                    if ((_class == Float.class || _class == Float.TYPE)) {
	                        aMethod.invoke(o,new Object[]{MathUtil.parseFloat(tmpValue)});
	                    } else if (_class == Long.class || _class == Long.TYPE) {
	                        aMethod.invoke(o,new Object[]{MathUtil.parseLong(tmpValue)});
	                    } else if (_class == Double.class || _class == Double.TYPE) {
	                        aMethod.invoke(o,new Object[]{MathUtil.parseDbl(tmpValue)});
	                    } else if (_class == BigDecimal.class) {
	                        aMethod.invoke(o,new Object[]{MathUtil.getBigDecimal(tmpValue,0)});
	                    } else if (_class == Integer.class || _class == Integer.TYPE) {
	                        aMethod.invoke(o,new Object[]{MathUtil.parseInt(tmpValue)});
	                    } else if (_class == String.class) {
	                        aMethod.invoke(o,new Object[]{tmpValue});
	                    } else if (_class == Date.class) {
	                        aMethod.invoke(o, new Object[]{DateUtil.parse(tmpValue)});
	                    } else if (_class == Timestamp.class) {
	                        aMethod.invoke(o, new Object[]{DateUtil.parseTimestamp(tmpValue)});
	                    } else {
	                    	throw new RuntimeException("不支持的参数类型: "+_class+" | "+name +" | "+ tmpValue);
	                    }
                	}
                }catch(ClassCastException e){
                	e.printStackTrace();
                    throw new RuntimeException("类型转换错误[类名："+o.getClass().getName()+"，字段名："+name+"] 参数名: "+paraKey+"]",e);
                }
            }
		} catch (InstantiationException e) {
			 throw new RuntimeException("注入失败", e);
		} catch (IllegalAccessException e) {
			 throw new RuntimeException("注入失败", e);
		} catch (InvocationTargetException e) {
			 throw new RuntimeException("注入失败", e);
		}
		return o;
	}
	public T handlerTrim(HttpServletRequest request ,T o) throws Exception {
		try {
			if(o == null){
				o = poClass.newInstance();
			}
			Method[] methods = o.getClass().getMethods();
			//System.out.println("methods"+methods.length);
			Class _class = null;
			Enumeration<String> enumrat = request.getParameterNames();
			Map<String,Boolean> map = new HashMap<String,Boolean>();
			while(enumrat.hasMoreElements()){
				String element=enumrat.nextElement();
				//System.out.println("element::::"+element);
				map.put(element, Boolean.TRUE);
			}
			String vTmp ;
			for (int i = 0; i < methods.length; i++) {
				Method aMethod = methods[i];
				String name = aMethod.getName();
				//System.out.println("name1="+name);
				if (name.indexOf("set") != 0)
					continue;
				name = StringUtil.toLowerCaseFirst(name.substring(3));
				//System.out.println("name2="+name);
				if(map.get(name)!=Boolean.TRUE){	//Bean里有这个set方法同时request里有这个参数 ,那么自动注入
           		 	continue ;
           	 	}
				_class = aMethod.getParameterTypes()[0];
                try{
                	vTmp = StringUtil.trim(request.getParameter(name));
                	//System.out.println("name="+name);
                	//System.out.println("vTmp="+vTmp);
                    if ((_class == Float.class || _class == Float.TYPE)) {
                        aMethod.invoke(o,new Object[]{MathUtil.parseFloat(vTmp)});
                    } else if (_class == Long.class || _class == Long.TYPE) {
                        aMethod.invoke(o,new Object[]{MathUtil.parseLong(vTmp)});
                    } else if (_class == Double.class || _class == Double.TYPE) {
                        aMethod.invoke(o,new Object[]{MathUtil.parseDbl(vTmp)});
                    } else if (_class == BigDecimal.class) {
                        aMethod.invoke(o,new Object[]{MathUtil.getBigDecimal(vTmp,0)});
                    } else if (_class == Integer.class || _class == Integer.TYPE) {
                        aMethod.invoke(o,new Object[]{MathUtil.parseInt(vTmp)});
                    } else if (_class == String.class) {
                        aMethod.invoke(o,new Object[]{vTmp});
                    } else if (_class == Date.class) {
                        aMethod.invoke(o, new Object[]{DateUtil.parse(vTmp)});
                    } else if (_class == Timestamp.class) {
                        aMethod.invoke(o, new Object[]{DateUtil.parseTimestamp(vTmp)});
                    } else {
                    	throw new RuntimeException("不支持的参数类型: "+_class+" | "+name +" | "+ vTmp);
                    } 
                }catch(ClassCastException e){
                    throw new RuntimeException("类型转换错误[类名："+o.getClass().getName()+"，字段名："+name+"]",e);
                }
            }
		} catch (InstantiationException e) {
			 throw new RuntimeException("注入失败", e);
		} catch (IllegalAccessException e) {
			 throw new RuntimeException("注入失败", e);
		} catch (InvocationTargetException e) {
			 throw new RuntimeException("注入失败", e);
		}
		return o;
	}
	/**
	 * 把数组里的元素做key ,true1做value ,目的只是表示这个key在数组里存在
	 * @author wangp
	 * @param mid_bg
	 * @param true1
	 * @return
	 */
	public Map<String, Boolean> array2Map(String[] mid_bg, Boolean true1) {
		Map <String ,Boolean> map = new HashMap<String,Boolean>();
		for(int i=0;i<mid_bg.length;i++){
			map.put(mid_bg[i], true1);
		}
			
		return map;
	}
	/**
	 * 调用des对象的setter方法保存从src对象中通过对应的getter方法取得的值；
	 * <br> 无org.apache.commons.beanutils.BeanUtils.copyProperties(dest, orig)方法中处理Timestamp类型参数的问题
	 * @param des 目标对象
	 * @param src 源对象
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	public static void setByGetter (Object des ,Object src) throws IllegalArgumentException, IllegalAccessException, InvocationTargetException{
		Method [] ms = des.getClass().getMethods();
		Method m ;
		Method g ;
		String name;
		for (int i=0;i<ms.length;i++){
			m = ms[i];
			name = m.getName(); 
			if(name.startsWith("set")){
				try {
					g = src.getClass().getMethod(name.replaceFirst("s", "g"));
					if(g == null)
						continue ;
				} catch (SecurityException e) {
					continue ;
				} catch (NoSuchMethodException e) {
					continue ;
				}
				m.invoke(des, g.invoke(src));
			}
		}
	}
	public static void load(Object obj,ResultSet rs) throws SQLException{
		Method[] methods = obj.getClass().getMethods();
		Method aMethod;
		HashMap<String, Method> map = new HashMap<String, Method>();
		for (int i = 0; i < methods.length; i++) {
			aMethod = methods[i];
			aMethod.setAccessible(false); // 关闭安全检查
			String name = aMethod.getName();
			if (name.indexOf("set") != 0)
				continue;
			name = name.substring(3);
			map.put(name.toUpperCase(), aMethod);
		}
		ResultSetMetaData meta = rs.getMetaData();
		int cols = meta.getColumnCount();
		String col_name;
		Method m;
		Object value;
		String v_str;
		for (int i = 1; i <= cols; i++) {
			col_name = meta.getColumnName(i);
			aMethod = map.get(col_name); 
			if (aMethod == null)
				continue ;
			Class _class = aMethod.getParameterTypes()[0];
			try {
				if("int".equals(_class.getSimpleName())){
					v_str = rs.getString(col_name);
					aMethod.invoke(obj, MathUtil.parseInt(v_str));
				}else if("double".equals(_class.getSimpleName())){
					v_str = rs.getString(col_name);
					aMethod.invoke(obj, MathUtil.parseDbl(v_str));
				}else {
					m = rs.getClass().getMethod("get"+StringUtil.toUpperCaseFirst(_class.getSimpleName()), new Class[]{String.class});
					m.setAccessible(false);
					value = m.invoke(rs, col_name);
					aMethod.invoke(obj, _class.cast(value));
				}
			} catch (Exception e) {
				throw new RuntimeException(e);
			} 
		}
	}
	
	public static void main(String[] args) {
		
	}
}
