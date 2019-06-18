package com.gps.vehiclemng.service;

import java.sql.SQLException;
import java.util.List;

import com.gps.vehiclemng.entity.Commandorigin;

public interface ICommandoriginService {
	int save(Commandorigin commandorigin) throws SQLException;
	public List<Commandorigin> getCommandoriginList(String deviceid, String serstarttime, String serendtime, int page_no, int page_num) throws SQLException;
	public int getCommandoriginCount(String deviceid, String serstarttime, String serendtime) throws SQLException;
	public boolean send(String phone, String device, String commandcode,String commandparameter, String csid) throws SQLException;

}
