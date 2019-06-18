package com.gps.statistics.service;

import java.sql.SQLException;
import java.util.List;

import com.gps.statistics.entity.Relation;

public interface IRelationService {

	public List<Relation> getVehicleList(String vehicleid, String serdeviceid, String login_name, int page_no, int page_num) throws SQLException;
	public int getVehicleCount(String vehicleid, String serdeviceid, String login_name) throws SQLException;
}
