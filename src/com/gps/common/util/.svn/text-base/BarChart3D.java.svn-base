package com.gps.common.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.RenderingHints;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartRenderingInfo;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.axis.NumberTickUnit;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.entity.StandardEntityCollection;
import org.jfree.chart.labels.ItemLabelAnchor;
import org.jfree.chart.labels.ItemLabelPosition;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer3D;
import org.jfree.chart.servlet.ServletUtilities;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.CategoryDataset;
import org.jfree.ui.TextAnchor;

public class BarChart3D {
	
	public static String getBarChart3D(String BarChartTitle, String Xtitle, String Ytitle, double YNumber, double Yoffset, CategoryDataset DataSet, HttpSession session) {
		JFreeChart chart = createBarChart(BarChartTitle, Xtitle, Ytitle, DataSet);
		processChart(chart, YNumber, Yoffset);
		return writeChartTempAsImage(chart, session);
	}

	/**
	 * 创建BarChart
	 * @param dataset
	 * @return
	 */
	public static JFreeChart createBarChart(String BarChartTitle, String Xtitle, String Ytitle, CategoryDataset DataSet) {
		JFreeChart chart = ChartFactory.createBarChart3D(
				BarChartTitle,                            // 图表标题
				Xtitle,                                // 目录轴的显示标签--横轴
				Ytitle,                               // 数值轴的显示标签--纵轴
				DataSet,                             // 数据集
				PlotOrientation.VERTICAL,            // 图表方向：水平、
				false,                               // 是否显示图例(对于简单的柱状图必须
				false,                                // 是否生成工具
				false                                // 是否生成URL链接
	        );
		
		return chart;
	}
	
	/**
	 * 处理chart中文及图形的显示
	 * @param chart
	 */
	@SuppressWarnings("deprecation")
	public static void processChart(JFreeChart chart, double YNumber, double Yoffset) {
		chart.setBackgroundPaint(new Color(0xF5FAFA));
		CategoryPlot plot = chart.getCategoryPlot();                                  //获取图表区域对象
		CategoryAxis domainAxis = plot.getDomainAxis();                               //水平底部列表
		ValueAxis rAxis = plot.getRangeAxis();                                        //获取柱状
		chart.getRenderingHints().put(RenderingHints.KEY_TEXT_ANTIALIASING,           // 设置图例说明Legend上的文字(//设置底部的字体)
				RenderingHints.VALUE_TEXT_ANTIALIAS_OFF);
		TextTitle textTitle = chart.getTitle();                                       //获取标题
		textTitle.setFont(new Font("宋体", Font.PLAIN, 20));                            //设置标题字体
		domainAxis.setTickLabelFont(new Font("sans-serif", Font.PLAIN, 11));           //设置X轴坐标上的文字字体
		domainAxis.setCategoryLabelPositions(CategoryLabelPositions.DOWN_90); 
		domainAxis.setLabelFont(new Font("宋体", Font.PLAIN, 12));                       //设置X轴的标题文字字体
		// 设置距离图片左端距离 
		domainAxis.setLowerMargin(0.0); 
		// 设置距离图片右端距离 
		domainAxis.setUpperMargin(0.0);
		rAxis.setTickLabelFont(new Font("sans-serif", Font.PLAIN, 12));                 //设置Y轴坐标上的文字字体
		rAxis.setLabelFont(new Font("宋体", Font.PLAIN, 12));                             //设置Y轴的标题文字字体
		rAxis.setUpperBound(YNumber);                                                        //数据轴上的显示最大值
		rAxis.setUpperMargin(4);
		NumberAxis numaxis = (NumberAxis) plot.getRangeAxis();
		numaxis.setTickUnit(new NumberTickUnit(Yoffset));
		
		BarRenderer3D renderer = (BarRenderer3D) plot.getRenderer();                     //获取图形属性
		renderer.setItemLabelGenerator(new StandardCategoryItemLabelGenerator());        //设置图形中显示具体数据
		renderer.setPositiveItemLabelPosition(new ItemLabelPosition(
				 ItemLabelAnchor.OUTSIDE12,TextAnchor.BASELINE_LEFT));
		renderer.setItemLabelsVisible(true);                                             //设置数据可见
		renderer.setSeriesPaint(0,new Color(64,224,208));                                //柱体颜色设置
//		renderer.setMaximumBarWidth(0.04);                                               //设置柱宽
		plot.setRenderer(renderer);                                                      //保存设置

	}
	
	/**
	 * 把生成的图片放到临时目录
	 * 
	 * @param chart
	 */
	public static String writeChartTempAsImage(JFreeChart chart, HttpSession session) {
		String filename;
		
		try {
			// 把生成的图片放到临时目录
            ChartRenderingInfo info = new ChartRenderingInfo(new
                    StandardEntityCollection());
			filename = ServletUtilities.saveChartAsPNG(chart, 900, 500, info, session);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			 filename = "public_error.png";
		}
		return filename;
	}
	
	/**
	 * 输出图片
	 * 
	 * @param chart
	 */
	public static void writeChartAsImage(JFreeChart chart) {
		FileOutputStream fos_jpg = null;
		try {
			fos_jpg = new FileOutputStream("D:\\fruit.jpg");
			ChartUtilities.writeChartAsJPEG(fos_jpg, 1, chart, 800, 600, null);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				fos_jpg.close();
			} catch (Exception e) {
			}
		}
	}
}
