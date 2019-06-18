package com.gps.login.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;

import com.gps.common.util.MybatisUtil;
import com.gps.login.dao.LoginlogDao;
import com.gps.login.entity.Loginlog;
import com.gps.login.entity.Menu;

public class LoginlogServiceImpl implements ILoginlogService{

	public void save(Loginlog loginlog) throws SQLException {
		SqlSession  session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		try{
			LoginlogDao dao =session.getMapper(LoginlogDao.class);
			dao.save(loginlog);
		}catch(SQLException e){
			throw e;
		}finally{
			session.close();
		}
		
		
	}

	public List<Menu> selectHeadMenu() throws SQLException {
		SqlSession  session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		try{
		LoginlogDao dao =session.getMapper(LoginlogDao.class);
		List<Menu> list =dao.selectHeadMenu();
		return list;
		}catch(SQLException e){
			throw e;
		}finally{
			session.close();
		}
	}

	public List<Menu> selectLeftMenu(String parentCode) throws SQLException {
		
		SqlSession  session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		try{
		LoginlogDao dao =session.getMapper(LoginlogDao.class);
		List<Menu> list =dao.selectLeftMenu(parentCode);
		return list ;
		}catch(SQLException e){
			throw e;
		}finally{
			session.close();
		}
		
		
	}

}
