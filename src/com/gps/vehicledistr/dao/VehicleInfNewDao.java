package com.gps.vehicledistr.dao;

import java.sql.SQLException;
import java.util.List;

import com.gps.vehicledistr.entity.VehicleInfNew;

public interface VehicleInfNewDao {
	public List<VehicleInfNew> getListByDeviceid(List<String> list) throws SQLException;//根据车辆信息list获取最新车辆数据list
}
