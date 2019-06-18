package com.gps.vehiclemng.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.gps.vehiclemng.entity.Car;
import com.gps.vehiclemng.entity.EFencAlarm;
import com.gps.vehiclemng.entity.Messagebm;
import com.gps.vehiclemng.entity.VehicleInfNew;

public interface MapDao {
	public VehicleInfNew getLastVehicleInf(String vehicleid) throws SQLException;//根据车辆编号获取最新车辆信息
	public Car getModelInf(String deviceid) throws SQLException;//根据设备号获取车辆信息
	public List<Messagebm> getHisoryInf(Map<String, String> map) throws SQLException;//根据设备号获取车辆信息
	public int addMapPoints(EFencAlarm pojo) throws SQLException;//插入电子围栏配置
	public List<EFencAlarm> getFenc(String deviceid) throws SQLException;//根据设备号来查询电子围栏
	public int removeFenc(String deviceid) throws SQLException;//移除电子围栏
	public Map<String,Double> getOffSet(double lng,double lat) throws Exception;//查询偏移数据
}