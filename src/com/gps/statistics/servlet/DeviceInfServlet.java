package com.gps.statistics.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gps.account.entity.Dictionary;
import com.gps.account.service.DictionaryServiceImpl;
import com.gps.account.service.IDictionaryService;
import com.gps.common.util.Constants;
import com.gps.common.util.MathUtil;
import com.gps.common.util.StringUtil;
import com.gps.login.entity.Account;
import com.gps.statistics.entity.Relation;
import com.gps.statistics.service.IRelationService;
import com.gps.statistics.service.RelationServiceImpl;

@Controller
public class DeviceInfServlet {

	private Logger log =Logger.getLogger(DeviceInfServlet.class);
	
	@RequestMapping(value="jsp/statisanaly/DeviceInf")
	public void getDeviceInf(HttpServletRequest request, HttpServletResponse response) {
		String servehicleid = StringUtil.nvl2(request.getParameter("servehicleid")).trim();   //机号
		String serdeviceid = StringUtil.nvl2(request.getParameter("serdeviceid")).trim();    //设备号
		String type = StringUtil.nvl2(request.getParameter("type")).trim();		           //1、工作时间日报表  2、工作时间月报表   3、工作里程日报表  4、工作里程月报表
		Account account = (Account) request.getSession().getAttribute(Constants.LOGIN_USER);
		String login_name = account.getName();
		
		int page_no = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_no")).trim());          //第N页
		int page_num = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_num")).trim());        //每页个数
		String servletName = "";
		
		if(type.equals("1")) {
			servletName = "DailyWorkTime";
		} else if(type.equals("2")) {
			servletName = "MonthWorkTime";
		} else if(type.equals("3")) {
			servletName = "DailyWorkMile";
		} else if(type.equals("4")) {
			servletName = "MonthWorkMile";
		} else {
			type = "1";
			servletName = "DailyWorkTime";
		}
		
		if(page_num == 0) {
			page_num = 5;
		}
		if(page_no == 0) {
			page_no = 1;
		}
		
		IRelationService relationservice = new RelationServiceImpl();
		
		int tot_num;
		try {
			tot_num = relationservice.getVehicleCount(servehicleid, serdeviceid, login_name);
		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
			log.debug(e2.getMessage());
			return;
		}
		
		int tot_page = getPagenum(tot_num, page_num);
		
		List<Relation> list = new ArrayList<Relation>();
		if(tot_num != 0) {
			try {
				list = relationservice.getVehicleList(servehicleid, serdeviceid, login_name, page_no, page_num);
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				log.debug(e1.getMessage());
				return;
			}
		}
		
		IDictionaryService service =new DictionaryServiceImpl();
		Dictionary dictionary=new Dictionary();
		dictionary.setStart(null);//不分页
		dictionary.setD_type("jxzl");
		List<Dictionary> list1 = new ArrayList<Dictionary>();
		try {
			list1 = service.queryByDictionary(dictionary);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		HashMap<String,String> map = new HashMap<String,String>();
		for(int i = 0; i < list1.size(); i++) {
			map.put(list1.get(i).getD_code(), list1.get(i).getD_value());
		}
		
		for(int i = 0; i < list.size(); i++) {
			String type_nm = "";
			if(list.get(i).getType() != null) {
				type_nm = list.get(i).getType();
			}
			
			if(map.containsKey(type_nm)) {
				list.get(i).setType(map.get(type_nm));
			}
		}
				
		request.setAttribute("vehiclelist", list);
		request.setAttribute("servehicleid", servehicleid);
		request.setAttribute("serdeviceid", serdeviceid);
		request.setAttribute("type", type);
		request.setAttribute("page_no", page_no);
		request.setAttribute("tot_page", tot_page);
		request.setAttribute("page_num", page_num);
		request.setAttribute("servletName", servletName);
		
		//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
		try {
			request.getRequestDispatcher("statisticsInf_index.jsp").forward(request, response);
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
