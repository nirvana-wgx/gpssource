package com.gps.common.util;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;

public class ExportExcel {

	/**
	 * 将传入的JAVABEAN的list进行解析，导出EXCEL
	 * @param list
	 * @param xlsName
	 * @param sheetName
	 * @throws Exception
	 */
	public static <T> HSSFWorkbook dataExportExcel(List<T> list, String sheetName) throws Exception {
		HSSFWorkbook workbook = new HSSFWorkbook();                          //创建工作薄
		HSSFSheet sheet = workbook.createSheet();                            //创建工作表
		workbook.setSheetName(0,sheetName,HSSFWorkbook.ENCODING_UTF_16);     //设置工作蒲的中文字符
		HSSFRow row = sheet.createRow((short)0);;                           //添加行
		HSSFCell cell;
		
		//获取名称
		List<String> nlist = getJavabeanName(list.get(0));
		for(int i = 0; i < nlist.size(); i++) {
			cell = row.createCell((short)(i));                              //创建单元格
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);                    //设置单元格的类型
			cell.setEncoding(HSSFCell.ENCODING_UTF_16);                     //设置单元格字符
			Object obj = nlist.get(i);                                      //获取JAVABEAN的字段名
			cell.setCellValue(obj.toString());                              //单元格中添加文字
			setCellStyle(workbook, cell, "CORNFLOWER_BLUE", HSSFColor.CORNFLOWER_BLUE.index);  //设置单元格的样式
		}
		
		//获取数据值
		for(int i = 0; i < list.size(); i++) {
			List<Object> rlist = getJavabeanValue(list.get(i));    //获取JAVABEAN里的值
			row= sheet.createRow((short)i + 1);                    //创建新的一行
			for(int j = 0; j < rlist.size(); j++) {
				cell = row.createCell((short)(j));                 //创建单元格
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);       //设置单元格的类型
				cell.setEncoding(HSSFCell.ENCODING_UTF_16);        //设置单元格的字符
				Object obj = rlist.get(j);                         
				cell.setCellValue(obj.toString());                 //单元格中添加文字
			}
		}

		return workbook;
	}
	
	
	/**
	 * 将传入的JAVABEAN的list进行解析及标题List，导出EXCEL
	 * @param list
	 * @param xlsName
	 * @param sheetName
	 * @throws Exception
	 */
	public static <T> HSSFWorkbook dataExportExcel(List<T> list, List<String> title_list, String sheetName) throws Exception {
		HSSFWorkbook workbook = new HSSFWorkbook();                          //创建工作薄
		HSSFSheet sheet = workbook.createSheet();                            //创建工作表
		workbook.setSheetName(0,sheetName,HSSFWorkbook.ENCODING_UTF_16);     //设置工作蒲的中文字符
		HSSFRow row = sheet.createRow((short)0);;                           //添加行
		HSSFCell cell;
		
		//获取名称
		for(int i = 0; i < title_list.size(); i++) {
			cell = row.createCell((short)(i));                              //创建单元格
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);                    //设置单元格的类型
			cell.setEncoding(HSSFCell.ENCODING_UTF_16);                     //设置单元格字符
			Object obj = title_list.get(i);                                      //获取JAVABEAN的字段名
			cell.setCellValue(obj.toString());                              //单元格中添加文字
			setCellStyle(workbook, cell, "CORNFLOWER_BLUE", HSSFColor.CORNFLOWER_BLUE.index);  //设置单元格的样式
		}
		
		//获取数据值
		for(int i = 0; i < list.size(); i++) {
			List<Object> rlist = getJavabeanValue(list.get(i));    //获取JAVABEAN里的值
			row= sheet.createRow((short)i + 1);                    //创建新的一行
			for(int j = 0; j < rlist.size(); j++) {
				cell = row.createCell((short)(j));                 //创建单元格
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);       //设置单元格的类型
				cell.setEncoding(HSSFCell.ENCODING_UTF_16);        //设置单元格的字符
				Object obj = rlist.get(j);                         
				cell.setCellValue(obj.toString());                 //单元格中添加文字
			}
		}

		return workbook;
	}
	
	
	/**
	 * 将传入的的list进行解析及标题List，导出EXCEL
	 * @param list
	 * @param xlsName
	 * @param sheetName
	 * @throws Exception
	 */
	public static HSSFWorkbook dataExportExcel(String sheetName, List<List<String>> list, List<String> title_list) throws Exception {
		HSSFWorkbook workbook = new HSSFWorkbook();                          //创建工作薄
		HSSFSheet sheet = workbook.createSheet();                            //创建工作表
		workbook.setSheetName(0,sheetName,HSSFWorkbook.ENCODING_UTF_16);     //设置工作蒲的中文字符
		HSSFRow row = sheet.createRow((short)0);;                           //添加行
		HSSFCell cell;
		
		//获取名称
		for(int i = 0; i < title_list.size(); i++) {
			cell = row.createCell((short)(i));                              //创建单元格
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);                    //设置单元格的类型
			cell.setEncoding(HSSFCell.ENCODING_UTF_16);                     //设置单元格字符
			Object obj = title_list.get(i);                                      //获取JAVABEAN的字段名
			cell.setCellValue(obj.toString());                              //单元格中添加文字
			setCellStyle(workbook, cell, "CORNFLOWER_BLUE", HSSFColor.CORNFLOWER_BLUE.index);  //设置单元格的样式
		}
		
		//获取数据值
		for(int i = 0; i < list.size(); i++) {
			List<String> rlist = list.get(i);    //获取JAVABEAN里的值
			row= sheet.createRow((short)i + 1);                    //创建新的一行
			for(int j = 0; j < rlist.size(); j++) {
				cell = row.createCell((short)(j));                 //创建单元格
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);       //设置单元格的类型
				cell.setEncoding(HSSFCell.ENCODING_UTF_16);        //设置单元格的字符
				Object obj = rlist.get(j);
				if(obj == null) {
					obj = "";
				}
				cell.setCellValue(obj.toString());                 //单元格中添加文字
			}
		}

		return workbook;
	}
	
	/**
	 * 动态获取JAVABEAN里的值
	 * @param javabean
	 * @return
	 * @throws Exception
	 * @throws IllegalAccessException
	 */
	private static List<Object> getJavabeanValue(Object javabean) throws Exception, IllegalAccessException {  
		Field[] fields = javabean.getClass().getDeclaredFields();
		Field.setAccessible(fields, true);
		List<Object> list = new ArrayList<Object>();
		for (int i = 0; i < fields.length; i++) {
	        Field field = fields[i];
	        list.add(field.get(javabean));
	    }
		
	    return list;
	}
	
	/**
	 * 动态获取JAVABEAN的字段
	 * @param javabean
	 * @return
	 * @throws Exception
	 * @throws IllegalAccessException
	 */
	private static List<String> getJavabeanName(Object javabean) throws Exception, IllegalAccessException {  
		Field[] fields = javabean.getClass().getDeclaredFields();
		Field.setAccessible(fields, true);
		List<String> list = new ArrayList<String>();
		for (int i = 0; i < fields.length; i++) {
	        Field field = fields[i];
	        list.add(field.getName());
	    }
		
	    return list;
	}
	
	/**
	 * 设置单元格的样式
	 * @param workbook
	 * @param cell
	 * @param col
	 * @param fg
	 */
	private static void setCellStyle(HSSFWorkbook workbook, HSSFCell cell, String col, short fg){
	    HSSFCellStyle style = workbook.createCellStyle();
	    style.setFillForegroundColor(fg);
	    style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	    cell.setCellStyle(style);
	}
	
//	public static void main(String[] args) throws Exception {	
//		List<Loginlog> list = new ArrayList<Loginlog>();
//		
//		Loginlog llog = new Loginlog("root","172.0.0.1",new Date());
//		llog.setLlid("11111111111111111");
//		
//		Loginlog llog1 = new Loginlog("ygsh","172.0.0.1",new Date());
//		llog1.setLlid("2222222222222222");
//		list.add(llog);
//		list.add(llog1);
//		resultSetToExcel(list,"D:\\test.xls","人员信息");
//		
//	}

}
