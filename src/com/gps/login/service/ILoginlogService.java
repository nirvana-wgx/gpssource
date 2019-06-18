package com.gps.login.service;

import java.sql.SQLException;
import java.util.List;

import com.gps.login.entity.Loginlog;
import com.gps.login.entity.Menu;

public interface ILoginlogService {
	public void save(Loginlog loginlog) throws SQLException ;
	public List<Menu> selectHeadMenu() throws SQLException ;
	public List<Menu> selectLeftMenu(String parentCode) throws SQLException ;
}
