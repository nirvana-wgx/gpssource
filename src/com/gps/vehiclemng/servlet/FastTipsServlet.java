package com.gps.vehiclemng.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gps.common.util.Constants;
import com.gps.common.util.DateUtil;
import com.gps.common.util.GetPosition;
import com.gps.common.util.StringUtil;
import com.gps.login.entity.Account;
import com.gps.statistics.entity.Relation;
import com.gps.vehiclemng.entity.Messagebm;
import com.gps.vehiclemng.service.IMessagebmService;
import com.gps.vehiclemng.service.MessagebmServiceImpl;

@Controller
public class FastTipsServlet {

	private Logger log =Logger.getLogger(FastTipsServlet.class);
	
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/FastTips")
	public void getFastTips(HttpServletRequest request, HttpServletResponse response) {
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));
		String serchdate = StringUtil.nvl2(request.getParameter("serchdate"));		
		
		if(serchdate.equals("") || DateUtil.parse(serchdate, "yyyy-MM-dd HH:mm:ss") == null) {
			serchdate = DateUtil.format(new Date(), "yyyy-MM-dd HH:mm:ss");
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
		
		IMessagebmService messagebmservice = new MessagebmServiceImpl();
		Messagebm messagebm = new Messagebm();
		String AutoLockString = "";
		String LockString = "";
		int isWarnZDBJ = 0;
		try {
			messagebm = messagebmservice.getLastByReceivetime(deviceid, serchdate, relation.getTablename());
			if(messagebm == null) {
				messagebm = messagebmservice.getLastByReceivetime(deviceid, "", relation.getTablename());
			}
			AutoLockString = getAutoLockString(messagebm);
			LockString = getLockString(messagebm);
			isWarnZDBJ = isWarnZDBJ(messagebm);
		} catch (SQLException e1) {
			e1.printStackTrace();
			log.debug(e1.getMessage());
		} finally {
			String position = "";
			if(messagebm != null) {
				position = GetPosition.getPositionByXY(messagebm.getLongitude(), messagebm.getLatitude());
				messagebm.setPositioninfo(position);
			}
			
			request.setAttribute("messagebm", messagebm);
			request.setAttribute("AutoLockString", AutoLockString);
			request.setAttribute("LockString", LockString);
			request.setAttribute("isWarnZDBJ", isWarnZDBJ);
			request.setAttribute("serchdate", serchdate);
			request.setAttribute("deviceid", deviceid);
			
			//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
			try {
				request.getRequestDispatcher("fasttips.jsp").forward(request, response);
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
	
	
	// 自锁车状态
	public static String getAutoLockString(Messagebm messagebm) {
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
		String Gpsshell = StringUtil.nvl2(messagebm.getGpsshell());
		String Gpsantenna = StringUtil.nvl2(messagebm.getGpsantenna());
		String Voltage = StringUtil.nvl2(messagebm.getVoltage());
		if (!Gpsshell.equals("") && Gpsshell.equals("外壳闭合")
				&& !Gpsantenna.equals("") && Gpsantenna.equals("正常")
				&& !Voltage.equals("")) {
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
}
