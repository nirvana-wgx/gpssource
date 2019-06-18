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
import com.gps.common.util.MathUtil;
import com.gps.common.util.StringUtil;
import com.gps.login.entity.Account;
import com.gps.vehiclemng.service.CommandoriginServiceImpl;
import com.gps.vehiclemng.service.ICommandoriginService;
import com.gps.vehiclemng.service.IMessageoriginService;
import com.gps.vehiclemng.service.IQueryPowersService;
import com.gps.vehiclemng.service.MessageoriginServiceImpl;
import com.gps.vehiclemng.service.QueryPowersServiceImpl;

@Controller
public class HistoryInfServlet {

	private Logger log =Logger.getLogger(HistoryInfServlet.class);
	
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/HistoryInf")
	public void getHistoryInf(HttpServletRequest request, HttpServletResponse response) {
		String historytype = StringUtil.nvl2(request.getParameter("historytype"));
		String serstarttime = StringUtil.nvl2(request.getParameter("serstarttime"));
		String serendtime = StringUtil.nvl2(request.getParameter("serendtime"));
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));
		int page_no = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_no")).trim());          //第N页
		int page_num = MathUtil.parseInt(StringUtil.nvl2(request.getParameter("page_num")).trim());        //每页个数
		
		if(!historytype.equals("1") && !historytype.equals("2")) {
			historytype = "1";
		}
		
		Account account = (Account) request.getSession().getAttribute(Constants.LOGIN_USER);
		String login_name = account.getName();
		IQueryPowersService querypowersservice = new QueryPowersServiceImpl();
		
		try {
			if(!querypowersservice.isExistPowers(login_name, "lscxqx")) {
				return;
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			return;
		}
		
		boolean start_null = false;
		boolean end_null = false;
		if(serstarttime.equals("")) {
			start_null = true;
			serstarttime = "1900-01-01 00:00:00";
		}
		
		if(serendtime.equals("")) {
			end_null = true;
			serendtime = DateUtil.format(new Date(), "yyyy-MM-dd HH:mm:ss");
		}
		
		if(page_num == 0) {
			page_num = 10;
		}
		if(page_no == 0) {
			page_no = 1;
		}
		
		String listtype = "";
		List<Object> objlist =  new ArrayList<Object>();
		int tot_num = 0;
		int tot_page = 0;
		
		if(historytype.equals("1")) {
			listtype = "messageoriginlist";
			IMessageoriginService messageoriginservice = new MessageoriginServiceImpl();
			try {
				tot_num = messageoriginservice.getMessageoriginCount(deviceid, serstarttime, serendtime);
				tot_page = getPagenum(tot_num, page_num);
				if(tot_num != 0) {
					objlist.addAll(messageoriginservice.getMessageoriginList(deviceid, serstarttime, serendtime, page_no, page_num));
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				log.debug(e.getMessage());
				return;
			}
		}
		
		if(historytype.equals("2")) {
			listtype = "commandoriginlist";
			ICommandoriginService commandoriginservice = new CommandoriginServiceImpl();
			try {
				tot_num = commandoriginservice.getCommandoriginCount(deviceid, serstarttime, serendtime);
				tot_page = getPagenum(tot_num, page_num);
				if(tot_num != 0) {
					objlist.addAll(commandoriginservice.getCommandoriginList(deviceid, serstarttime, serendtime, page_no, page_num));
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				log.debug(e.getMessage());
				return;
			}
		}
		
		request.setAttribute("historytype", historytype);
		request.setAttribute("deviceid", deviceid);
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
		
		request.setAttribute("page_no", page_no);
		request.setAttribute("tot_page", tot_page);
		request.setAttribute("page_num", page_num);
		request.setAttribute(listtype, objlist);
		
		//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
		try {
			request.getRequestDispatcher("history_info.jsp").forward(request, response);
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
