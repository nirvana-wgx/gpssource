package com.gps.vehiclemng.servlet;

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
import com.gps.common.util.GetPosition;
import com.gps.common.util.MathUtil;
import com.gps.common.util.StringUtil;
import com.gps.login.entity.Account;
import com.gps.statistics.entity.Relation;
import com.gps.vehiclemng.entity.Messagebm;
import com.gps.vehiclemng.service.IMessagebmService;
import com.gps.vehiclemng.service.MessagebmServiceImpl;

@Controller
public class VehicleSearchServlet {

	private Logger log =Logger.getLogger(FastTipsServlet.class);
	
	@RequestMapping(value="jsp/vechiclemanager/VehicleSearchJsp")
	public void getVehicleSearchJsp(HttpServletRequest request, HttpServletResponse response) {
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));
		request.setAttribute("deviceid", deviceid);
		
		//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
		try {
			request.getRequestDispatcher("singlevechile_search.jsp").forward(request, response);
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
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="jsp/vechiclemanager/VehicleSearch")
	public void getVehicleSearch(HttpServletRequest request, HttpServletResponse response) {
		HashMap<String,Object> parameters = new HashMap<String,Object>();
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));
		String flg = StringUtil.nvl2(request.getParameter("flg"));
		int page_no = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_no")).trim());          //第N页
		int page_num = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_num")).trim());        //每页个数
		
		if(page_num == 0) {
			page_num = 20;
		}
		if(page_no == 0) {
			page_no = 1;
		}
		
		com.gps.statistics.service.IRelationService relationservice = new com.gps.statistics.service.RelationServiceImpl();
		Account account = (Account) request.getSession().getAttribute(Constants.LOGIN_USER);
		String login_name = account.getName();
		List<Relation> list = new ArrayList<Relation>();
		try {
			if(flg.equals("1")) {
				parameters = (HashMap<String,Object>) request.getSession().getAttribute("vehicleser_param");
				deviceid = (String) parameters.get("deviceid");
			}
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
		
		if(!type_name.equals("")) {
			relation.setType(type_name);
		}
		
		if(flg.equals("1")) {
			int start = getStartNum(page_no, page_num);
			int end = getEndNum(page_no, page_num);
			parameters.put("start", start);
			parameters.put("end", end);
		} else {
			parameters.put("vehicleid", relation.getVehicleid());
			parameters.put("deviceid", relation.getDeviceid());
			parameters.put("tablename", relation.getTablename());
			parameters.put("start", 1);
			parameters.put("end", 20);

			String isreceivetime = request.getParameter("isreceivetime");
			if (isreceivetime != null) {
				String receivetimemin = request.getParameter("receivetimemin");
				String receivetimemax = request.getParameter("receivetimemax");
				if (receivetimemin != null && receivetimemin.length() != 0) {
					parameters.put("receivetimemin", receivetimemin);
				}
				if (receivetimemax != null && receivetimemax.length() != 0) {
					parameters.put("receivetimemax", receivetimemax);
				}
			}
			
			String isinfotype = request.getParameter("isinfotype");
			if (isinfotype != null) {
				String infotype = request.getParameter("infotype");
				if (infotype != null && infotype.length() != 0) {
					parameters.put("infotype", infotype);
				}
			}
			
			String isgpslocate = request.getParameter("isgpslocate");
			if (isgpslocate != null) {
				String gpslocate = request.getParameter("gpslocate");
				if (gpslocate != null && gpslocate.length() != 0) {
					parameters.put("gpslocate", gpslocate);
				}
			}
			
			String isgpsshell = request.getParameter("isgpsshell");
			if (isgpsshell != null) {
				String gpsshell = request.getParameter("gpsshell");
				if (gpsshell != null && gpsshell.length() != 0) {
					parameters.put("gpsshell", gpsshell);
				}
			}
			
			String isgpsantenna = request.getParameter("isgpsantenna");
			if (isgpsantenna != null) {
				String gpsantenna = request.getParameter("gpsantenna");
				if (gpsantenna != null && gpsantenna.length() != 0) {
					parameters.put("gpsantenna", gpsantenna);
				}
			}
			
			String isgpsrelay1 = request.getParameter("isgpsrelay1");
			if (isgpsrelay1 != null) {
				String gpsrelay1 = request.getParameter("gpsrelay1");
				if (gpsrelay1 != null && gpsrelay1.length() != 0) {
					parameters.put("gpsrelay1", gpsrelay1);
				}
			}
			
			String isgpsrelay2 = request.getParameter("isgpsrelay2");
			if (isgpsrelay2 != null) {
				String gpsrelay2 = request.getParameter("gpsrelay2");
				if (gpsrelay2 != null && gpsrelay2.length() != 0) {
					parameters.put("gpsrelay2", gpsrelay2);
				}
			}
			
			String isgpsrelay3 = request.getParameter("isgpsrelay3");
			if (isgpsrelay3 != null) {
				String gpsrelay3 = request.getParameter("gpsrelay3");
				if (gpsrelay3 != null && gpsrelay3.length() != 0) {
					parameters.put("gpsrelay3", gpsrelay3);
				}
			}
			
			String isgpsrelay4 = request.getParameter("isgpsrelay4");
			if (isgpsrelay4 != null) {
				String gpsrelay4 = request.getParameter("gpsrelay4");
				if (gpsrelay4 != null && gpsrelay4.length() != 0) {
					parameters.put("gpsrelay4", gpsrelay4);
				}
			}
			
			String isgpssleep = request.getParameter("isgpssleep");
			if (isgpssleep != null) {
				String gpssleep = request.getParameter("gpssleep");
				if (gpssleep != null && gpssleep.length() != 0) {
					parameters.put("gpssleep", gpssleep);
				}
			}
			
			String isgpsminitor = request.getParameter("isgpsminitor");
			if (isgpsminitor != null) {
				String gpsminitor = request.getParameter("gpsminitor");
				if (gpsminitor != null && gpsminitor.length() != 0) {
					parameters.put("gpsminitor", gpsminitor);
				}
			}
			
			String isgpspattern = request.getParameter("isgpspattern");
			if (isgpspattern != null) {
				String gpspattern = request.getParameter("gpspattern");
				if (gpspattern != null && gpspattern.length() != 0) {
					parameters.put("gpspattern", gpspattern);
				}
			}
			
			String isgpsautolocktwomonth = request.getParameter("isgpsautolocktwomonth");
			if (isgpsautolocktwomonth != null) {
				String gpsautolocktwomonth = request.getParameter("gpsautolocktwomonth");
				if (gpsautolocktwomonth != null && gpsautolocktwomonth.length() != 0) {
					parameters.put("gpsautolocktwomonth", gpsautolocktwomonth);
				}
			}
			
			String isgpsautolockshell = request.getParameter("isgpsautolockshell");
			if (isgpsautolockshell != null) {
				String gpsautolockshell = request.getParameter("gpsautolockshell");
				if (gpsautolockshell != null && gpsautolockshell.length() != 0) {
					parameters.put("gpsautolockshell", gpsautolockshell);
				}
			}
			
			String isgpsautolockantenna = request.getParameter("isgpsautolockantenna");
			if (isgpsautolockantenna != null) {
				String gpsautolockantenna = request.getParameter("gpsautolockantenna");
				if (gpsautolockantenna != null && gpsautolockantenna.length() != 0) {
					parameters.put("gpsautolockantenna", gpsautolockantenna);
				}
			}
			
			String isgpsautolockmain = request.getParameter("isgpsautolockmain");
			if (isgpsautolockmain != null) {
				String gpsautolockmain = request.getParameter("gpsautolockmain");
				if (gpsautolockmain != null && gpsautolockmain.length() != 0) {
					parameters.put("gpsautolockmain", gpsautolockmain);
				}
			}
			
			String iscarengine = request.getParameter("iscarengine");
			if (iscarengine != null) {
				String carengine = request.getParameter("carengine");
				if (carengine != null && carengine.length() != 0) {
					parameters.put("carengine", carengine);
				}
			}
			
			String iscarkey = request.getParameter("iscarkey");
			if (iscarkey != null) {
				String carkey = request.getParameter("carkey");
				if (carkey != null && carkey.length() != 0) {
					parameters.put("carkey", carkey);
				}
			}
			
			String isvoltage = request.getParameter("isvoltage");
			if (isvoltage != null) {
				String voltagemin = request.getParameter("voltagemin");
				String voltagemax = request.getParameter("voltagemax");
				if (voltagemin != null && voltagemin.length() != 0) {
					parameters.put("voltagemin", voltagemin + "伏");
				}
				if (voltagemax != null && voltagemax.length() != 0) {
					parameters.put("voltagemax", voltagemax + "伏");
				}
			}
			
			String isworktime = request.getParameter("isworktime");
			if (isworktime != null) {
				String worktimemin = request.getParameter("worktimemin");
				String worktimemax = request.getParameter("worktimemax");
				if (worktimemin != null && worktimemin.length() != 0) {
					parameters.put("worktimemin", worktimemin + "小时");
				}
				if (worktimemax != null && worktimemax.length() != 0) {
					parameters.put("worktimemax", worktimemax + "小时");
				}
			}
			
			String iswatertemperature = request.getParameter("iswatertemperature");
			if (iswatertemperature != null) {
				String watertemperaturemin = request.getParameter("watertemperaturemin");
				String watertemperaturemax = request.getParameter("watertemperaturemax");
				if (watertemperaturemin != null && watertemperaturemin.length() != 0) {
					parameters.put("watertemperaturemin", watertemperaturemin + "度");
				}
				if (watertemperaturemax != null && watertemperaturemax.length() != 0) {
					parameters.put("watertemperaturemax", watertemperaturemax + "度");
				}
			}
			
			String isoiltemperature = request.getParameter("isoiltemperature");
			if (isoiltemperature != null) {
				String oiltemperaturemin = request.getParameter("oiltemperaturemin");
				String oiltemperaturemax = request.getParameter("oiltemperaturemax");
				if (oiltemperaturemin != null && oiltemperaturemin.length() != 0) {
					parameters.put("oiltemperaturemin", oiltemperaturemin + "度");
				}
				if (oiltemperaturemax != null && oiltemperaturemax.length() != 0) {
					parameters.put("oiltemperaturemax", oiltemperaturemax + "度");
				}
			}
			
			String isoilpressure = request.getParameter("isoilpressure");
			if (isoilpressure != null) {
				String oilpressuremin = request.getParameter("oilpressuremin");
				String oilpressuremax = request.getParameter("oilpressuremax");
				if (oilpressuremin != null && oilpressuremin.length() != 0) {
					parameters.put("oilpressuremin", oilpressuremin + "MPa");
				}
				if (oilpressuremax != null && oilpressuremax.length() != 0) {
					parameters.put("oilpressuremax", oilpressuremax + "MPa");
				}
			}
			
			String isoillevel = request.getParameter("isoillevel");
			if (isoillevel != null) {
				String oillevelmin = request.getParameter("oillevelmin");
				String oillevelmax = request.getParameter("oillevelmax");
				if (oillevelmin != null && oillevelmin.length() != 0) {
					parameters.put("oillevelmin", oillevelmin + "%");
				}
				if (oillevelmax != null && oillevelmax.length() != 0) {
					parameters.put("oillevelmax", oillevelmax + "%");
				}
			}
			
			String isrotaryspeed = request.getParameter("isrotaryspeed");
			if (isrotaryspeed != null) {
				String rotaryspeedmin = request.getParameter("rotaryspeedmin");
				String rotaryspeedmax = request.getParameter("rotaryspeedmax");
				if (rotaryspeedmin != null && rotaryspeedmin.length() != 0) {
					parameters.put("rotaryspeedmin", rotaryspeedmin + "转/分");
				}
				if (rotaryspeedmax != null && rotaryspeedmax.length() != 0) {
					parameters.put("rotaryspeedmax", rotaryspeedmax + "转/分");
				}
			}
			
			String iswarncode = request.getParameter("iswarncode");
			if (iswarncode != null) {
				String warncode = request.getParameter("warncode");
				if (warncode != null && warncode.length() != 0) {
					parameters.put("warncode", warncode);
				}
			}
			
			String iscollecttime = request.getParameter("iscollecttime");
			if (iscollecttime != null) {
				String collecttimemin = request.getParameter("collecttimemin");
				String collecttimemax = request.getParameter("collecttimemax");
				if (collecttimemin != null && collecttimemin.length() != 0) {
					parameters.put("collecttimemin", collecttimemin);
				}
				if (collecttimemax != null && collecttimemax.length() != 0) {
					parameters.put("collecttimemax", collecttimemax);
				}
			}
			
			String isbackup = request.getParameter("isbackup");
			if (isbackup != null) {
				String backupmin = request.getParameter("backupmin");
				String backupmax = request.getParameter("backupmax");
				if (backupmin != null && backupmin.length() != 0) {
					parameters.put("backupmin", backupmin + "伏");
				}
				if (backupmax != null && backupmax.length() != 0) {
					parameters.put("backupmax", backupmax + "伏");
				}
			}
			
			String isenvtemperature = request.getParameter("isenvtemperature");
			if (isenvtemperature != null) {
				String envtemperaturemin = request.getParameter("envtemperaturemin");
				String envtemperaturemax = request.getParameter("envtemperaturemax");
				if (envtemperaturemin != null && envtemperaturemin.length() != 0) {
					parameters.put("envtemperaturemin", envtemperaturemin + "度");
				}
				if (envtemperaturemax != null && envtemperaturemax.length() != 0) {
					parameters.put("envtemperaturemax", envtemperaturemax + "度");
				}
			}			
		}
		
		
		IMessagebmService messagebmservice = new MessagebmServiceImpl();
		List<Messagebm> messagebmlist = new ArrayList<Messagebm>();
		int tot_num = 0;
		try {
			tot_num = messagebmservice.getMessagebmListCount(parameters);
			if(tot_num != 0) {
				messagebmlist = messagebmservice.getMessagebmList(parameters);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			int tot_page = getPagenum(tot_num, page_num);
			
			for(int i = 0; i < messagebmlist.size(); i++) {
				Messagebm mes = messagebmlist.get(i);
				String position = GetPosition.getPositionByXY(mes.getLongitude(), mes.getLatitude());
				messagebmlist.get(i).setPositioninfo(position);
			}
			
			request.setAttribute("messagebmlist", messagebmlist);
			request.setAttribute("relation", relation);
			request.getSession().setAttribute("vehicleser_param", parameters);
			request.setAttribute("page_no", page_no);
			request.setAttribute("tot_page", tot_page);
			request.setAttribute("page_num", page_num);
			//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
			try {
				request.getRequestDispatcher("vechilesearch_list.jsp").forward(request, response);
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
	}
	
	private static int getPagenum(int tot_num, int page_num) {
		if(tot_num % page_num == 0) {
			return tot_num / page_num;
		} else {
			return tot_num / page_num + 1;
		}
	}
	
	private int getStartNum(int page_no, int page_num) {
		return page_num * ( page_no - 1) + 1;
	}
	
	private int getEndNum(int page_no, int page_num) {
		return page_num * ( page_no - 1) + page_num;
	}
}
