package com.gps.vehicledistr.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gps.login.entity.Account;
import com.gps.vehicledistr.entity.OutAreaAlarm;
import com.gps.vehicledistr.entity.VehicleInfNew;
import com.gps.vehicledistr.service.VehicleDistrService;
import com.gps.vehicledistr.service.VehicleDistrServiceImpl;

/**
 * 
 * @Description 车辆分布
 * @author wgx
 * @param 
 * @throws
 */

@Controller
public class VehicleDistrServlet {
	private Logger log = Logger.getLogger(VehicleDistrServlet.class);
	@RequestMapping(value="jsp/vehicledistr/distrbute")
	public void distrbute(HttpServletRequest request, HttpServletResponse response){
		VehicleDistrService vds = new VehicleDistrServiceImpl();
		Account account = new Account();
		account = (Account)request.getSession().getAttribute("login_user");
		try {
			List<VehicleInfNew> list = new ArrayList<VehicleInfNew>();
			list = vds.getVehicleInf(account);
			request.setAttribute("vehiclelist", list);
			request.getRequestDispatcher("allvehicles.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			log.info(e.getMessage());
		} 
	}
	
	
	@RequestMapping(value="jsp/vehicledistr/elecFenc")
	public void elecFenc(HttpServletRequest request, HttpServletResponse response){
		
		try {
			request.getRequestDispatcher("elec_content.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.info(e.getMessage());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.info(e.getMessage());
		}
	}
	
	@RequestMapping(value="jsp/vehicledistr/outAlarm")
	public void outAlarm(HttpServletRequest request, HttpServletResponse response){
		try {
			VehicleDistrService vds = new VehicleDistrServiceImpl();
			List<OutAreaAlarm> list = new ArrayList<OutAreaAlarm>();
			Map<String, String> map = new HashMap<String, String>();
			list = vds.getAlarmInf(map);
			request.setAttribute("outlist", list);
			request.getRequestDispatcher("outalarm.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			log.info(e.getMessage());
		}
	}
}
