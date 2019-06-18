package com.gps.statistics.servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gps.common.util.BarChart3D;
import com.gps.common.util.DateUtil;
import com.gps.common.util.MathUtil;
import com.gps.common.util.StringUtil;
import com.gps.statistics.entity.Dayofmilestatics;
import com.gps.statistics.entity.Messagereport;
import com.gps.statistics.entity.MonthStatistics;
import com.gps.statistics.service.DayofmilestaticsServiceImpl;
import com.gps.statistics.service.IDayofmilestaticsService;
import com.gps.statistics.service.IMessagereportService;
import com.gps.statistics.service.MessagereportServiceImpl;

@Controller
public class getChartServlet {

	private Logger log =Logger.getLogger(getChartServlet.class);
	
	@RequestMapping(value="jsp/statisanaly/DailyWorkTime")
	public void getDailyWorkTimeChart(HttpServletRequest request, HttpServletResponse response) {
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid")).trim();
		String vehicleid = StringUtil.nvl2(request.getParameter("vehicleid")).trim();
		String startdate = StringUtil.nvl2(request.getParameter("startdate")).trim();
		String enddate = StringUtil.nvl2(request.getParameter("enddate")).trim();
		try {
			vehicleid = new String(vehicleid.getBytes("ISO8859-1"),"UTF-8");
			deviceid = new String(deviceid.getBytes("ISO8859-1"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			log.debug(e.getMessage());
			return;
		}
		
		if(enddate.equals("") || DateUtil.parse(enddate, "yyyy-MM-dd") == null) {
			enddate = DateUtil.format(new Date(), "yyyy-MM-dd");
		}
		
		if(startdate.equals("") || DateUtil.parse(startdate, "yyyy-MM-dd") == null) {
			 startdate = enddate.substring(0, 8) + "01";
		}
		
		CategoryDataset DataSet = null;
		try {
			DataSet = getDailyWorkDataSet(deviceid, startdate, enddate);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			log.debug(e1.getMessage());
			return;
		}
		
		String filename = "";
		
		filename = BarChart3D.getBarChart3D(vehicleid + "的日工作小时统计图", "日期", "工作时间(时)", 24.0, 4.0, DataSet, request.getSession());
		String imgurl = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort() + request.getContextPath() + "/servlet/DisplayChart?filename=" + filename;
		
		request.setAttribute("chartfilename", imgurl);
		request.setAttribute("startdate", startdate);
		request.setAttribute("enddate", enddate);
		request.setAttribute("deviceid", deviceid);
		request.setAttribute("vehicleid", vehicleid);
		request.setAttribute("servletName", "DailyWorkTime");
		
		//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
		try {
			request.getRequestDispatcher("statistics_image.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.debug(e.getMessage());
			return;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.debug(e.getMessage());
			return;
		}
	}
	
	@RequestMapping(value="jsp/statisanaly/MonthWorkTime")
	public void getMonthWorkTimeChart(HttpServletRequest request, HttpServletResponse response) {
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid")).trim();
		String vehicleid = StringUtil.nvl2(request.getParameter("vehicleid")).trim();
		String startdate = StringUtil.nvl2(request.getParameter("startdate")).trim();
		String enddate = StringUtil.nvl2(request.getParameter("enddate")).trim();
		try {
			vehicleid = new String(vehicleid.getBytes("ISO8859-1"),"UTF-8");
			deviceid = new String(deviceid.getBytes("ISO8859-1"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			log.debug(e.getMessage());
			return;
		}
		
		if(enddate.equals("") || DateUtil.parse(enddate, "yyyy-MM") == null) {
			enddate = DateUtil.format(new Date(), "yyyy-MM");
			String lastday = DateUtil.getMonthLastDay(MathUtil.parseInt(enddate.substring(0, 4)), MathUtil.parseInt(enddate.substring(5, 7)));
			enddate = enddate + "-" + lastday;
		} else {
			String lastday = DateUtil.getMonthLastDay(MathUtil.parseInt(enddate.substring(0, 4)), MathUtil.parseInt(enddate.substring(5, 7)));
			enddate = enddate + "-" + lastday;
		}
		
		if(startdate.equals("") || DateUtil.parse(startdate, "yyyy-MM") == null) {
			Date start = DateUtil.add(DateUtil.parse(enddate), Calendar.MONTH, -5);
			startdate = DateUtil.format(start, "yyyy-MM");
			startdate = startdate + "-01";
		} else {
			startdate = startdate + "-01";
		}
		
		CategoryDataset DataSet = null;
		try {
			DataSet = getMonthWorkDataSet(deviceid, startdate, enddate);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			log.debug(e1.getMessage());
			return;
		}
		
		String filename = "";
		
		filename = BarChart3D.getBarChart3D(vehicleid + "的月工作小时统计图", "日期", "工作时间(时)", 750.0, 75.0, DataSet, request.getSession());
		String imgurl = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort() + request.getContextPath() + "/servlet/DisplayChart?filename=" + filename;
		
		request.setAttribute("chartfilename", imgurl);
		request.setAttribute("startdate", startdate.substring(0, 7));
		request.setAttribute("enddate", enddate.substring(0, 7));
		request.setAttribute("deviceid", deviceid);
		request.setAttribute("vehicleid", vehicleid);
		request.setAttribute("servletName", "MonthWorkTime");
		
		//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
		try {
			request.getRequestDispatcher("statistics_image.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.debug(e.getMessage());
			return;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.debug(e.getMessage());
			return;
		}
	}	
	
	@RequestMapping(value="jsp/statisanaly/DailyWorkMile")
	public void getDailyWorkMileChart(HttpServletRequest request, HttpServletResponse response) {
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid")).trim();
		String vehicleid = StringUtil.nvl2(request.getParameter("vehicleid")).trim();
		String startdate = StringUtil.nvl2(request.getParameter("startdate")).trim();
		String enddate = StringUtil.nvl2(request.getParameter("enddate")).trim();
		try {
			vehicleid = new String(vehicleid.getBytes("ISO8859-1"),"UTF-8");
			deviceid = new String(deviceid.getBytes("ISO8859-1"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			log.debug(e.getMessage());
			return;
		}
		
		if(enddate.equals("") || DateUtil.parse(enddate, "yyyy-MM-dd") == null) {
			enddate = DateUtil.format(new Date(), "yyyy-MM-dd");
		}
		
		if(startdate.equals("") || DateUtil.parse(startdate, "yyyy-MM-dd") == null) {
			 startdate = enddate.substring(0, 8) + "01";
		}
		
		Object[] obj = new Object[2];
		try {
			obj = getDailyMileDataSet(deviceid, startdate, enddate);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			log.debug(e1.getMessage());
			return;
		}
		
		double maxmile = (Double) obj[1];
		if(maxmile == 0.0) {
			maxmile = 100.0;
		} else {
			String max = String.valueOf(maxmile);
			max = max.substring(0, max.indexOf("."));
			if(max.length() < 2) {
				maxmile = 50.0;
			} else {
				maxmile = Double.parseDouble(max.substring(0, max.length() - 1) + "0");
			}
		}
		maxmile = maxmile + 50;
		double offset = maxmile / 5;
		CategoryDataset DataSet = (CategoryDataset) obj[0];
		
		String filename = "";
		
		filename = BarChart3D.getBarChart3D(vehicleid + "的日工作里程统计图", "日期", "里程(米)", maxmile, offset, DataSet, request.getSession());
		String imgurl = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort() + request.getContextPath() + "/servlet/DisplayChart?filename=" + filename;
		
		request.setAttribute("chartfilename", imgurl);
		request.setAttribute("startdate", startdate);
		request.setAttribute("enddate", enddate);
		request.setAttribute("deviceid", deviceid);
		request.setAttribute("vehicleid", vehicleid);
		request.setAttribute("servletName", "DailyWorkMile");
		
		//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
		try {
			request.getRequestDispatcher("statistics_image.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.debug(e.getMessage());
			return;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.debug(e.getMessage());
			return;
		}
	}
	
	@RequestMapping(value="jsp/statisanaly/MonthWorkMile")
	public void getmonthWorkMileChart(HttpServletRequest request, HttpServletResponse response) {
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid")).trim();
		String vehicleid = StringUtil.nvl2(request.getParameter("vehicleid")).trim();
		String startdate = StringUtil.nvl2(request.getParameter("startdate")).trim();
		String enddate = StringUtil.nvl2(request.getParameter("enddate")).trim();
		try {
			vehicleid = new String(vehicleid.getBytes("ISO8859-1"),"UTF-8");
			deviceid = new String(deviceid.getBytes("ISO8859-1"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			log.debug(e.getMessage());
			return;
		}
		
		if(enddate.equals("") || DateUtil.parse(enddate, "yyyy-MM") == null) {
			enddate = DateUtil.format(new Date(), "yyyy-MM");
			String lastday = DateUtil.getMonthLastDay(MathUtil.parseInt(enddate.substring(0, 4)), MathUtil.parseInt(enddate.substring(5, 7)));
			enddate = enddate + "-" + lastday;
		} else {
			String lastday = DateUtil.getMonthLastDay(MathUtil.parseInt(enddate.substring(0, 4)), MathUtil.parseInt(enddate.substring(5, 7)));
			enddate = enddate + "-" + lastday;
		}
		
		if(startdate.equals("") || DateUtil.parse(startdate, "yyyy-MM") == null) {
			Date start = DateUtil.add(DateUtil.parse(enddate), Calendar.MONTH, -5);
			startdate = DateUtil.format(start, "yyyy-MM");
			startdate = startdate + "-01";
		} else {
			startdate = startdate + "-01";
		}
		
		Object[] obj = new Object[2];
		try {
			obj = getMonthMileDataSet(deviceid, startdate, enddate);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			log.debug(e1.getMessage());
			return;
		}
		
		double maxmile = (Double) obj[1];
		if(maxmile == 0.0) {
			maxmile = 100.0;
		} else {
			String max = String.valueOf(maxmile);
			max = max.substring(0, max.indexOf("."));
			if(max.length() < 3) {
				maxmile = 100.0;
			} else {
				maxmile = Double.parseDouble(max.substring(0, max.length() - 2) + "00");
			}
		}
		maxmile = maxmile + 100;
		double offset = maxmile / 5;
		CategoryDataset DataSet = (CategoryDataset) obj[0];
		
		String filename = "";
		
		filename = BarChart3D.getBarChart3D(vehicleid + "的月工作里程统计图", "日期", "里程(米)", maxmile, offset, DataSet, request.getSession());
		String imgurl = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort() + request.getContextPath() + "/servlet/DisplayChart?filename=" + filename;
		
		request.setAttribute("chartfilename", imgurl);
		request.setAttribute("startdate", startdate.substring(0, 7));
		request.setAttribute("enddate", enddate.substring(0, 7));
		request.setAttribute("deviceid", deviceid);
		request.setAttribute("vehicleid", vehicleid);
		request.setAttribute("servletName", "MonthWorkMile");
		
		//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
		try {
			request.getRequestDispatcher("statistics_image.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.debug(e.getMessage());
			return;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.debug(e.getMessage());
			return;
		}
	}
	
	/**
	 * 获取数据
	 * @return
	 * @throws SQLException 
	 */
	private static CategoryDataset getDailyWorkDataSet(String deviceid,String startdate,String enddate) throws SQLException {
		List<Messagereport> list = new ArrayList<Messagereport>();
		IMessagereportService messagereport = new MessagereportServiceImpl();
		
		list = messagereport.getDailyWorkingData(deviceid, startdate, enddate);
		
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		
		HashMap<String,Float> map = new HashMap<String,Float>(); 
		
		for(int i = 0; i < list.size(); i++) {
			Messagereport msgr = list.get(i);
			String dayworkhour = msgr.getCyskqsj();
			if("".equals(dayworkhour) || null==dayworkhour){
				dayworkhour = "0.0";
			}else{
				dayworkhour = dayworkhour.substring(0, dayworkhour.indexOf("小"));
			}
			float hour = Float.parseFloat(dayworkhour);
			map.put(msgr.getRbrq().toString(), hour);
		   	
		}
		
		Date begin = DateUtil.parse(startdate);
		Date end = DateUtil.parse(enddate, "yyyy-MM-dd");
		while(!begin.after(end)) {
			String tem_date = DateUtil.format(begin, "yyyy-MM-dd");
			float hour = 0;
			if(map.containsKey(tem_date)) {
				hour = (float) map.get(tem_date);
			}
			
			dataset.addValue(hour, deviceid, tem_date);
			begin = DateUtil.add(begin, Calendar.DATE, 1);
		}

		return dataset;
	}
	
	private static CategoryDataset getMonthWorkDataSet(String deviceid,String startdate,String enddate) throws SQLException {
		List<MonthStatistics> list = new ArrayList<MonthStatistics>();
		IMessagereportService messagereport = new MessagereportServiceImpl();
		
		list = messagereport.getMonthWorkingData(deviceid, startdate, enddate);
		
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		
		HashMap<String,Float> map = new HashMap<String,Float>();
		
		for(int i = 0; i < list.size(); i++) {
			MonthStatistics monthtime = list.get(i);
			String dayworkhour = monthtime.getMonthdata();
			if("".equals(dayworkhour) || null==dayworkhour){
				dayworkhour = "0.0";
			}
			float hour = Float.parseFloat(dayworkhour);
			map.put(monthtime.getMonth().toString(), hour);
		}
		
		Date begin = DateUtil.parse(startdate, "yyyy-MM");
		Date end = DateUtil.parse(enddate, "yyyy-MM");
		while(!begin.after(end)) {
			String tem_date = DateUtil.format(begin, "yyyy-MM");
			float hour = 0;
			if(map.containsKey(tem_date)) {
				hour = (float) map.get(tem_date);
			}
			
			dataset.addValue(hour, deviceid, tem_date);
			begin = DateUtil.add(begin, Calendar.MONTH, 1);
		}

		return dataset;
	}
	
	private static Object[] getDailyMileDataSet(String deviceid,String startdate,String enddate) throws SQLException {
		Object[] obj = new Object[2];
		List<Dayofmilestatics> list = new ArrayList<Dayofmilestatics>();
		IDayofmilestaticsService dayofmilestaticsservice = new DayofmilestaticsServiceImpl();
		
		list = dayofmilestaticsservice.getDailyMileData(deviceid, startdate, enddate);
		
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		HashMap<String,Float> map = new HashMap<String,Float>();
		double Maxmile = 0.0;
		for(int i = 0; i < list.size(); i++) {
			Dayofmilestatics dayofmilestatics = list.get(i);
			double mile = Double.parseDouble(dayofmilestatics.getMile());
			if( mile > Maxmile) {
				Maxmile = mile;
			}
			
			map.put(dayofmilestatics.getStaticsdate(), Float.parseFloat(dayofmilestatics.getMile()));
		}
		
		Date begin = DateUtil.parse(startdate, "yyyy-MM-dd");
		Date end = DateUtil.parse(enddate, "yyyy-MM-dd");
		while(!begin.after(end)) {
			String tem_date = DateUtil.format(begin, "yyyy-MM-dd");
			float mile = 0;
			if(map.containsKey(tem_date)) {
				mile = (float) map.get(tem_date);
			}
			
			dataset.addValue(mile, deviceid, tem_date);
			begin = DateUtil.add(begin, Calendar.DATE, 1);
		}
		
		obj[0] = dataset;
		obj[1] = Maxmile;

		return obj;
	}
	
	private static Object[] getMonthMileDataSet(String deviceid,String startdate,String enddate) throws SQLException {
		Object[] obj = new Object[2];
		List<MonthStatistics> list = new ArrayList<MonthStatistics>();
		IDayofmilestaticsService dayofmilestaticsservice = new DayofmilestaticsServiceImpl();
		
		list = dayofmilestaticsservice.getMonthMileData(deviceid, startdate, enddate);
		
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		HashMap<String,Float> map = new HashMap<String,Float>();
		double Maxmile = 0.0;
		for(int i = 0; i < list.size(); i++) {
			MonthStatistics monthstatistics = list.get(i);
			double mile = Double.parseDouble(monthstatistics.getMonthdata());
			if( mile > Maxmile) {
				Maxmile = mile;
			}
			
			map.put(monthstatistics.getMonth(), Float.parseFloat(monthstatistics.getMonthdata()));
		}
		
		Date begin = DateUtil.parse(startdate, "yyyy-MM");
		Date end = DateUtil.parse(enddate, "yyyy-MM");
		while(!begin.after(end)) {
			String tem_date = DateUtil.format(begin, "yyyy-MM");
			float mile = 0;
			if(map.containsKey(tem_date)) {
				mile = (float) map.get(tem_date);
			}
			
			dataset.addValue(mile, deviceid, tem_date);
			begin = DateUtil.add(begin, Calendar.MONTH, 1);
		}
		
		obj[0] = dataset;
		obj[1] = Maxmile;

		return obj;
	}
}
