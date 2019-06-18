package com.gps.login.dao;

import java.sql.SQLException;
import java.util.List;
import com.gps.login.entity.Menu;
import com.gps.login.entity.Loginlog;

 

public interface LoginlogDao {
	public void save(Loginlog loginlog) throws SQLException ;
	public List<Menu> selectHeadMenu() throws SQLException ;
	public List<Menu> selectLeftMenu(String parentCode) throws SQLException ;
}
