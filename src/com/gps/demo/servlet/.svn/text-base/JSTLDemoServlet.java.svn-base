package com.gps.demo.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gps.login.entity.Account;

@Controller
public class JSTLDemoServlet {

	private Logger log =Logger.getLogger(JSTLDemoServlet.class);
	@RequestMapping(value="jstldemo")
	public void jstldemo(HttpServletRequest request, HttpServletResponse response){
		
		Account account = new Account("11111111111", "jstldemo", "rootroot", "null", 1, 1);
		
		request.getSession().setAttribute("account", account);//将对象写入Session
		
		String data = "测试JSTL成功";
		request.setAttribute("data", data);       //将data写入request中
		
		String type = "0";
		request.setAttribute("type", type);       //将type写入request中
		
		//数据放在request里以后如果用forward转到显示页然后用el表达式还是能取到request的值的，如果是redirect就取不到了
		try {
			request.getRequestDispatcher("jsp/demo/demo_jstl.jsp").forward(request, response);
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
