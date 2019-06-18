package com.gps.alarm.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gps.alarm.entity.GpsAlarm;
import com.gps.alarm.entity.SellAlarm;
import com.gps.alarm.entity.ServiceAlarm;
import com.gps.alarm.entity.VehicleinAlarm;
import com.gps.alarm.service.IVehicleinfnewAlarmService;
import com.gps.alarm.service.VehicleinfnewAlarmServiceImpl;
import com.gps.common.util.Constants;
import com.gps.common.util.MathUtil;
import com.gps.common.util.StringUtil;
import com.gps.login.entity.Account;

@Controller
public class AlarmServlet {

	private Logger log =Logger.getLogger(AlarmServlet.class);
	
	@RequestMapping(value="jsp/alarm/MachineAlarm")
	public void MachineAlarm(HttpServletRequest request, HttpServletResponse response) {
		String serdeviceid = StringUtil.nvl2(request.getParameter("serdeviceid")).trim();
		String servehicleid = StringUtil.nvl2(request.getParameter("servehicleid")).trim();
		String sersim = StringUtil.nvl2(request.getParameter("sersim")).trim();
		String seraccount = StringUtil.nvl2(request.getParameter("seraccount")).trim();
		String seritem = StringUtil.nvl2(request.getParameter("seritem")).trim();
		
		int page_no = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_no")).trim());          //第N页
		int page_num = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_num")).trim());        //每页个数
		
		if(page_num == 0) {
			page_num = 15;
		}
		if(page_no == 0) {
			page_no = 1;
		}
		
		Account account = (Account) request.getSession().getAttribute(Constants.LOGIN_USER);
		String login_name = account.getName();
		
		IVehicleinfnewAlarmService vehicleinfnewalarmservice = new VehicleinfnewAlarmServiceImpl();
		
		int tot_num;
		try {
			tot_num = vehicleinfnewalarmservice.getVehicleinfAlarmCount(servehicleid, serdeviceid, sersim, seraccount, seritem, login_name);
		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
			log.debug(e2.getMessage());
			return;
		}
		
		int tot_page = getPagenum(tot_num, page_num);
		
		List<VehicleinAlarm> list = new ArrayList<VehicleinAlarm>();
		if(tot_num != 0) {
			try {
				list = vehicleinfnewalarmservice.getVehicleinfAlarm(servehicleid, serdeviceid, sersim, seraccount, seritem, page_no, page_num, login_name);
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				log.debug(e1.getMessage());
				return;
			}
		}
		
		request.setAttribute("vehicleinalarmlist", list);
		request.setAttribute("servehicleid", servehicleid);
		request.setAttribute("serdeviceid", serdeviceid);
		request.setAttribute("sersim", sersim);
		request.setAttribute("seraccount", seraccount);
		request.setAttribute("seritem", seritem);
		request.setAttribute("page_no", page_no);
		request.setAttribute("tot_page", tot_page);
		request.setAttribute("page_num", page_num);
		//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
		try {
			request.getRequestDispatcher("machine_alarm.jsp").forward(request, response);
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
	
	
	@RequestMapping(value="jsp/alarm/GpsAlarm")
	public void GpsAlarm(HttpServletRequest request, HttpServletResponse response) {
		String serdeviceid = StringUtil.nvl2(request.getParameter("serdeviceid")).trim();
		String sersim = StringUtil.nvl2(request.getParameter("sersim")).trim();
		String seritem = StringUtil.nvl2(request.getParameter("seritem")).trim();
		
		int page_no = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_no")).trim());          //第N页
		int page_num = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_num")).trim());        //每页个数
		
		if(page_num == 0) {
			page_num = 15;
		}
		if(page_no == 0) {
			page_no = 1;
		}
		
		Account account = (Account) request.getSession().getAttribute(Constants.LOGIN_USER);
		String login_name = account.getName();
		
		IVehicleinfnewAlarmService vehicleinfnewalarmservice = new VehicleinfnewAlarmServiceImpl();
		
		int tot_num;
		try {
			tot_num = vehicleinfnewalarmservice.getGpsAlarmCount(serdeviceid, sersim, seritem, login_name);
		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
			log.debug(e2.getMessage());
			return;
		}
		
		int tot_page = getPagenum(tot_num, page_num);
		
		List<GpsAlarm> list = new ArrayList<GpsAlarm>();
		if(tot_num != 0) {
			try {
				list = vehicleinfnewalarmservice.getGpsAlarm(serdeviceid, sersim, seritem, page_no, page_num, login_name);
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				log.debug(e1.getMessage());
				return;
			}
		}
		
		request.setAttribute("gpsalarmlist", list);
		request.setAttribute("serdeviceid", serdeviceid);
		request.setAttribute("sersim", sersim);
		request.setAttribute("seritem", seritem);
		request.setAttribute("page_no", page_no);
		request.setAttribute("tot_page", tot_page);
		request.setAttribute("page_num", page_num);
		
		//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
		try {
			request.getRequestDispatcher("gps_alarm.jsp").forward(request, response);
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
	
	@RequestMapping(value="jsp/alarm/SellAlarm")
	public void SellAlarm(HttpServletRequest request, HttpServletResponse response) {
		String servehicleid = StringUtil.nvl2(request.getParameter("servehicleid")).trim();
		String seraccount = StringUtil.nvl2(request.getParameter("seraccount")).trim();
		String serdate = StringUtil.nvl2(request.getParameter("serdate")).trim();
		
		int page_no = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_no")).trim());          //第N页
		int page_num = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_num")).trim());        //每页个数
		
		if(page_num == 0) {
			page_num = 15;
		}
		if(page_no == 0) {
			page_no = 1;
		}
		
		Account account = (Account) request.getSession().getAttribute(Constants.LOGIN_USER);
		String login_name = account.getName();
		
		IVehicleinfnewAlarmService vehicleinfnewalarmservice = new VehicleinfnewAlarmServiceImpl();
		
		int tot_num;
		try {
			tot_num = vehicleinfnewalarmservice.getSellAlarmCount(servehicleid, seraccount, serdate, login_name);
		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
			log.debug(e2.getMessage());
			return;
		}
		
		int tot_page = getPagenum(tot_num, page_num);
		
		List<SellAlarm> list = new ArrayList<SellAlarm>();
		if(tot_num != 0) {
			try {
				list = vehicleinfnewalarmservice.getSellAlarm(servehicleid, seraccount, serdate, page_no, page_num, login_name);
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				log.debug(e1.getMessage());
				return;
			}
		}
		
		request.setAttribute("sellalarmlist", list);
		request.setAttribute("servehicleid", servehicleid);
		request.setAttribute("seraccount", seraccount);
		request.setAttribute("serdate", serdate);
		request.setAttribute("page_no", page_no);
		request.setAttribute("tot_page", tot_page);
		request.setAttribute("page_num", page_num);

		
		//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
		try {
			request.getRequestDispatcher("sell_alarm.jsp").forward(request, response);
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
	
	@RequestMapping(value="jsp/alarm/ServiceAlarm")
	public void ServiceAlarm(HttpServletRequest request, HttpServletResponse response) {
		String servehicleid = StringUtil.nvl2(request.getParameter("servehicleid")).trim();
		String seraccount = StringUtil.nvl2(request.getParameter("seraccount")).trim();
		String seritem = StringUtil.nvl2(request.getParameter("seritem")).trim();
		
		int page_no = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_no")).trim());          //第N页
		int page_num = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_num")).trim());        //每页个数
		
		if(page_num == 0) {
			page_num = 15;
		}
		if(page_no == 0) {
			page_no = 1;
		}
		
		Account account = (Account) request.getSession().getAttribute(Constants.LOGIN_USER);
		String login_name = account.getName();
		
		IVehicleinfnewAlarmService vehicleinfnewalarmservice = new VehicleinfnewAlarmServiceImpl();
		
		int tot_num;
		try {
			tot_num = vehicleinfnewalarmservice.getServiceAlarmCount(servehicleid, seraccount, seritem, login_name);
		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
			log.debug(e2.getMessage());
			return;
		}
		
		int tot_page = getPagenum(tot_num, page_num);
		
		List<ServiceAlarm> list = new ArrayList<ServiceAlarm>();
		if(tot_num != 0) {
			try {
				list = vehicleinfnewalarmservice.getServiceAlarm(servehicleid, seraccount, seritem, page_no, page_num, login_name);
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				log.debug(e1.getMessage());
				return;
			}
		}
		
		request.setAttribute("servicealarmlist", list);
		request.setAttribute("servehicleid", servehicleid);
		request.setAttribute("seraccount", seraccount);
		request.setAttribute("seritem", seritem);
		request.setAttribute("page_no", page_no);
		request.setAttribute("tot_page", tot_page);
		request.setAttribute("page_num", page_num);
		
		//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
		try {
			request.getRequestDispatcher("service_alarm.jsp").forward(request, response);
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
	
	private static int getPagenum(int tot_num, int page_num) {
		if(tot_num % page_num == 0) {
			return tot_num / page_num;
		} else {
			return tot_num / page_num + 1;
		}
	}
}
