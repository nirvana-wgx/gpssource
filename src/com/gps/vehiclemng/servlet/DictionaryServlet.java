package com.gps.vehiclemng.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gps.account.entity.Dictionary;
import com.gps.account.service.DictionaryServiceImpl;
import com.gps.account.service.IDictionaryService;
import com.gps.common.util.BeanHandler;
import com.gps.common.util.Cache;
import com.gps.common.util.StringUtil;
/****
 * 
 * @author 肖海兵
 * 
 * 机械种类与机械型号控制器
 * 
 */
@Controller
public class DictionaryServlet {

	@RequestMapping(value="jsp/vechiclemanager/query")
	public void query(HttpServletRequest request, HttpServletResponse response) {
		try {
			String d_type=request.getParameter("d_type");
			String d_value=request.getParameter("d_value");
			
			String currentPage =request.getParameter("currentPage");
			String pageSize =request.getParameter("pageSize");
			
			IDictionaryService service =new DictionaryServiceImpl();
			Dictionary dictionary=new Dictionary();
			if(!StringUtil.isEmpty(d_value)){
				dictionary.setD_value("%"+d_value+"%");
				request.setAttribute("d_value", d_value);
			}
			dictionary.setStart(null);//不分页
			dictionary.setD_type(d_type);
			List<Dictionary> list =service.queryByDictionary(dictionary);
			
			dictionary.setStart(1);//分页
			if(!StringUtil.isEmpty(currentPage)){
				dictionary.setCurentPage(Integer.parseInt(currentPage));
			}else{
				currentPage=String.valueOf(dictionary.getCurentPage());
			}
			if(!StringUtil.isEmpty(pageSize)){
				dictionary.setPageSize(Integer.parseInt(pageSize));
			}else{
				pageSize =String.valueOf(dictionary.getPageSize());
			}
			request.setAttribute("total", list.size());
			double totalPage =  Math.ceil((double) list.size()/Integer.parseInt(pageSize));
			request.setAttribute("totalPage", (int)totalPage);
			
			list =service.queryByDictionary(dictionary);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("pageSize", pageSize);
			request.setAttribute("d_type", d_type);
			request.setAttribute("list", list);
			request.getRequestDispatcher("dictionary_list.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value="jsp/vechiclemanager/delete")
	public void delete(HttpServletRequest request, HttpServletResponse response) {
		
		try{
			String d_code =request.getParameter("d_code");
			IDictionaryService service =new DictionaryServiceImpl();
			Dictionary dictionary=new Dictionary();
			if(!StringUtil.isEmpty(d_code)){
				dictionary.setD_code(d_code);
			}
			service.delete(dictionary);
			query(request, response);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			
		}
		
	}
	
	@RequestMapping(value="jsp/vechiclemanager/update")
	public void update(HttpServletRequest request, HttpServletResponse response) {
		try{
			String d_code =request.getParameter("d_code");
			String d_type=request.getParameter("d_type");
			List<Dictionary> list =Cache.getTypes();
			Dictionary dictionary=new Dictionary();
			String d_typeName="";
			for(Dictionary pojo :list){
				if(pojo.getD_type().equals(d_type.trim())){
					d_typeName=pojo.getD_typeName();
					break;
				}
			}
			dictionary.setD_typeName(d_typeName);
			dictionary.setD_type(d_type);
			if(!StringUtil.isEmpty(d_code)){
				dictionary.setD_code(d_code);
				IDictionaryService service =new DictionaryServiceImpl();
				List<Dictionary> listparams =service.queryByDictionary(dictionary);
				if(listparams!=null && listparams.size()!=0){
					dictionary =listparams.get(0);
				}
			}
			request.setAttribute("dictionary", dictionary);
			request.getRequestDispatcher("dictionary_edit.jsp").forward(request, response);
			 
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			
		}
		
		
	}
	
	@RequestMapping(value="jsp/vechiclemanager/save")
	public void save(HttpServletRequest request, HttpServletResponse response) {
		try{
			Map<String,String> message =new HashMap<String,String>();
			String d_code =request.getParameter("d_code");
			int result =0;
			IDictionaryService service =new DictionaryServiceImpl();
			Dictionary dictionary=new Dictionary();
			new BeanHandler<Dictionary>(Dictionary.class).handlerTrim(request, dictionary);
			if(StringUtil.isEmpty(d_code)){
				result=service.save(dictionary);
			}else{
				result=service.update(dictionary);
			}
			if(result==0){
				message.put("message", "0");
			}else {
				message.put("message", "1");
			}
			response.getWriter().write(JSONObject.fromObject(message).toString());
			 
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			
		}
	}
}
