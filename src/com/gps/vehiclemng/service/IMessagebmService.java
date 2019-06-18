package com.gps.vehiclemng.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.gps.vehiclemng.entity.Messagebm;

public interface IMessagebmService {

	public Messagebm getLastByReceivetime(String deviceid, String serchdate, String tablename) throws SQLException;
	public Messagebm getNewMessagebm(String deviceid) throws SQLException;
	public List<Messagebm> getMessagebmList(Map<String, Object> paramMap) throws SQLException;
	public int getMessagebmListCount(Map<String, Object> paramMap) throws SQLException;
}
