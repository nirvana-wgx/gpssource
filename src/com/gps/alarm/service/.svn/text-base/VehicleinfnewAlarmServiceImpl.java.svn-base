package com.gps.alarm.service;

import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;

import com.gps.alarm.dao.VehicleinfnewAlarmDao;
import com.gps.alarm.entity.GpsAlarm;
import com.gps.alarm.entity.SellAlarm;
import com.gps.alarm.entity.ServiceAlarm;
import com.gps.alarm.entity.VehicleinAlarm;
import com.gps.common.util.DateUtil;
import com.gps.common.util.MathUtil;
import com.gps.common.util.MybatisUtil;
import com.gps.service.BasicService;

public class VehicleinfnewAlarmServiceImpl extends BasicService implements
IVehicleinfnewAlarmService {

	public List<VehicleinAlarm> getVehicleinfAlarm(String vehicleid, String deviceid, String sim, String account, String item, int page_no, int page_num, String login_name) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		VehicleinfnewAlarmDao vehicleinfnewalarmdao = session.getMapper(VehicleinfnewAlarmDao.class);
		
		int start = getStartNum(page_no, page_num);
		int end = getEndNum(page_no, page_num);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("deviceid", deviceid);
		map.put("vehicleid", vehicleid);
		map.put("sim", sim);
		map.put("item", item);
		map.put("account", account);
		map.put("start", start);
		map.put("end", end);
		map.put("login_name", login_name);
		List<VehicleinAlarm> list = vehicleinfnewalarmdao.getVehicleinfAlarm(map);
		session.close();
		return list;
	}
	
	public int getVehicleinfAlarmCount(String vehicleid, String deviceid, String sim, String account, String item, String login_name) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		VehicleinfnewAlarmDao vehicleinfnewalarmdao = session.getMapper(VehicleinfnewAlarmDao.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("deviceid", deviceid);
		map.put("vehicleid", vehicleid);
		map.put("sim", sim);
		map.put("item", item);
		map.put("account", account);
		map.put("login_name", login_name);
		int count =vehicleinfnewalarmdao.getVehicleinfAlarmCount(map);
		session.close();
		return count;
	}
	
	public List<GpsAlarm> getGpsAlarm(String deviceid, String sim, String item, int page_no, int page_num, String login_name) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		VehicleinfnewAlarmDao vehicleinfnewalarmdao = session.getMapper(VehicleinfnewAlarmDao.class);
		
		int start = getStartNum(page_no, page_num);
		int end = getEndNum(page_no, page_num);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("deviceid", deviceid);
		map.put("sim", sim);
		map.put("item", item);
		map.put("start", start);
		map.put("end", end);
		map.put("login_name", login_name);
		List<GpsAlarm> list = vehicleinfnewalarmdao.getGpsAlarm(map);
		session.close();
		return list;
	}
	
	public int getGpsAlarmCount(String deviceid, String sim, String item, String login_name) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		VehicleinfnewAlarmDao vehicleinfnewalarmdao = session.getMapper(VehicleinfnewAlarmDao.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("deviceid", deviceid);
		map.put("sim", sim);
		map.put("item", item);
		map.put("login_name", login_name);
		int count =vehicleinfnewalarmdao.getGpsAlarmCount(map);
		session.close();
		return count;
	}
	
	public int getSellAlarmCount(String vehicleid, String account, String exptime, String login_name) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		VehicleinfnewAlarmDao vehicleinfnewalarmdao = session.getMapper(VehicleinfnewAlarmDao.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("vehicleid", vehicleid);
		map.put("account", account);
		map.put("exptime", exptime);
		map.put("login_name", login_name);
		
		int count =vehicleinfnewalarmdao.getSellAlarmCount(map);
		session.close();
		return count;
	}
	
	public List<SellAlarm> getSellAlarm(String vehicleid, String account, String exptime, int page_no, int page_num, String login_name) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		VehicleinfnewAlarmDao vehicleinfnewalarmdao = session.getMapper(VehicleinfnewAlarmDao.class);
		
		int start = getStartNum(page_no, page_num);
		int end = getEndNum(page_no, page_num);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("vehicleid", vehicleid);
		map.put("account", account);
		map.put("exptime", exptime);
		map.put("start", start);
		map.put("end", end);
		map.put("login_name", login_name);
						
		List<SellAlarm> list = vehicleinfnewalarmdao.getSellAlarm(map);
		
		for(SellAlarm sa:list) {
			double month_monney = MathUtil.parseDbl(sa.getPaymonth());
			double payed_monney = MathUtil.parseDbl(sa.getRefundmoney());
			int parterm = sa.getPayterm();
			double tot_monney = month_monney * parterm * 12.00;
			double relay_monney = tot_monney - payed_monney;
			int fact_month = sa.getMonth_count();
			double fact_monney = month_monney * fact_month;
			double need_monney = fact_monney - payed_monney;
			int totmonth = 0;
			double totamt = 0.00;
			if(relay_monney < need_monney) {
				totamt = relay_monney;
				totmonth = (int) (relay_monney / month_monney);
			} else {
				totamt = need_monney;
				totmonth = (int) (need_monney / month_monney);
			}
			
			Date exp_tm = DateUtil.parse(sa.getExptime(), "yyyy-MM-dd");
			String fmt_exp_tm = DateUtil.format(exp_tm, "yyyy年MM月dd日");
			
			sa.setExptime(fmt_exp_tm);
			sa.setTotamt(totamt);
			sa.setTotmonth(totmonth);
		}
		
		session.close();
		return list;
	}
	
	public int getServiceAlarmCount(String vehicleid, String account, String item, String login_name) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		VehicleinfnewAlarmDao vehicleinfnewalarmdao = session.getMapper(VehicleinfnewAlarmDao.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("vehicleid", vehicleid);
		map.put("item", item);
		map.put("account", account);
		map.put("login_name", login_name);
		
		String cur_dt = DateUtil.format(new Date(), "yyyyMMdd");
		map.put("cur_dt", cur_dt);
		
		int count =vehicleinfnewalarmdao.getServiceAlarmCount(map);
		session.close();
		return count;
	}
	
	private int getStartNum(int page_no, int page_num) {
		return page_num * ( page_no - 1) + 1;
	}
	
	private int getEndNum(int page_no, int page_num) {
		return page_num * ( page_no - 1) + page_num;
	}
	
	public List<ServiceAlarm> getServiceAlarm(String vehicleid, String account, String item, int page_no, int page_num, String login_name) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		VehicleinfnewAlarmDao vehicleinfnewalarmdao = session.getMapper(VehicleinfnewAlarmDao.class);
		
		int start = getStartNum(page_no, page_num);
		int end = getEndNum(page_no, page_num);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("vehicleid", vehicleid);
		map.put("item", item);
		map.put("account", account);
		map.put("start", start);
		map.put("end", end);
		map.put("login_name", login_name);
		
		String cur_dt = DateUtil.format(new Date(), "yyyyMMdd");
		map.put("cur_dt", cur_dt);
		
		List<ServiceAlarm> list = vehicleinfnewalarmdao.getServiceAlarm(map);
		session.close();
		return list;
	}
}
