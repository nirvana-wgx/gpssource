package com.gps.vehiclemng.servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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

import com.gps.account.entity.Dictionary;
import com.gps.account.service.DictionaryServiceImpl;
import com.gps.account.service.IDictionaryService;
import com.gps.common.util.BeanHandler;
import com.gps.common.util.Constants;
import com.gps.common.util.DateUtil;
import com.gps.common.util.ExportExcel;
import com.gps.common.util.MathUtil;
import com.gps.common.util.StringUtil;
import com.gps.login.entity.Account;
import com.gps.statistics.entity.Relation;
import com.gps.vehiclemng.entity.Car;
import com.gps.vehiclemng.entity.Commandorigin;
import com.gps.vehiclemng.entity.Refund;
import com.gps.vehiclemng.service.CommandoriginServiceImpl;
import com.gps.vehiclemng.service.ICommandoriginService;
import com.gps.vehiclemng.service.IRefundService;
import com.gps.vehiclemng.service.RefundServiceImpl;


@Controller
public class RefundServlet {

	private Logger log =Logger.getLogger(RefundServlet.class);
	
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/Refund")
	public void getRefund(HttpServletRequest request, HttpServletResponse response) {
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));
		String serstarttime = StringUtil.nvl2(request.getParameter("serstarttime"));
		String serendtime = StringUtil.nvl2(request.getParameter("serendtime"));
		int page_no = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_no")).trim());          //第N页
		int page_num = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_num")).trim());        //每页个数
		if(page_num == 0) {
			page_num = 5;
		}
		if(page_no == 0) {
			page_no = 1;
		}
		
		boolean start_null = false;
		boolean end_null = false;
		if(serstarttime.equals("")) {
			start_null = true;
			serstarttime = "1900-01-01";
		}
		
		if(serendtime.equals("")) {
			end_null = true;
			serendtime = DateUtil.format(new Date(), "yyyy-MM-dd");
		}
		
		IRefundService refundservice = new RefundServiceImpl();
		
		int tot_num;
		try {
			tot_num = refundservice.getRefundCount(deviceid, serstarttime, serendtime);
		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
			log.debug(e2.getMessage());
			return;
		}
		
		int tot_page = getPagenum(tot_num, page_num);
		
		List<Refund> refundlist = new ArrayList<Refund>();
		if(tot_num != 0) {
			try {
				refundlist = refundservice.getRefundList(deviceid, serstarttime, serendtime, page_no, page_num);
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				log.debug(e1.getMessage());
				return;
			}
		}
		
		if(start_null) {
			request.setAttribute("serstarttime", "");
		} else {
			request.setAttribute("serstarttime", serstarttime);
		}
		
		if(end_null) {
			request.setAttribute("serendtime", "");
		} else {
			request.setAttribute("serendtime", serendtime);
		}
		request.setAttribute("deviceid", deviceid);
		request.setAttribute("refundlist", refundlist);
		request.setAttribute("page_no", page_no);
		request.setAttribute("tot_page", tot_page);
		request.setAttribute("page_num", page_num);

		try {
			request.getRequestDispatcher("refund_list.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
			log.debug(e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
			log.debug(e.getMessage());
		}
		
	}
	/**
	 *车辆还款保存 
	 */
	@RequestMapping(value="jsp/vechiclemanager/refunderVehicle")
	public void refunderVehicle(HttpServletRequest request, HttpServletResponse response){
		Refund pojo =new Refund();
		try {
			new BeanHandler<Refund>(Refund.class).handlerTrim(request, pojo);
			IRefundService service =new RefundServiceImpl();
			int result =service.save(pojo);
			 Map<String,String> map =new HashMap<String, String>();
			 map.put("message", String.valueOf(result));
			 response.getWriter().write(JSONObject.fromObject(map).toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/***
	 * 下发指令保存
	 * 
	 ***/
	@RequestMapping(value="jsp/vechiclemanager/updicateSend")
	public void updicateSend(HttpServletRequest request, HttpServletResponse response){
		 Car car =new Car();
		 try {
			new BeanHandler<Car>(Car.class).handlerTrim(request, car);
			request.setAttribute("car", car);
			Account account =(Account) request.getSession().getAttribute(Constants.LOGIN_USER);
			String cname =account.getName();
			IDictionaryService service =new DictionaryServiceImpl();
			Dictionary dictionary=new Dictionary();
			if(!"root".equals(cname)){
				dictionary.setName(cname);
			}
			//锁车命令
			dictionary.setD_type("scml");
			List<Dictionary> list_scml=service.queryByDictionary(dictionary);
			request.setAttribute("list_scml", list_scml);
			//下发命令
			dictionary.setD_type("xfml");
			List<Dictionary> list_xfml=service.queryByDictionary(dictionary);
			request.setAttribute("list_xfml",list_xfml);
			//自锁车命令
			dictionary.setD_type("zscml");
			List<Dictionary> list_zscml=service.queryByDictionary(dictionary);
			request.setAttribute("list_zscml", list_zscml);
			//设备设置
			dictionary.setD_type("sbsz");
			List<Dictionary> list_sbsz=service.queryByDictionary(dictionary);
			request.setAttribute("list_sbsz", list_sbsz);
//			request.setAttribute("prefix_sbsz", "hms");
			//其他设置
			dictionary.setD_type("qtsz");
			List<Dictionary> list_qtsz=service.queryByDictionary(dictionary);
			request.setAttribute("list_qtsz", list_qtsz);
//			request.setAttribute("prefix_qtsz", "");
			
			
			//其他设备指令
			dictionary.setD_type("scms");
			List<Dictionary> list_scms=service.queryByDictionary(dictionary);
			request.setAttribute("list_scms", list_scms);
			
			
			car.setVehicleid(encode(car.getVehicleid()));
			
			String vehicleid=car.getDeviceid();
			vehicleid = vehicleid.substring(0, 2);
			if(vehicleid.endsWith("YW")){
				request.getRequestDispatcher("dictate_send_other_edit.jsp").forward(request, response);
			}else{
				request.getRequestDispatcher("dictate_send_edit.jsp").forward(request, response);
			}
//			log.info("response.......");
		} catch (Exception e) {
			e.printStackTrace();
		}
		 
	}
	@RequestMapping(value="jsp/vechiclemanager/dicateSend")
	public void dicateSend(HttpServletRequest request, HttpServletResponse response){
		 Car car =new Car();
		 try {
			new BeanHandler<Car>(Car.class).handlerTrim(request, car);
			request.setAttribute("car", car);
			car.setVehicleid(encode(car.getVehicleid()));
			commandAdd(request, response);
			request.getRequestDispatcher("dictate_send_edit.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 
	}
	
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/RefundDownload")
	public void getRefundDownload(HttpServletRequest request, HttpServletResponse response) {
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));
		String serstarttime = StringUtil.nvl2(request.getParameter("serstarttime"));
		String serendtime = StringUtil.nvl2(request.getParameter("serendtime"));
		
		if(serstarttime.equals("")) {
			serstarttime = "1900-01-01";
		}
		
		if(serendtime.equals("")) {
			serendtime = DateUtil.format(new Date(), "yyyy-MM-dd");
		}
		
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
		
		IRefundService refundservice = new RefundServiceImpl();
				
		List<Refund> refundlist = new ArrayList<Refund>();
		try {
			refundlist = refundservice.getRefundList(relation.getDeviceid(), serstarttime, serendtime, 1, 2000);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			log.debug(e1.getMessage());
			return;
		}

		List<String> title_list = new ArrayList<String>();
		title_list.add("还款金额(元)");
		title_list.add("还款时间");
		title_list.add("剩余金额(元)");
		
		List<List<String>> v_list = new ArrayList<List<String>>();
		
		for(int i = 0; i < refundlist.size(); i++) {
			List<String> data_list = new ArrayList<String>();
			data_list.add(refundlist.get(i).getRefundmoney());
			data_list.add(refundlist.get(i).getRefundtime());
			data_list.add(refundlist.get(i).getRemainmoney());
			v_list.add(data_list);
		}
		
		try {
			String filename = relation.getVehicleid() + "车辆还款记录.xls";
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
	
	private void commandAdd(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String deviceid = request.getParameter("deviceid");//设备编号
		String sim = request.getParameter("sim");//SIM
//		String vehicleid=request.getParameter("vehicleid");//SIM
		String command = request.getParameter("command");//命令代码--GE0001
		String parameter = "";
		if(null==command){
			command="";
		}
		if (command.equalsIgnoreCase("GE3007")
				|| command.equalsIgnoreCase("GE3011")
				|| command.equalsIgnoreCase("GE3015")) {
			String hms = request.getParameter("hms" + command);
			if(null==hms||"".equals(hms)) parameter="000100";//默认1分钟
			String[] hourarray = hms.split(":");
			if(hourarray.length!=3) parameter="000100";//默认1分钟
			
			String hour = hourarray[0];
			if (hour == null) hour = "00";
			hour = hour.trim();
			while (hour.length() < 2)
				hour = "0" + hour;
			String minute = hourarray[1];
			if (minute == null) minute = "00";
			minute = minute.trim();
			while (minute.length() < 2)
				minute = "0" + minute;
			String second = hourarray[2];
			if (second == null) second = "00";
			second = second.trim();
			while (second.length() < 2)
				second = "0" + second;
			parameter = hour + minute + second;
			if("000000".equals(parameter)) parameter = "000100";//默认1分钟
		} else if (command.equalsIgnoreCase("GE3017")) {
			String hour = request.getParameter("hour" + command);
			if (hour == null)
				hour = "00";
			hour = hour.trim();
			while (hour.length() < 2)
				hour = "0" + hour;
			String minute = request.getParameter("minute" + command);
			if (minute == null)
				minute = "00";
			minute = minute.trim();
			while (minute.length() < 2)
				minute = "0" + minute;
			parameter = hour + minute;
		} else if (command.equalsIgnoreCase("GE3005")) {
			String returntype = request.getParameter("returntype");
			String conntype = request.getParameter("conntype");
			String ipaddress1 = request.getParameter("ipaddress1");
			String ipaddress2 = request.getParameter("ipaddress2");
			String ipaddress3 = request.getParameter("ipaddress3");
			String ipaddress4 = request.getParameter("ipaddress4");
			String domainaddress = request.getParameter("domainaddress");
			String port = request.getParameter("port");
			int portNum = 80;
			try {
				portNum = Integer.parseInt(port);
			} catch (Exception e) {
			}
			port = String.valueOf(portNum);

			if (returntype != null && returntype.equalsIgnoreCase("01")) {
				if(conntype.equalsIgnoreCase("00")){
					if (ipaddress1 != null && ipaddress1.trim().length() != 0
							&& ipaddress2 != null
							&& ipaddress2.trim().length() != 0
							&& ipaddress3 != null
							&& ipaddress3.trim().length() != 0
							&& ipaddress4 != null
							&& ipaddress4.trim().length() != 0
							&& domainaddress != null
							&& domainaddress.trim().length() != 0) {
						int iplength1 = ipaddress1.trim().length();
						int iplength2 = ipaddress2.trim().length();
						int iplength3 = ipaddress3.trim().length();
						int iplength4 = ipaddress4.trim().length();
						int domainlength = domainaddress.trim().length();
						int portlength = port.trim().length();
						
						parameter = "0100" + iplength1 + iplength2 + iplength3
						+ iplength4 + ipaddress1 + ipaddress2
						+ ipaddress3 + ipaddress4 + "@" + domainlength
						+ portlength + domainaddress + port;
					}
				}else{
					if(ipaddress1 != null && ipaddress1.trim().length() != 0
							&& ipaddress2 != null
							&& ipaddress2.trim().length() != 0
							&& ipaddress3 != null
							&& ipaddress3.trim().length() != 0
							&& ipaddress4 != null
							&& ipaddress4.trim().length() != 0){
						int iplength1 = ipaddress1.trim().length();
						int iplength2 = ipaddress2.trim().length();
						int iplength3 = ipaddress3.trim().length();
						int iplength4 = ipaddress4.trim().length();
						int portlength = port.trim().length();
						parameter = "0101" + iplength1 + iplength2 + iplength3
						+ iplength4 + portlength + ipaddress1
						+ ipaddress2 + ipaddress3 + ipaddress4 + port;
					}
				}
				/*if (ipaddress1 != null && ipaddress1.trim().length() != 0
						&& ipaddress2 != null
						&& ipaddress2.trim().length() != 0
						&& ipaddress3 != null
						&& ipaddress3.trim().length() != 0
						&& ipaddress4 != null
						&& ipaddress4.trim().length() != 0
						&& domainaddress != null
						&& domainaddress.trim().length() != 0) {
					int iplength1 = ipaddress1.trim().length();
					int iplength2 = ipaddress2.trim().length();
					int iplength3 = ipaddress3.trim().length();
					int iplength4 = ipaddress4.trim().length();
					int domainlength = domainaddress.trim().length();
					int portlength = port.trim().length();

					if (conntype.equalsIgnoreCase("00")) {
						parameter = "0100" + iplength1 + iplength2 + iplength3
								+ iplength4 + ipaddress1 + ipaddress2
								+ ipaddress3 + ipaddress4 + "@" + domainlength
								+ portlength + domainaddress + port;
					} else {
						parameter = "0101" + iplength1 + iplength2 + iplength3
								+ iplength4 + portlength + ipaddress1
								+ ipaddress2 + ipaddress3 + ipaddress4 + port;
					}
				}*/
			} else if (returntype != null && returntype.equalsIgnoreCase("02")) {
				if (ipaddress1 != null && ipaddress1.trim().length() != 0
						&& ipaddress2 != null
						&& ipaddress2.trim().length() != 0
						&& ipaddress3 != null
						&& ipaddress3.trim().length() != 0
						&& ipaddress4 != null
						&& ipaddress4.trim().length() != 0
						&& domainaddress != null
						&& domainaddress.trim().length() != 0) {
					int iplength1 = ipaddress1.trim().length();
					int iplength2 = ipaddress2.trim().length();
					int iplength3 = ipaddress3.trim().length();
					int iplength4 = ipaddress4.trim().length();
					int domainlength = domainaddress.trim().length();
					int portlength = port.trim().length();

					if (conntype.equalsIgnoreCase("00")) {
						parameter = "0200" + iplength1 + iplength2 + iplength3
								+ iplength4 + ipaddress1 + ipaddress2
								+ ipaddress3 + ipaddress4 + "@" + domainlength
								+ portlength + domainaddress + port;
					} else {
						parameter = "0201" + iplength1 + iplength2 + iplength3
								+ iplength4 + portlength + ipaddress1
								+ ipaddress2 + ipaddress3 + ipaddress4 + port;
					}
				}
			} else if (returntype != null && returntype.equalsIgnoreCase("03")) {
				parameter = returntype;
			} else if (returntype != null && returntype.equalsIgnoreCase("04")) {
				parameter = returntype;
			}
		} else if (command.equalsIgnoreCase("GE3001")) {
			parameter = request.getParameter("num" + command);
		} else if (command.equalsIgnoreCase("GE3021")) {
			parameter = request.getParameter("num" + command);
			while (parameter.length() < 2)
				parameter = "0" + parameter;
		} else if (command.equalsIgnoreCase("LK5001")) {
			parameter = request.getParameter("state" + command);
			if (parameter.equals("00")) {
				command = "LK5003";
			}
			parameter = "";
		} else if (command.equalsIgnoreCase("LK5005")) {
			parameter = request.getParameter("state" + command);
			if (parameter.equals("00")) {
				command = "LK5007";
			}
			parameter = "";
		} else if (command.equalsIgnoreCase("LK5011")) {
			parameter = request.getParameter("state" + command);
			if (parameter.equals("00")) {
				command = "LK5013";
			}
			parameter = "";
		} else if (command.equalsIgnoreCase("LK5015")) {
			parameter = request.getParameter("state" + command);
			if (parameter.equals("00")) {
				command = "LK5017";
			}
			parameter = "";
		} else if (command.equalsIgnoreCase("LK5021")) {
			parameter = request.getParameter("state" + command);
			if (parameter.equals("00")) {
				command = "LK5023";
			}
			parameter = "";
		} else if (command.equalsIgnoreCase("GE3013")) {
			parameter = request.getParameter("stateGE3013");
		}else if (command.equalsIgnoreCase("GL0002")){
			parameter = request.getParameter("state" + command);
		}
		
		IDictionaryService service =new DictionaryServiceImpl();
		Dictionary dictionary=new Dictionary();
		if(!StringUtil.isEmpty(command)){
			dictionary.setD_code(command);
		}
		
		List<Dictionary> list =service.queryByDictionary(dictionary);
		String comment ="";
		for(Dictionary pojo:list){
			comment=pojo.getD_value();
		}
		if (comment == null || comment.trim().length() == 0) {
			comment = "不详";
		}
		System.out.println("--****************"+parameter+"===================");
		Commandorigin commandorigin = new Commandorigin();
		commandorigin.setDevice(deviceid);
		commandorigin.setSim(sim);
		commandorigin.setCommand(parameter+command);
		commandorigin.setDescrip(comment);
		commandorigin.setSendtime(Calendar.getInstance().getTime());
		commandorigin.setState("正在发送");
		Account account =(Account) request.getSession().getAttribute(Constants.LOGIN_USER);
		commandorigin.setUsername(account.getName());
		ICommandoriginService cmdService =new CommandoriginServiceImpl();
		cmdService.save(commandorigin);

		// 发送命令
		System.out.println("--==================="+parameter+"===================");
		String csid = commandorigin.getCoid();
		cmdService.send(sim, deviceid, command, parameter, csid);//手机号码、设备号、命令代码、组合的字符串、保存的命令记录的id
	}
	
	private static int getPagenum(int tot_num, int page_num) {
		if(tot_num % page_num == 0) {
			return tot_num / page_num;
		} else {
			return tot_num / page_num + 1;
		}
	}
}
