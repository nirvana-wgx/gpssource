package com.gps.common.interceptor;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import com.gps.common.util.Constants;

public class UserAccessFilter extends HttpServlet implements Filter {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
    String redirectURL ="/login.jsp";
//    private Logger logger =Logger.getLogger(UserAccessFilter.class);
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request =(HttpServletRequest) req;
		HttpServletResponse response =(HttpServletResponse) resp;
		String path =request.getContextPath();
		 
		
		String uri =request.getRequestURI();
		uri=uri.substring(path.length());
//		logger.info("uri "+uri);
		if(uri.equals("/login.jsp") || uri.equals("/jsp/image.jsp") || uri.equals("/login.page")){
			chain.doFilter(request, response);
		}else{
			Object object =request.getSession().getAttribute(Constants.LOGIN_USER);
			if(object==null){
				String location=path+redirectURL;
				response.sendRedirect(location);
			}else{
				chain.doFilter(request, response);
			}
			
		}
		 
		
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		 

	}

}
