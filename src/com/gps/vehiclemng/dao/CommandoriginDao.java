package com.gps.vehiclemng.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.gps.vehiclemng.entity.CmdDown;
import com.gps.vehiclemng.entity.Commandorigin;

public interface CommandoriginDao {
	public List<Commandorigin> getCommandoriginList(Map<String, Object> paramMap) throws SQLException;
	public int getCommandoriginCount(Map<String, Object> paramMap) throws SQLException;

	int save(Commandorigin commandorigin) throws SQLException;
	public int insert(CmdDown cmd);
	public int merge(String csid);
	public Commandorigin findById(String csid);
}
 
