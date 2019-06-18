package com.gps.vehiclemng.servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gps.common.util.Constants;
import com.gps.common.util.ExportExcel;
import com.gps.common.util.StringUtil;
import com.gps.login.entity.Account;
import com.gps.statistics.entity.Relation;


@Controller
public class SalesInfServlet {

	private Logger log =Logger.getLogger(SalesInfServlet.class);
	
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/SalesInf")
	public void getSalesInf(HttpServletRequest request, HttpServletResponse response) {
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));
		
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
		
		request.setAttribute("relation", relation);
		
		try {
			request.getRequestDispatcher("saleinf_edit.jsp").forward(request, response);
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
	
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/SalesInfDownload")
	public void getSalesInfDownload(HttpServletRequest request, HttpServletResponse response) {
		String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));
		
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
		
		//title
		List<String> title_list = new ArrayList<String>();
		title_list.add("车辆编号");
		title_list.add("设备编号");
		title_list.add("机械种类");
		title_list.add("所属账号");
		title_list.add("最终用户");
		title_list.add("联系方式");
		title_list.add("付款方式");
		title_list.add("购买人");
		title_list.add("购买日期");
		title_list.add("预付款项");
		title_list.add("月供额度");
		title_list.add("还款年限");
		title_list.add("还款预警日期");
		
		List<String> data_list = new ArrayList<String>();
		data_list.add(relation.getVehicleid());
		data_list.add(relation.getDeviceid());
		data_list.add(relation.getType());
		data_list.add(relation.getAccount());
		data_list.add(relation.getOwnername());
		data_list.add(relation.getOwnerphone());
		data_list.add(relation.getPayway());
		data_list.add(relation.getBuyname());
		data_list.add(relation.getBuytime());
		data_list.add(relation.getPrepay());
		data_list.add(relation.getPaymonth());
		data_list.add(relation.getPayterm());
		data_list.add(relation.getPaywarndate());
		
		List<List<String>> v_list = new ArrayList<List<String>>();
		v_list.add(data_list);
		
		try {
			String filename = relation.getVehicleid() + "销售基本信息.xls";
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
}
