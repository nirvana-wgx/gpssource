package com.gps.vehiclemng.servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gps.common.util.BeanHandler;
import com.gps.common.util.Constants;
import com.gps.common.util.DateUtil;
import com.gps.common.util.ExportExcel;
import com.gps.common.util.MathUtil;
import com.gps.common.util.StringUtil;
import com.gps.login.entity.Account;

import com.gps.statistics.entity.Relation;
import com.gps.vehiclemng.entity.Maintenance;
 
import com.gps.vehiclemng.service.IMaintenanceService;
import com.gps.vehiclemng.service.MaintenanceServiceImpl;

@Controller
public class MaintenanceInfoServlet {

	private Logger log =Logger.getLogger(MaintenanceInfoServlet.class);
	
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/MaintenaceInfo")
	public void getMaintenaceInfo(HttpServletRequest request, HttpServletResponse response) {
		String type = StringUtil.nvl2(request.getParameter("type"));
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));
		String fitting = StringUtil.nvl2(request.getParameter("fitting"));
		String maintenancedate = StringUtil.nvl2(request.getParameter("maintenancedate"));
		String isovertime = StringUtil.nvl2(request.getParameter("isovertime"));
		int page_no = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_no")).trim());          //第N页
		int page_num = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_num")).trim());        //每页个数
		
		String action = "";
		if(!type.equals("1") && !type.equals("2")) {
			type = "1";
		}
				
		if(page_num == 0) {
			page_num = 5;
		}
		if(page_no == 0) {
			page_no = 1;
		}
		
		String path = "";
		int tot_num = 0;
		List<Maintenance> list = new ArrayList<Maintenance>();
		IMaintenanceService maintenanceservice = new MaintenanceServiceImpl();
		if(type.equals("1")) {
			path = "maintenance_info.jsp";
			action = "";
		} else {
			path = "maintenance_history.jsp";
			action = "完成保养";
		}
		
		try {
			tot_num = maintenanceservice.getMaintenanceCount(deviceid, fitting, maintenancedate, isovertime, action);
			if(tot_num != 0) {
				list = maintenanceservice.getMaintenanceList(deviceid, fitting, maintenancedate, isovertime, action, page_no, page_num);					
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.debug(e.getMessage());
			return;
		}
		int tot_page = getPagenum(tot_num, page_num);
		
		request.setAttribute("maintenancelist", list);
		request.setAttribute("deviceid", deviceid);
		request.setAttribute("fitting", fitting);
		request.setAttribute("maintenancedate", maintenancedate);
		request.setAttribute("isovertime", isovertime);
		request.setAttribute("page_no", page_no);
		request.setAttribute("tot_page", tot_page);
		request.setAttribute("page_num", page_num);
		
		//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
		try {
			request.getRequestDispatcher(path).forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.debug(e.getMessage());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.debug(e.getMessage());
		}
	}
	
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/FinishMaintenace")
	public void FinishMaintenace(HttpServletRequest request, HttpServletResponse response) {
		String maid = StringUtil.nvl2(request.getParameter("maid"));
		String remark = StringUtil.nvl2(request.getParameter("remark"));
		
		Map<String,String> message =new HashMap<String,String>();
		
		IMaintenanceService maintenanceservice = new MaintenanceServiceImpl();
		int flg = -1;
		try {
			flg = maintenanceservice.updateAction(maid, remark);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		message.put("message", String.valueOf(flg));
		try {
			response.getWriter().write(JSONObject.fromObject(message).toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	/**
	 *车辆保养保存 
	 */
	@RequestMapping(value="jsp/vechiclemanager/maintainVehicle")
	public void maintainVehicle(HttpServletRequest request, HttpServletResponse response){
		Maintenance pojo =new Maintenance();
		try {
			new BeanHandler<Maintenance>(Maintenance.class).handlerTrim(request, pojo);
			Account account =(Account) request.getSession().getAttribute(Constants.LOGIN_USER);
			pojo.setCreater(account.getName());
			pojo.setCreatetime(DateUtil.getCurrentDate());
			pojo.setRemark("");
			pojo.setAction(encode(pojo.getAction()));
			pojo.setFitting(encode(pojo.getFitting()));
			pojo.setVehicleid(encode(pojo.getVehicleid()));
			IMaintenanceService service =new MaintenanceServiceImpl();
			int result =service.save(pojo);
			Map<String,String> map =new HashMap<String, String>();
			map.put("message", String.valueOf(result));
			response.getWriter().write(JSONObject.fromObject(map).toString());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/MaintenaceInfDownload")
	public void getMaintenaceInfDownload(HttpServletRequest request, HttpServletResponse response) {
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));
		String fitting = StringUtil.nvl2(request.getParameter("fitting"));
		String maintenancedate = StringUtil.nvl2(request.getParameter("maintenancedate"));
		String isovertime = StringUtil.nvl2(request.getParameter("isovertime"));
		
		com.gps.statistics.service.IRelationService relationservice = new com.gps.statistics.service.RelationServiceImpl();
		Account account = (Account) request.getSession().getAttribute(Constants.LOGIN_USER);
		String login_name = account.getName();
		List<Relation> list = new ArrayList<Relation>();
		try {
			list = relationservice.getVehicleList("", deviceid, login_name, 1, 1);
		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
			log.debug(e2.getMessage());
			return;
		}
		
		Relation relation = new Relation();
		if(list.size() > 0) {
			relation = list.get(0);
		}
		
		List<Maintenance> maintenancelist = new ArrayList<Maintenance>();
		IMaintenanceService maintenanceservice = new MaintenanceServiceImpl();
		String action = "";
		
		try {
			maintenancelist = maintenanceservice.getMaintenanceList(relation.getDeviceid(), fitting, maintenancedate, isovertime, action, 1, 2000);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		List<String> title_list = new ArrayList<String>();
		title_list.add("车辆编号");
		title_list.add("保养配件");
		title_list.add("预警日期");
		title_list.add("保养日期");
		title_list.add("保养动作");
		title_list.add("保养完成日期");
		title_list.add("创建用户");
		title_list.add("创建时间");
		title_list.add("备注");
		
		List<List<String>> v_list = new ArrayList<List<String>>();
		
		for(int i = 0; i < maintenancelist.size(); i++) {
			List<String> data_list = new ArrayList<String>();
			data_list.add(maintenancelist.get(i).getVehicleid());
			data_list.add(maintenancelist.get(i).getFitting());
			
			if(maintenancelist.get(i).getExpiretime() != null) {
				data_list.add(DateUtil.format(maintenancelist.get(i).getExpiretime(), "yyyy-MM-dd"));
			} else {
				data_list.add("");
			}
			
			if(maintenancelist.get(i).getMaintenancetime() != null) {
				data_list.add(DateUtil.format(maintenancelist.get(i).getMaintenancetime(), "yyyy-MM-dd"));
			} else {
				data_list.add("");
			}
			
			data_list.add(maintenancelist.get(i).getAction());
			
			if(maintenancelist.get(i).getFinishtime() != null) {
				data_list.add(DateUtil.format(maintenancelist.get(i).getFinishtime(), "yyyy-MM-dd"));
			} else {
				data_list.add("");
			}
			
			data_list.add(maintenancelist.get(i).getCreater());
			
			if(maintenancelist.get(i).getCreatetime() != null) {
				data_list.add(DateUtil.format(maintenancelist.get(i).getCreatetime(), "yyyy-MM-dd"));
			} else {
				data_list.add("");
			}
			data_list.add(maintenancelist.get(i).getRemark());
			v_list.add(data_list);
		}
		
		try {
			String filename = relation.getVehicleid() + "车辆保养信息.xls";
			HSSFWorkbook wb = ExportExcel.dataExportExcel(relation.getVehicleid(), v_list, title_list);
			response.setContentType("application/vnd.ms-excel");
			response.addHeader("Content-Disposition", "attachment; filename=\"" +new String(filename.getBytes("gb2312"),"iso8859-1")+ "\"");
			OutputStream out = response.getOutputStream();
			wb.write(out);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/MaintenaceHistoryDownload")
	public void getMaintenaceHistoryDownload(HttpServletRequest request, HttpServletResponse response) {
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));
		String fitting = StringUtil.nvl2(request.getParameter("fitting"));
		String maintenancedate = StringUtil.nvl2(request.getParameter("maintenancedate"));
		String isovertime = StringUtil.nvl2(request.getParameter("isovertime"));
		
		List<Maintenance> maintenancelist = new ArrayList<Maintenance>();
		IMaintenanceService maintenanceservice = new MaintenanceServiceImpl();
		String action = "完成保养";
		
		com.gps.statistics.service.IRelationService relationservice = new com.gps.statistics.service.RelationServiceImpl();
		Account account = (Account) request.getSession().getAttribute(Constants.LOGIN_USER);
		String login_name = account.getName();
		List<Relation> list = new ArrayList<Relation>();
		try {
			list = relationservice.getVehicleList("", deviceid, login_name, 1, 1);
		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
			log.debug(e2.getMessage());
			return;
		}
		
		Relation relation = new Relation();
		if(list.size() > 0) {
			relation = list.get(0);
		}
		
		try {
			maintenancelist = maintenanceservice.getMaintenanceList(relation.getDeviceid(), fitting, maintenancedate, isovertime, action, 1, 2000);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		List<String> title_list = new ArrayList<String>();
		title_list.add("车辆编号");
		title_list.add("保养配件");
		title_list.add("预警日期");
		title_list.add("保养日期");
		title_list.add("保养动作");
		title_list.add("保养完成日期");
		title_list.add("创建用户");
		title_list.add("创建时间");
		title_list.add("备注");
		
		List<List<String>> v_list = new ArrayList<List<String>>();
		
		for(int i = 0; i < maintenancelist.size(); i++) {
			List<String> data_list = new ArrayList<String>();
			data_list.add(maintenancelist.get(i).getVehicleid());
			data_list.add(maintenancelist.get(i).getFitting());
			
			if(maintenancelist.get(i).getExpiretime() != null) {
				data_list.add(DateUtil.format(maintenancelist.get(i).getExpiretime(), "yyyy-MM-dd"));
			} else {
				data_list.add("");
			}
			
			if(maintenancelist.get(i).getMaintenancetime() != null) {
				data_list.add(DateUtil.format(maintenancelist.get(i).getMaintenancetime(), "yyyy-MM-dd"));
			} else {
				data_list.add("");
			}
			
			data_list.add(maintenancelist.get(i).getAction());
			
			if(maintenancelist.get(i).getFinishtime() != null) {
				data_list.add(DateUtil.format(maintenancelist.get(i).getFinishtime(), "yyyy-MM-dd"));
			} else {
				data_list.add("");
			}
			
			data_list.add(maintenancelist.get(i).getCreater());
			
			if(maintenancelist.get(i).getCreatetime() != null) {
				data_list.add(DateUtil.format(maintenancelist.get(i).getCreatetime(), "yyyy-MM-dd"));
			} else {
				data_list.add("");
			}
			data_list.add(maintenancelist.get(i).getRemark());
			v_list.add(data_list);
		}
		
		try {
			String filename = relation.getVehicleid() + "车辆保养历史信息.xls";
			HSSFWorkbook wb = ExportExcel.dataExportExcel(relation.getVehicleid(), v_list, title_list);
			response.setContentType("application/vnd.ms-excel");
			response.addHeader("Content-Disposition", "attachment; filename=\"" +new String(filename.getBytes("gb2312"),"iso8859-1")+ "\"");
			OutputStream out = response.getOutputStream();
			wb.write(out);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	private static int getPagenum(int tot_num, int page_num) {
		if(tot_num % page_num == 0) {
			return tot_num / page_num;
		} else {
			return tot_num / page_num + 1;
		}
		
	}
	private String encode(String params){
		if(params==null){
			return params;
		}
		try {
			String paramsTrans = new String(params.getBytes("ISO-8859-1"),"UTF-8");
			params =  URLDecoder.decode(paramsTrans , "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return params;
	}
}
