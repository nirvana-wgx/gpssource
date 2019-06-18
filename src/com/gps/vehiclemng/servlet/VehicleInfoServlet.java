package com.gps.vehiclemng.servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gps.account.entity.Dictionary;
import com.gps.account.service.DictionaryServiceImpl;
import com.gps.account.service.IDictionaryService;
import com.gps.common.util.BeanHandler;
import com.gps.common.util.Constants;
import com.gps.common.util.DateUtil;
import com.gps.common.util.GetPosition;
import com.gps.common.util.StringUtil;
import com.gps.login.entity.Account;
import com.gps.login.service.AccountServiceImpl;
import com.gps.statistics.entity.Relation;
import com.gps.vehiclemng.entity.Car;
import com.gps.vehiclemng.entity.Messagebm;
import com.gps.vehiclemng.entity.VehicleInfNew;
import com.gps.vehiclemng.service.IMessagebmService;
import com.gps.vehiclemng.service.IQueryPowersService;
import com.gps.vehiclemng.service.IRelationService;
import com.gps.vehiclemng.service.MessagebmServiceImpl;
import com.gps.vehiclemng.service.QueryPowersServiceImpl;
import com.gps.vehiclemng.service.RelationServiceImpl;

@Controller
public class VehicleInfoServlet {
	
	private Logger log =Logger.getLogger(VehicleInfoServlet.class);
	
	@RequestMapping(value="jsp/vechiclemanager/removeVehicle")
	public void removeVehicle(HttpServletRequest request, HttpServletResponse response){
		String rid =StringUtil.trim(request.getParameter("rid"));
		Car pojo =new Car();
		pojo.setRid(rid);
		IRelationService service =new RelationServiceImpl();
		try {
			service.remove(pojo);
			vehicleList(request, response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	@RequestMapping(value="jsp/vechiclemanager/upVehicle")
	public void upVehicle(HttpServletRequest request, HttpServletResponse response){
		String rid =StringUtil.trim(request.getParameter("rid"));
		String carstate =StringUtil.trim(request.getParameter("carstate"));
		

		try {
			Car pojo =new Car();
			new BeanHandler<Car>(Car.class).handlerTrim(request, pojo);
			pojo.setRid(rid);
			pojo.setCarstate(carstate);
			 
			pojo.setStorageRemark(encode(pojo.getStorageRemark()));
			pojo.setStorageCreator(encode(pojo.getStorageCreator()));
			pojo.setBuyname(encode(pojo.getBuyname()));
			
			IRelationService service =new RelationServiceImpl();
			service.modify(pojo);
			request.setAttribute("from", "1");
			vehicleList(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 
	 * @Description 车辆一览
	 * @author 肖海兵
	 
	 * @param request
	 * @param response
	 * @throws
	 */
	@RequestMapping(value="jsp/vechiclemanager/list")
	public void vehicleList(HttpServletRequest request, HttpServletResponse response){
		try {
			Account account =(Account) request.getSession().getAttribute(Constants.LOGIN_USER);
			String cname =account.getName();
			Car pojo =new Car();
			new BeanHandler<Car>(Car.class).handlerTrim(request, pojo);
			if(request.getAttribute("from")!=null){
				pojo.setCarstate(null);
			}
			IDictionaryService service =new DictionaryServiceImpl();
			Dictionary dictionary=new Dictionary();
			if(!"root".equals(cname)){
				dictionary.setName(cname);
			}
			dictionary.setD_type("jxzl");
			List<Dictionary> list_jxzl=service.queryByDictionary(dictionary);
			dictionary.setD_type("clzt");
			List<Dictionary> list_clzt=service.queryByDictionary(dictionary);
			dictionary.setD_type("jxlx");
			List<Dictionary> list_jxlx=service.queryByDictionary(dictionary);
			pojo.setCname(cname);
			List<Account> list_account=new AccountServiceImpl().findChildrenByname(cname);
			request.setAttribute("list_jxzl", 		list_jxzl);
			request.setAttribute("list_clzt", 		list_clzt);
			request.setAttribute("list_jxlx", 		list_jxlx);
			request.setAttribute("list_account",    list_account);
			IRelationService carservice =new RelationServiceImpl();
			String currentPage =request.getParameter("currentPage");
			String pageSize =request.getParameter("pageSize");
			
			pojo.setStart(null);//总条与总页
			List<Car> list =carservice.query(pojo);

			pojo.setStart(1);//分页
			
			if(!StringUtil.isEmpty(currentPage)){
				pojo.setCurentPage(Integer.parseInt(currentPage));
			}else{
				currentPage=String.valueOf(pojo.getCurentPage());
			}
			if(!StringUtil.isEmpty(pageSize)){
				pojo.setPageSize(Integer.parseInt(pageSize));
			}else{
				pageSize =String.valueOf(pojo.getPageSize());
			}
		
			request.setAttribute("total", list.size());
			double totalPage =  Math.ceil((double) list.size()/Integer.parseInt(pageSize));
			request.setAttribute("totalPage", (int)totalPage);
			
			list =carservice.query(pojo);
			List<Car> list1 =new ArrayList<Car>();
			for(int i=0;i<list.size();i++){
				Car car =list.get(i);
				if(!StringUtil.isEmpty(car.getLongitude()) && !StringUtil.isEmpty(car.getLatitude())){
					car.setLocate(GetPosition.getPositionByXY(car.getLongitude(), car.getLatitude()));
				}else{
					car.setLocate("");
				}
				list1.add(car);
			}
			 
			List<VehicleInfNew> vlist =carservice.queryAllVehicleInfNew(); // load all vehicle
			Map<String,VehicleInfNew> map =new HashMap<String,VehicleInfNew>();
			for(VehicleInfNew vif :vlist){
				map.put(vif.getVehicleid(),vif);
			}//  cache  pojo 
			
			for(Car car :list1){
				String rect=car.getReceivetime();
				if(null!=rect){
					if(rect.trim().length()>=2){
						rect = rect.substring(0, rect.length()-2);
						System.out.println(rect);
					}
				}
				car.setReceivetime(rect);
				
				 VehicleInfNew vif =map.get(car.getVehicleid());
				 if(vif==null){
					 continue;
				 }
				  if(vif.isWarnJXBJ()){
					 car.setVehicleidstate("1");
				 }
				 if(vif.isWarnZDBJ()){
					 car.setDeviceidstate("1");
				 }
				 if(vif.isWarnDWYC()){
					 car.setGpsstate("1");
				 }
				 if(vif.isWarnBSD()){
					 car.setVehicleidlockstate("1");
				 } 
			}
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("pageSize", pageSize);
			request.setAttribute("list", list1);
			
			request.setAttribute("car", pojo);
			request.getRequestDispatcher("vehicle_list.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
			log.info(e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
			log.info(e.getMessage());
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	 * @Description 车辆新增
	 * @author 肖海兵
	 * @param request
	 * @param response
	 * @throws
	 */
	@RequestMapping(value="jsp/vechiclemanager/carsave")
	public void carsave(HttpServletRequest request, HttpServletResponse response){
		
		try {
			Car pojo =new Car();
			pojo.setCreatetime(DateUtil.format(Calendar.getInstance().getTime(),"yyyy-MM-dd"));
			new BeanHandler<Car>(Car.class).handlerTrim(request, pojo);
			IRelationService service =new RelationServiceImpl();
			String rid =request.getParameter("rid");
			if(StringUtil.isEmpty(pojo.getIsnoice())){
				pojo.setIsnoice("0");
			}
			int result =0;
			if(!StringUtil.isEmpty(rid)){
				result =service.modify(pojo);
			}else{
				result =service.save(pojo);
			}
			Map<String,String> map =new HashMap<String,String>();
			map.put("message", String.valueOf(result));
			response.getWriter().write(JSONObject.fromObject(map).toString());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping(value="jsp/vechiclemanager/modify")
	public void modify(HttpServletRequest request, HttpServletResponse response){
		try {
			Account account =(Account) request.getSession().getAttribute(Constants.LOGIN_USER);
			String cname =account.getName();
			IDictionaryService service =new DictionaryServiceImpl();
			Dictionary dictionary=new Dictionary();
			if(!"root".equals(cname)){
				dictionary.setName(cname);
			}
			
			dictionary.setD_type("jxzl");
			List<Dictionary> list_jxzl=service.queryByDictionary(dictionary);
			dictionary.setD_type("clzt");
			List<Dictionary> list_clzt=service.queryByDictionary(dictionary);
			dictionary.setD_type("jxlx");
			List<Dictionary> list_jxlx=service.queryByDictionary(dictionary);
			
			List<Account> list_account=new AccountServiceImpl().findChildrenByname(cname);
			IRelationService relationService =new RelationServiceImpl();
//			Car pojo =new Car();
			Car car =new Car();
			String rid =request.getParameter("rid");
			if(!StringUtil.isEmpty(rid)){
				request.setAttribute("title", "车辆修改");
				/*pojo.setRid(rid);
				List<Car> list =relationService.getCarByrid(Integer.valueOf(rid));
				car =list.get(0);*/
				car =relationService.getCarByrid(rid);
			}else{
				request.setAttribute("title", "车辆新增");
			}
			request.setAttribute("list_jxzl", list_jxzl);
			request.setAttribute("list_clzt", list_clzt);
			request.setAttribute("list_jxlx", list_jxlx);
			request.setAttribute("list_account", list_account);
			request.setAttribute("car", car);
			request.getRequestDispatcher("vehicle_edit.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.info(e.getMessage());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.info(e.getMessage());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	 * @Description 机械种类配置
	 * @author wgx
	 * @Data Jun 10, 2013
	 * @param request
	 * @param response
	 * @throws
	 */
	@RequestMapping(value="jsp/vechiclemanager/type")
	public void setType(HttpServletRequest request, HttpServletResponse response){
		try {
			request.getRequestDispatcher("vehicle_type_add.jsp").forward(request, response);
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
	
	/**
	 * 
	 * @Description 机械型号配置
	 * @author wgx
	 * @Data Jun 10, 2013
	 * @param request
	 * @param response
	 * @throws
	 */
	@RequestMapping(value="jsp/vechiclemanager/model")
	public void setModel(HttpServletRequest request, HttpServletResponse response){
		try {
			request.getRequestDispatcher("vehicle_modle_add.jsp").forward(request, response);
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
	
	/**
	 * 
	 * @Description 单车车辆基本信息
	 * @author yang_gsh
	 * @Data 2013.6.3
	 * @param request
	 * @param response
	 * @throws
	 */
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/VehicleInfo")
	public void getVehicleInfo(HttpServletRequest request, HttpServletResponse response) {
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));
		
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
		
		IMessagebmService messagebmservice = new MessagebmServiceImpl();
		Messagebm messagebm = new Messagebm();
		try {
			messagebm = messagebmservice.getNewMessagebm(deviceid);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			log.debug(e1.getMessage());
			return;
		}
		String AutoLockString = getAutoLockString(messagebm);
		String LockString = getLockString(messagebm);
		int isWarnZDBJ = isWarnZDBJ(messagebm);
		String position = "";
		if(messagebm != null) {
			position = GetPosition.getPositionByXY(messagebm.getLongitude(), messagebm.getLatitude());
			messagebm.setPositioninfo(position);
		}
		
		IDictionaryService service =new DictionaryServiceImpl();
		Dictionary dictionary=new Dictionary();
		dictionary.setStart(null);//不分页
		dictionary.setD_type("jxzl");
		dictionary.setD_code(relation.getType());
		List<Dictionary> list1 = new ArrayList<Dictionary>();
		try {
			list1 = service.queryByDictionary(dictionary);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		String type_name = "";
		if(list1.size() > 0) {
			type_name = list1.get(0).getD_value();
		}
		
		dictionary.setD_type("clzt");
		dictionary.setD_code(relation.getCarstate());
		List<Dictionary> list2 = new ArrayList<Dictionary>();
		try {
			list2 = service.queryByDictionary(dictionary);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		String state_name = "";
		if(list2.size() > 0) {
			state_name = list2.get(0).getD_value();
		}
		
		relation.setCarstate(state_name);
		
		request.setAttribute("type_name", type_name);
		request.setAttribute("relation", relation);
		request.setAttribute("messagebm", messagebm);
		request.setAttribute("AutoLockString", AutoLockString);
		request.setAttribute("LockString", LockString);
		request.setAttribute("isWarnZDBJ", isWarnZDBJ);
		
		
		//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
		try {
			request.getRequestDispatcher("vehicle_info.jsp").forward(request, response);
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
	
	/**
	 * 
	 * @Description 单车车辆信息
	 * @author yang_gsh
	 * @Data 2013.6.11
	 * @param request
	 * @param response
	 * @throws
	 */
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/SingleVehicle")
	public void getSingleVehicle(HttpServletRequest request, HttpServletResponse response) {
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));
		
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
		
		request.setAttribute("deviceid", relation.getDeviceid());
		request.setAttribute("vehicleid", relation.getVehicleid());
		
		//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
		try {
			request.getRequestDispatcher("singlevechicle_menu.jsp").forward(request, response);
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
	
	/**
	 * 
	 * @Description 单车车辆左菜单
	 * @author yang_gsh
	 * @Data 2013.6.11
	 * @param request
	 * @param response
	 * @throws
	 */
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/SingleVehicleLeftMenu")
	public void toSingleVehicleLeftMenu(HttpServletRequest request, HttpServletResponse response) {
		String vehicleid = StringUtil.nvl2(request.getParameter("vehicleid"));
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));
		Account account = (Account) request.getSession().getAttribute(Constants.LOGIN_USER);
		String login_name = account.getName();
		
		IQueryPowersService querypowersservice = new QueryPowersServiceImpl();
		String ishistoryshow = "0";
		
		try {
			if(querypowersservice.isExistPowers(login_name, "lscxqx")) {
				ishistoryshow = "1";
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			vehicleid = new String(vehicleid.getBytes("ISO8859-1"),"GBK");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			log.debug(e.getMessage());
			return;
		}
		request.setAttribute("vehicleid", vehicleid);
		request.setAttribute("deviceid", deviceid);
		request.setAttribute("ishistoryshow", ishistoryshow);
		
		//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
		try {
			request.getRequestDispatcher("singlevechicle_left.jsp").forward(request, response);
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
	
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/singleworkContent")
	public void singleworkContent(HttpServletRequest request, HttpServletResponse response) {
		
		 try {
			request.getRequestDispatcher("singlevechicle_content.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	 * @Description 指令下发
	 * @author wgx
	 * @Data Jul 27, 2013
	 * @param request
	 * @param response
	 * @throws
	 */
	@RequestMapping(value="jsp/vechiclemanager/cmdSend")
	public void cmdSend(HttpServletRequest request, HttpServletResponse response) {
		//String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));//获取设备号
		
	    try {
			
			request.getRequestDispatcher("singlevechicle_content.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// 自锁车状态
	private static String getAutoLockString(Messagebm messagebm) {
		if(messagebm == null) {
			return "";
		}
		
		StringBuilder builder = new StringBuilder();
		String Gpsautolocktwomonth = StringUtil.nvl2(messagebm.getGpsautolocktwomonth());
		if (Gpsautolocktwomonth.equals("") || Gpsautolocktwomonth.equals("使能")
				|| Gpsautolocktwomonth.equals("自锁车")) {
			builder.append("两个月信息不回传、");
		}
		String Gpsautolockshell = StringUtil.nvl2(messagebm.getGpsautolockshell());
		if (Gpsautolockshell.equals("") || Gpsautolockshell.equals("使能")
				|| Gpsautolockshell.equals("自锁车")) {
			builder.append("开壳、");
		}
		String Gpsautolockantenna = StringUtil.nvl2(messagebm.getGpsautolockantenna());
		if (Gpsautolockantenna.equals("") || Gpsautolockantenna.equals("使能")
				|| messagebm.getGpsautolockantenna().equals("自锁车")) {
			builder.append("GPS天线异常、");
		}
		String Gpsautolockmain = StringUtil.nvl2(messagebm.getGpsautolockmain());
		if (Gpsautolockmain.equals("") || Gpsautolockmain.equals("使能")
				|| Gpsautolockmain.equals("自锁车")) {
			builder.append("总线通讯中断、");
		}
		String result = builder.toString();
		int length = result.length();
		if (length != 0) {
			result = result.substring(0, length - 1) + "自锁车";
			return result;
		}
		return "正常";
	}
		
	// 锁车状态
	private static String getLockString(Messagebm messagebm) {
		if(messagebm == null) {
			return "";
		}
		
		StringBuilder builder = new StringBuilder();
		String Gpsrelay1 = StringUtil.nvl2(messagebm.getGpsrelay1());
		if (Gpsrelay1.equals("") || Gpsrelay1.equals("锁车")) {
			builder.append("1、");
		}
		String Gpsrelay2 = StringUtil.nvl2(messagebm.getGpsrelay2());
		if (Gpsrelay2.equals("") || Gpsrelay2.equals("锁车")) {
			builder.append("2、");
		}
		String Gpsrelay3 = StringUtil.nvl2(messagebm.getGpsrelay3());
		if (Gpsrelay3.equals("") || Gpsrelay3.equals("锁车")) {
			builder.append("3、");
		}
		String Gpsrelay4 = StringUtil.nvl2(messagebm.getGpsrelay4());
		if (Gpsrelay4.equals("") || Gpsrelay4.equals("锁车")) {
			builder.append("4、");
		}
		String result = builder.toString();
		int length = result.length();
		if (length != 0) {
			result = "第" + result.substring(0, length - 1) + "路锁车";
			return result;
		}
		return "正常";
	}
	
	// 是否终端报警
	private static int isWarnZDBJ(Messagebm messagebm) {
		if(messagebm == null) {
			return 1;
		}
		String autolock = getAutoLockString(messagebm);
		String lock = getLockString(messagebm);
		String Gpsshell = StringUtil.nvl2(messagebm.getGpsshell());
		String Gpsantenna = StringUtil.nvl2(messagebm.getGpsantenna());
		String Voltage = StringUtil.nvl2(messagebm.getVoltage());
		if (!Gpsshell.equals("") && Gpsshell.equals("外壳闭合")
				&& !Gpsantenna.equals("") && Gpsantenna.equals("正常")
				&& !Voltage.equals("") && !autolock.equals("") && autolock.equals("正常")
				&& !lock.equals("") && lock.equals("正常")) {
			try {
				String vol = messagebm.getVoltage().substring(0, messagebm.getVoltage().length() - 1);
				int intVol = Integer.parseInt(vol);
				// 电压小于5伏则报警
				if (intVol > 5)
					return 0;
			} catch (Exception e) {
			}
			return 0;
		}
		return 1;
	}
	/***
	 * @author haibing.xiao
	 * 新增车辆编号 、设备编号、SIM编号唯一性检验
	 * */
	@RequestMapping(value="jsp/vechiclemanager/ajaxVehicle")
	public void ajaxVehicle(HttpServletRequest request, HttpServletResponse response){
		
		try {
			Car pojo =new Car();
			new BeanHandler<Car>(Car.class).handlerTrim(request, pojo);
			IRelationService service =new RelationServiceImpl();
			List<Car> list =service.queryAll(pojo);
			Map<String,String> map =new HashMap<String,String>();
			if(list!=null && list.size()>0){
				if(!StringUtil.isEmpty(pojo.getDeviceid())){
					map.put("message", "deviceid");
				}else if(!StringUtil.isEmpty(pojo.getVehicleid())){
					map.put("message", "vehicleid");
				}else if(!StringUtil.isEmpty(pojo.getSim())){
					map.put("message", "sim");
				}
				map.put("error", "1");
			}else{
				map.put("message", "ok");
				map.put("error", "0");
			}
			
			response.getWriter().write(JSONObject.fromObject(map).toString());
		} catch (IOException e) {
			e.printStackTrace();
			log.debug(e.getStackTrace());
		} catch (Exception e) {
			e.printStackTrace();
			log.debug(e.getStackTrace());
		}
	}
}
