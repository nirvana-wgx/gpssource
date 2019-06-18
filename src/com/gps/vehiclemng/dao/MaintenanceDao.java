package com.gps.vehiclemng.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.gps.vehiclemng.entity.Maintenance;

public interface MaintenanceDao {
	public List<Maintenance> getMaintenanceList(Map<String, Object> paramMap) throws SQLException;
	public int getMaintenanceCount(Map<String, Object> paramMap) throws SQLException;
	public int updateAction(Map<String, Object> paramMap) throws SQLException;
	public int save (Maintenance pojo) throws SQLException ;
}
