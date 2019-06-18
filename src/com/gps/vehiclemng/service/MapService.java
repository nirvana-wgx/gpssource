package com.gps.vehiclemng.service;

import java.util.List;
import java.util.Map;

import com.gps.vehiclemng.entity.EFencAlarm;
import com.gps.vehiclemng.entity.Messagebm;
import com.gps.vehiclemng.entity.VehicleInfNew;

public interface MapService {
	public VehicleInfNew getVehicleInf(String deviceid) throws Exception;
	public List<Messagebm> getHisoryInf(String deviceid,String start,String end,String precision) throws Exception;
	public String addMapPoints(String str,String str2) throws Exception;
	public List<EFencAlarm> getFenc(String str) throws Exception;
	public String removeFenc(String str) throws Exception;
	public Map<String,Double> getOffSet(double lng,double lat) throws Exception;
}
