package com.gps.vehiclemng.servlet;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gps.common.util.DateUtil;
import com.gps.common.util.Lbs;
import com.gps.common.util.StringUtil;
import com.gps.vehiclemng.entity.EFencAlarm;
import com.gps.vehiclemng.entity.Messagebm;
import com.gps.vehiclemng.entity.VehicleInfNew;
import com.gps.vehiclemng.service.MapService;
import com.gps.vehiclemng.service.MapServiceImpl;


@Controller
public class MapServlet {

	private Logger log =Logger.getLogger(MapServlet.class);
	
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/Map")
	public void getFastTips(HttpServletRequest request, HttpServletResponse response) {
		try {
			String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));
			VehicleInfNew mapinf = new VehicleInfNew();
			MapService ms = new MapServiceImpl();
			mapinf = ms.getVehicleInf(deviceid);
			Date date = mapinf.getLocatetime();
			/*String lat = mapinf.getLatitude();
			Double dlat = Double.parseDouble(lat);
			dlat = dlat+0.0026146;
			String lng = mapinf.getLongitude();
			Double dlng = Double.parseDouble(lng);
			dlng = dlng+0.0124632;*/
			String lat = mapinf.getLatitude();
			String lng = mapinf.getLongitude();
			Map<String,String> map = new HashMap<String, String>();
			map = Lbs.readContentFromGet(lat, lng);
			mapinf.setLatitude(map.get("lat"));
			mapinf.setLongitude(map.get("lng"));
			//mapinf.setLatitude(dlat+"");
			//mapinf.setLongitude(dlng+"");
			String locatetime = DateUtil.formatMaskNull(date,"yyyy-MM-dd HH:mm:ss");
			List<EFencAlarm> fenclist = new ArrayList<EFencAlarm>();
			fenclist = ms.getFenc(deviceid);
			request.setAttribute("mapinf", mapinf);
			request.setAttribute("locatetime", locatetime);
			request.setAttribute("fenclist", fenclist);
			request.setAttribute("moveon", "0");//轨迹回放标签
			request.setAttribute("sample", 1000);//默认速度一般
			request.getRequestDispatcher("map.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			log.debug(e.getMessage());
		}
		
	}
	
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/history")
	public void getHisoryInf(HttpServletRequest request, HttpServletResponse response) {
		try {
			String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));
			String sample = StringUtil.nvl2(request.getParameter("sample"));
			String start = StringUtil.nvl2(request.getParameter("start"));
			String end = StringUtil.nvl2(request.getParameter("end"));
			String precision = StringUtil.nvl2(request.getParameter("precision"));
			MapService ms = new MapServiceImpl();
			
			VehicleInfNew mapinf = new VehicleInfNew();
			mapinf = ms.getVehicleInf(deviceid);
			request.setAttribute("mapinf", mapinf);
			
			List<Messagebm> list = new ArrayList<Messagebm>();
			List<Messagebm> newlist = new ArrayList<Messagebm>();//纠偏过后的
			list = ms.getHisoryInf(deviceid,start,end,precision);
			System.out.println(list.size());
			int n=0;
			for(Messagebm mg:list){
				System.out.println(++n);
				String lat = mg.getLatitude();
				String lng = mg.getLongitude();
				Map<String,String> map = new HashMap<String, String>();
				map = Lbs.readContentFromGet(lat, lng);
				mg.setLatitude(map.get("lat"));
				mg.setLongitude(map.get("lng"));
				newlist.add(mg);
			}
			request.setAttribute("list", newlist);
			
			request.setAttribute("moveon", "1");//轨迹回放标签
			request.setAttribute("start", start);//
			request.setAttribute("end", end);//
			request.setAttribute("sample", sample);
			request.setAttribute("deviceid", deviceid);
			request.setAttribute("precision", precision);
			request.getRequestDispatcher("map.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			log.debug(e.getMessage());
		}
		
	}
	
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/bang")
	public void bngFen(HttpServletRequest request, HttpServletResponse response) {
		try {
			String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));//获取设备号
			String latlon = StringUtil.nvl2(request.getParameter("str"));//获取经纬度字符串
			String message="0";
			if("".equals(latlon)){
			}else{
				MapService ms = new MapServiceImpl();
				message = ms.addMapPoints(deviceid, latlon);
			}
			Map<String,String> map =new HashMap<String, String>();
			map.put("message", message);
			response.getWriter().write(JSONObject.fromObject(map).toString());
		} catch (Exception e) {
			e.printStackTrace();
			log.debug(e.getMessage());
		}
		
	}
	
	@RequestMapping(value="jsp/vechiclemanager/singlevehicle/remove")
	public void removeFen(HttpServletRequest request, HttpServletResponse response) {
		try {
			String deviceid = StringUtil.nvl2(request.getParameter("deviceid"));//获取设备号
			String message="0";
			MapService ms = new MapServiceImpl();
			message = ms.removeFenc(deviceid);
			Map<String,String> map =new HashMap<String, String>();
			map.put("message", message);
			response.getWriter().write(JSONObject.fromObject(map).toString());
		} catch (Exception e) {
			e.printStackTrace();
			log.debug(e.getMessage());
		}
		
	}
}
