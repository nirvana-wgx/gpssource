package com.gps.account.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
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

import com.gps.account.entity.AccountDictionary;
import com.gps.account.entity.Dictionary;
import com.gps.account.service.AccountManagerServiceImpl;
import com.gps.account.service.DictionaryServiceImpl;
import com.gps.account.service.IAccountMangerService;
import com.gps.account.service.IDictionaryService;
import com.gps.common.util.BeanHandler;
import com.gps.common.util.Constants;
import com.gps.common.util.StringUtil;
import com.gps.login.entity.Account;

 
/**
 * @author  Ф����
 * 
 * �˻�����
 * **********************/
@Controller
public class AccountManagerServlet {
	private Logger log = Logger.getLogger(AccountManagerServlet.class);
	private IAccountMangerService accountService =new AccountManagerServiceImpl();
	
	@RequestMapping(value="jsp/accountmanager/savePassword")
	public void savePassword(HttpServletRequest request, HttpServletResponse response){
		String password =StringUtil.trim(request.getParameter("newpassword"));
		Map<String,String> message =new HashMap<String,String>();
		Account account =(Account) request.getSession().getAttribute(Constants.LOGIN_USER);
		account.setPass(password);
		try {
			int result =accountService.updateAccountByAid(account,null);
			if(result==0){
				message.put("message", "0");
			}else {
				message.put("message", "1");
			}
			response.getWriter().write(JSONObject.fromObject(message).toString());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping(value="jsp/accountmanager/query")
	public void query(HttpServletRequest request, HttpServletResponse response){
		
		try {
			Account  params=(Account) request.getSession().getAttribute(Constants.LOGIN_USER);
			String name =StringUtil.trim(request.getParameter("name"));
			String parentname=StringUtil.trim(request.getParameter("parentname"));
			String currentPage =request.getParameter("currentPage");
			String pageSize =request.getParameter("pageSize");
			String cname=params.getName();
			params =new Account();
			params.setCname(cname);
			if(!StringUtil.isEmpty(name)){
				params.setName("%"+name+"%");
				request.setAttribute("name", name);
			}
			if(!StringUtil.isEmpty(parentname)){
				params.setParentname("%"+parentname+"%");
				request.setAttribute("parentname", parentname);
			}
			//total
			params.setStart(null);//����ҳ
			List<Account> list =accountService.findChildren(params);
			
			
			params.setStart(1);//��ҳ
			if(!StringUtil.isEmpty(currentPage)){
				params.setCurentPage(Integer.parseInt(currentPage));
			}else{
				currentPage=String.valueOf(params.getCurentPage());
			}
			if(!StringUtil.isEmpty(pageSize)){
				params.setPageSize(Integer.parseInt(pageSize));
			}else{
				pageSize =String.valueOf(params.getPageSize());
			}
			request.setAttribute("total", list.size());
			double totalPage =  Math.ceil((double) list.size()/Integer.parseInt(pageSize));
			request.setAttribute("totalPage", (int)totalPage);
			
			list =accountService.findChildren(params);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("pageSize", pageSize);
			request.setAttribute("list", list);
			request.getRequestDispatcher("account_manager_list.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.info(e.getMessage());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.info(e.getMessage());
		} catch (SQLException e) {
			// TODO Auto-generated catch blockLis
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="jsp/accountmanager/update")
	public void update(HttpServletRequest request, HttpServletResponse response){
		try {
			
			String type=request.getParameter("type");
			String name ="";
			Account params =(Account) request.getSession().getAttribute(Constants.LOGIN_USER);
			name=params.getName().trim();
			IDictionaryService dservice=new DictionaryServiceImpl();
			List<Dictionary> list =null;//
			if("add".equals(type)){
//				Account params =(Account) request.getSession().getAttribute(Constants.LOGIN_USER);
//				Account account =accountService.getAccount(params);
				if("root".equals(name.trim())){
					list=dservice.query();//��ѯ����
				}else{
					params =new Account();
					params.setName(name);//��ǰ��¼�û�
					list=dservice.queryByparms(params);//��ѯ�û�ӵ�е�Ȩ��
				}
				request.setAttribute("parentname", params.getName());
			}
			
			if("update".equals(type)){
				request.setAttribute("title",  "�˻���Ϣ�޸�");
				String aid =request.getParameter("aid");
				 
				//��ѯ�û�ӵ�е�Ȩ��,�����ǰ�û���ϵͳroot�û� ��ѯ����,�����ѯ��ǰ��¼�û�������Ȩ����Ϊ�¼��û����޸�Ȩ��
				if("root".equals(name.trim())){
					list=dservice.query();//��ѯ����
					
				}else{ 
					params =new Account();
					params.setName(name);//��ǰ��¼�û�
					list=dservice.queryByparms(params);//��ѯ��ǰ�û�ӵ�е�Ȩ��
				}
				List<String> $list=new ArrayList<String>();
				for(Dictionary pojo:list){
					$list.add(pojo.getD_code());
				}
				
				if(!StringUtil.isEmpty(aid)){ 
					params =new Account();
					params.setAid(aid);
					Account account =accountService.getAccount(params);
					request.setAttribute("parentname", account.getParentname());
					request.setAttribute("account", account);
					request.setAttribute("type", "modify");
					params =new Account();
					params.setName(account.getName());//��ǰ��¼�û�
					List<Dictionary> slist=dservice.queryByparms(params);//get �޸��û������Ȩ��
					List<String> $dlist=new ArrayList<String>();
					for(Dictionary pojo:slist){
						$dlist.add(pojo.getD_code());
					}
					$list.removeAll($dlist);
					String dstr =$list.toString();
					request.setAttribute("dstr", dstr);
 				}else{ 
					Account account =accountService.getAccount(params);
					request.setAttribute("parentname", account.getParentname());
					request.setAttribute("account", account);
					/*if("root".equals(name.trim())){
						list=dservice.query();//��ѯ����
					}else{ 
						params =new Account();
						params.setName(name);//��ǰ��¼�û�
						list=dservice.queryByparms(params);//��ѯ�û�ӵ�е�Ȩ��
					}*/
				}
				
				
			}
	 
			/*if("root".equals(name.trim())){
				list=dservice.query();//��ѯ����
			}else{
				
			}*/
			//jxlx --��е����
			List<Dictionary> list_jxlx =new ArrayList<Dictionary>();
			for(int i=0;i<list.size();i++){
				Dictionary pojo =list.get(i);
				if("jxlx".equals(pojo.getD_type())){
					list_jxlx.add(pojo);
				}
			}
			request.setAttribute("list_jxlx", list_jxlx);
			//clzt --�����鿴״̬ 
			List<Dictionary> list_clzt =new ArrayList<Dictionary>();
			for(int i=0;i<list.size();i++){
				Dictionary pojo =list.get(i);
				if("clzt".equals(pojo.getD_type())){
					list_clzt.add(pojo);
				}
			}
			request.setAttribute("list_clzt", list_clzt);
			//xfml --�·���������
			List<Dictionary> list_xfml =new ArrayList<Dictionary>();
			for(int i=0;i<list.size();i++){
				Dictionary pojo =list.get(i);
				if("xfml".equals(pojo.getD_type())){
					list_xfml.add(pojo);
				}
			}
			request.setAttribute("list_xfml", list_xfml);
			//scms --�ϴ�ģʽ����
			List<Dictionary> list_scms =new ArrayList<Dictionary>();
			for(int i=0;i<list.size();i++){
				Dictionary pojo =list.get(i);
				if("scms".equals(pojo.getD_type())){
					list_scms.add(pojo);
				}
			}
			request.setAttribute("list_scms", list_scms);
			//qtsz --��������
			List<Dictionary> list_qtsz =new ArrayList<Dictionary>();
			for(int i=0;i<list.size();i++){
				Dictionary pojo =list.get(i);
				if("qtsz".equals(pojo.getD_type())){
					list_qtsz.add(pojo);
				}
			}
			request.setAttribute("list_qtsz", list_qtsz);
			//sbsz --�豸����
			List<Dictionary> list_sbsz =new ArrayList<Dictionary>();
			for(int i=0;i<list.size();i++){
				Dictionary pojo =list.get(i);
				if("sbsz".equals(pojo.getD_type())){
					list_sbsz.add(pojo);
				}
			}
			request.setAttribute("list_sbsz", list_sbsz);
			//jxzl --��ѡ��е�����б�
			List<Dictionary> list_jxzl =new ArrayList<Dictionary>();
			for(int i=0;i<list.size();i++){
				Dictionary pojo =list.get(i);
				if("jxzl".equals(pojo.getD_type())){
					list_jxzl.add(pojo);
				}
			}
			request.setAttribute("list_jxzl", list_jxzl);
			//scml --�������� 
			List<Dictionary> list_scml =new ArrayList<Dictionary>();
			for(int i=0;i<list.size();i++){
				Dictionary pojo =list.get(i);
				if("scml".equals(pojo.getD_type())){
					list_scml.add(pojo);
				}
			}
			request.setAttribute("list_scml", list_scml);
			//zscml --����������
			List<Dictionary> list_zscml =new ArrayList<Dictionary>();
			for(int i=0;i<list.size();i++){
				Dictionary pojo =list.get(i);
				if("zscml".equals(pojo.getD_type())){
					list_zscml.add(pojo);
				}
			}
			request.setAttribute("list_zscml", list_zscml);
			//xslb  --��ʾ�б�
			List<Dictionary> list_xslb =new ArrayList<Dictionary>();
			for(int i=0;i<list.size();i++){
				Dictionary pojo =list.get(i);
				if("xslb".equals(pojo.getD_type())){
					list_xslb.add(pojo);
				}
			}
			request.setAttribute("list_xslb", list_xslb);
			
			request.getRequestDispatcher("account_manager_edit.jsp").forward(request, response);
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
	
	@RequestMapping(value="jsp/accountmanager/save")
	public void save(HttpServletRequest request, HttpServletResponse response){
		int result =0;
		Map<String,String> message =new HashMap<String,String>();
		try {
			String aid =request.getParameter("aid");
			List<AccountDictionary> list =new ArrayList<AccountDictionary>();
			initAccountDictionary(request,list);//����Ȩ������
			
			if(StringUtil.isEmpty(aid)){//��������
				
				Account account =new Account();
				new BeanHandler<Account>(Account.class).handlerTrim(request, account);
				account.setPass("123456");//init pass
				account.setMaxlevel(1);// init maxlevel
				result = accountService.saveAccount(account,list);
				message.put("message", String.valueOf(result));
				response.getWriter().write(JSONObject.fromObject(message).toString());
			}else{//�޸ı���
				 
				Account account =new Account();
				account.setAid(aid);
				account =accountService.getAccount(account);
				String maxchild =request.getParameter("maxchild");
				account.setMaxchild(Integer.valueOf(maxchild));
//				new BeanHandler<Account>(Account.class).handlerTrim(request, account);
				result =accountService.updateAccountByAid(account,list);
				message.put("message", String.valueOf(result));
				
				String type=request.getParameter("type");
				if(!StringUtil.isEmpty(type)){
					message.put("type",type);
				} 
				response.getWriter().write(JSONObject.fromObject(message).toString());
			}
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.info(e.getMessage());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.info(e.getMessage());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.info(e.getMessage());
			message.put("message", String.valueOf(result));
			try {
				response.getWriter().write(JSONObject.fromObject(message).toString());
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
	}
	
	@RequestMapping(value="jsp/accountmanager/delete")
	public void delete(HttpServletRequest request, HttpServletResponse response){
		
		try {
			String aid =StringUtil.trim(request.getParameter("aid"));
//			Account  params=(Account) request.getSession().getAttribute(Constants.LOGIN_USER);
			 
			Account account=new Account();
			account.setAid(aid);
			account=accountService.getAccount(account);
			accountService.deleteAccountByAid(account);
			query(request, response);
		}  catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * @author Ф����
	 *  ��֤����
	 * 
	 *********/
	@RequestMapping(value="jsp/accountmanager/ajaxPass")
	public void ajaxPass(HttpServletRequest request, HttpServletResponse response){
		 
 
		String password=request.getParameter("password");
		Account  account =(Account)request.getSession().getAttribute(Constants.LOGIN_USER);
		account.setPass(password);
		Map<String,String> message =new HashMap<String,String>();
		try {
			Account pojo=	accountService.getAccount(account);
			if(pojo==null){
				message.put("message", "0");
			}else{
				message.put("message", "1");
			}
			response.getWriter().write(JSONObject.fromObject(message).toString());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
	}
	/**
	 * @author Ф����
	 *  ��֤�û���Ψһ
	 * 
	 *********/
	@RequestMapping(value="jsp/accountmanager/ajaxUsername")
	public void ajaxUsername(HttpServletRequest request, HttpServletResponse response){
		String name=request.getParameter("name");
		Account  account = new Account();
		account.setName(name);
		Map<String,String> message =new HashMap<String,String>();
		try {
			Account pojo=	accountService.getAccount(account);
			if(pojo==null){
				message.put("message", "0");
			}else{
				message.put("message", "1");
			}
			response.getWriter().write(JSONObject.fromObject(message).toString());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
	}
	private void initAccountDictionary(HttpServletRequest request,List<AccountDictionary> list) throws Exception{
		String account_name =request.getParameter("name");
		//jxlx --��е����
		 String[] jxlx =request.getParameterValues("jxlx");
		 if(jxlx!=null){
			 for(int i=0;i<jxlx.length;i++){
				 AccountDictionary pojo =new AccountDictionary();
				 String d_code =jxlx[i];
				 pojo.setD_type("jxlx");
				 pojo.setD_code(d_code);
				 pojo.setAccount_name(account_name);
				 list.add(pojo);
			 }
		 }
		
		//clzt --�����鿴״̬ 
		 String[] clzt =request.getParameterValues("clzt");
		 if(clzt!=null){
			 for(int i=0;i<clzt.length;i++){
				 AccountDictionary pojo =new AccountDictionary();
				 String d_code =clzt[i];
				 pojo.setD_type("clzt");
				 pojo.setD_code(d_code);
				 pojo.setAccount_name(account_name);
				 list.add(pojo);
			 }
		 }
		 
		//xfml --�·���������
		 String[] xfml =request.getParameterValues("xfml");
		 if(xfml!=null){
			 for(int i=0;i<xfml.length;i++){
				 AccountDictionary pojo =new AccountDictionary();
				 String d_code =xfml[i];
				 pojo.setD_type("xfml");
				 pojo.setD_code(d_code);
				 pojo.setAccount_name(account_name);
				 list.add(pojo);
			 }
		 }
		
		//qtsz --��������
		 String[] qtsz =request.getParameterValues("qtsz");
		 if(qtsz!=null){
			 for(int i=0;i<qtsz.length;i++){
				 AccountDictionary pojo =new AccountDictionary();
				 String d_code =qtsz[i];
				 pojo.setD_type("qtsz");
				 pojo.setD_code(d_code);
				 pojo.setAccount_name(account_name);
				 list.add(pojo);
			 }
		 }
		 
	 
		//sbsz --�豸����
		 String[] sbsz =request.getParameterValues("sbsz");
		 if(sbsz!=null){
			 for(int i=0;i<sbsz.length;i++){
				 AccountDictionary pojo =new AccountDictionary();
				 String d_code =sbsz[i];
				 pojo.setD_type("sbsz");
				 pojo.setD_code(d_code);
				 pojo.setAccount_name(account_name);
				 list.add(pojo);
			 }
		 }
		 
		 
		//jxzl --��ѡ��е�����б�
		 String[] jxzl =request.getParameterValues("jxzl");
		 if(jxzl!=null){
			 for(int i=0;i<jxzl.length;i++){
				 AccountDictionary pojo =new AccountDictionary();
				 String d_code =jxzl[i];
				 pojo.setD_type("jxzl");
				 pojo.setD_code(d_code);
				 pojo.setAccount_name(account_name);
				 list.add(pojo);
			 }
		 }
		
		//scml --�������� 
		 String[] scml =request.getParameterValues("scml");
		 if(scml!=null){
			 for(int i=0;i<scml.length;i++){
				 AccountDictionary pojo =new AccountDictionary();
				 String d_code =scml[i];
				 pojo.setD_type("scml");
				 pojo.setD_code(d_code);
				 pojo.setAccount_name(account_name);
				 list.add(pojo);
			 }
		 }
		 
		//zscml --����������
		 String[] zscml =request.getParameterValues("zscml");
		 if(zscml!=null){
			 for(int i=0;i<zscml.length;i++){
				 AccountDictionary pojo =new AccountDictionary();
				 String d_code =zscml[i];
				 pojo.setD_type("zscml");
				 pojo.setD_code(d_code);
				 pojo.setAccount_name(account_name);
				 list.add(pojo);
			 }
		 }
		 
		//xslb  --��ʾ�б�
		 String[] xslb =request.getParameterValues("xslb");
		 if(xslb!=null){
			 for(int i=0;i<xslb.length;i++){
				 AccountDictionary pojo =new AccountDictionary();
				 String d_code =xslb[i];
				 pojo.setD_type("xslb");
				 pojo.setD_code(d_code);
				 pojo.setAccount_name(account_name);
				 list.add(pojo);
			 }
		 }
		 
	}
}