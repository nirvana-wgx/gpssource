package com.gps.alarm.service;

import java.sql.SQLException;
import java.util.List;

import com.gps.alarm.entity.GpsAlarm;
import com.gps.alarm.entity.SellAlarm;
import com.gps.alarm.entity.ServiceAlarm;
import com.gps.alarm.entity.VehicleinAlarm;

public interface IVehicleinfnewAlarmService {

	public List<VehicleinAlarm> getVehicleinfAlarm(String vehicleid, String deviceid, String sim, String account, String item, int page_no, int page_num, String login_name) throws SQLException;
	public int getVehicleinfAlarmCount(String vehicleid, String deviceid, String sim, String account, String item, String login_name) throws SQLException;
	public List<GpsAlarm> getGpsAlarm(String deviceid, String sim, String item, int page_no, int page_num, String login_name) throws SQLException;
	public int getGpsAlarmCount(String deviceid, String sim, String item, String login_name) throws SQLException;
	public List<SellAlarm> getSellAlarm(String vehicleid, String account, String exptime, int page_no, int page_num, String login_name) throws SQLException;
	public int getSellAlarmCount(String vehicleid, String account, String exptime, String login_name) throws SQLException;
	public List<ServiceAlarm> getServiceAlarm(String vehicleid, String account, String item, int page_no, int page_num, String login_name) throws SQLException;
	public int getServiceAlarmCount(String vehicleid, String account, String item, String login_name) throws SQLException;
}
