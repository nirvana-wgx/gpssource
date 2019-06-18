package com.gps.vehiclemng.service;

import java.sql.SQLException;
import java.util.List;

import com.gps.vehiclemng.entity.Maintenance;

public interface IMaintenanceService {

	public List<Maintenance> getMaintenanceList(String deviceid, String fitting, String maintenancedate, String isovertime, String action, int page_no, int page_num) throws SQLException;
	public int getMaintenanceCount(String deviceid, String fitting, String maintenancedate, String isovertime, String action) throws SQLException;
	public int updateAction(String maid, String remark) throws SQLException;
	public int save (Maintenance pojo) throws SQLException ;
}
