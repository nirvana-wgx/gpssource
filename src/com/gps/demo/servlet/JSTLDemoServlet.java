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
		
		request.getSession().setAttribute("account", account);//������д��Session
		
		String data = "����JSTL�ɹ�";
		request.setAttribute("data", data);       //��dataд��request��
		
		String type = "0";
		request.setAttribute("type", type);       //��typeд��request��
		
		//���ݷ���request���Ժ������forwardת����ʾҳȻ����el���ʽ������ȡ��request��ֵ�ģ������redirect��ȡ������
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
