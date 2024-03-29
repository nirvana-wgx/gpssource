package com.gps.login.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import com.gps.login.entity.Menu;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gps.common.util.BeanHandler;
import com.gps.common.util.Cache;
import com.gps.common.util.Constants;
import com.gps.common.util.DateUtil;
import com.gps.common.util.StringUtil;
import com.gps.login.entity.Account;
import com.gps.login.entity.Loginlog;
import com.gps.login.service.AccountServiceImpl;
import com.gps.login.service.IAccountService;
import com.gps.login.service.ILoginlogService;
import com.gps.login.service.LoginlogServiceImpl;

/**
 * @author 肖海兵
 * 
 * @since jdk1.7
 * 
 * <p>系统用户登录</p>
 */
@Controller
public class LoginServlet {
	private Logger log = Logger.getLogger(LoginServlet.class);

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public void login(HttpServletRequest request, HttpServletResponse response) {
		Account account = new Account();
		
		
		
		try {
			new BeanHandler<Account>(Account.class).handlerTrim(request,account);
		} catch (Exception e) {
			e.printStackTrace();
			log.debug(e.getMessage());
		}//对象注入 ;
//		String pass = new MD5().getMD5(account.getPass());
//		account.setPass(pass);
		// 判断验证码
		String ccode = (String) request.getSession().getAttribute("ccode");
		String checkcode = request.getParameter("checkcode");
		 
		if (!(checkcode.equals(ccode))) {
			try {
				response.sendRedirect("login.jsp");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			 return;
		}

		IAccountService service =new AccountServiceImpl();
		Account queryAccount = null;
		try {
			queryAccount = service.findByNameAndPass(account);
		} catch (SQLException e) {
			e.printStackTrace();
			log.debug(e.getMessage());
		}
		
		Date date = new Date();
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			date = format.parse("2050-12-31");
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		if (new java.util.Date().after(date)) {
			try {
				response.sendRedirect("login.jsp");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return;//
		}

		if (queryAccount != null) {
			// 将当前账号加入账号Session中
			request.getSession().setAttribute(Constants.LOGIN_USER, queryAccount);
			// 保存登录记录
			String ip = request.getRemoteAddr();
			if (ip != null && ip.trim().length() != 0&& !ip.equals("127.0.0.1")) {
				ILoginlogService logService =new LoginlogServiceImpl(); 
				Loginlog loginlog = new Loginlog(account.getName(), request.getRemoteAddr(), new Date());
				 
				try {
					logService.save(loginlog);
				} catch (SQLException e) {
					e.printStackTrace();
					log.debug(e.getMessage());
				}
			}
			try {
				response.sendRedirect("index.jsp");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else{
			try {
				response.sendRedirect("login.jsp");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} 
		 
	}
	
	@RequestMapping(value = "header")
	public void header(HttpServletRequest request, HttpServletResponse response) {
		 
//		ILoginlogService logService =new LoginlogServiceImpl(); 
		try {
//			List<Menu> list =logService.selectHeadMenu();
			List<Menu> list=Cache.getMenu();
			 request.setAttribute("headerlist", list);
			 String date =DateUtil.format(Calendar.getInstance().getTime(),"yyyy-MM-dd");
			 request.setAttribute("gdate", ""+date);
			 request.getRequestDispatcher("header.jsp").forward(request, response);
			 
			 //log.info("header..........");
		}   catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 
 
	} 
	@RequestMapping(value = "exit")
	public void exit(HttpServletRequest request, HttpServletResponse response) {
		 
		request.getSession().removeAttribute(Constants.LOGIN_USER);
		try {
			response.sendRedirect("index.jsp");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 
	} 
	@RequestMapping(value = "leftMenu")
	public void leftMenu(HttpServletRequest request, HttpServletResponse response) {
	 
		ILoginlogService logService =new LoginlogServiceImpl(); 
		String parentCode =StringUtil.trim(request.getParameter("parentCode"));
		if("".equals(parentCode)){
			parentCode="2";
		}
		try {
//			List<Menu> list_ =logService.selectHeadMenu();
			List<Menu> list_ =Cache.getMenu();
			String menuTitle="";
			for(Menu pojo:list_){
				if(pojo.getCode().trim().equals(parentCode.trim())){
					menuTitle=pojo.getName();
					break;
				}
			}
			List<Menu> list =null;
			if("2".equals(parentCode)){
				 list=Cache.getLeftMenu();
			}else{
				  list =logService.selectLeftMenu(parentCode);
			}
			
			request.setAttribute("leftlist", list);
			request.setAttribute("menuTitle", menuTitle);
			request.getRequestDispatcher("leftMenu.jsp").forward(request, response);
			// log.info("leftMenu..........");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
	} 
	
	@RequestMapping(value="workContent")
	public void workContent(HttpServletRequest request, HttpServletResponse response) {
		
		 try {
			request.getRequestDispatcher("perspective_content.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	 
}
