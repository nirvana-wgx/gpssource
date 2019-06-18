package com.gps.vehiclemng.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;

import com.gps.common.util.MybatisUtil;
import com.gps.service.BasicService;
import com.gps.vehiclemng.dao.MaintenanceDao;
import com.gps.vehiclemng.entity.Maintenance;

public class MaintenanceServiceImpl extends BasicService implements
		IMaintenanceService {

	public List<Maintenance> getMaintenanceList(String deviceid,
			String fitting, String maintenancedate, String isovertime, String action,
				int page_no, int page_num) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		MaintenanceDao maintenancedao = session.getMapper(MaintenanceDao.class);
		HashMap<String,Object> map = new HashMap<String, Object>();
		
		int start = getStartNum(page_no, page_num);
		int end = getEndNum(page_no, page_num);
		
		map.put("deviceid", deviceid);
		map.put("fitting", fitting);
		map.put("maintenancedate", maintenancedate);
		map.put("isovertime", isovertime);
		map.put("action", action);
		map.put("start", start);
		map.put("end", end);
		List<Maintenance> list = maintenancedao.getMaintenanceList(map);
		session.close();
		return list;
	}
	
	public int getMaintenanceCount(String deviceid,
			String fitting, String maintenancedate, String isovertime, String action) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		MaintenanceDao maintenancedao = session.getMapper(MaintenanceDao.class);
		HashMap<String,Object> map = new HashMap<String, Object>();		
		map.put("deviceid", deviceid);
		map.put("fitting", fitting);
		map.put("maintenancedate", maintenancedate);
		map.put("isovertime", isovertime);
		map.put("action", action);
		int count = maintenancedao.getMaintenanceCount(map);
		session.close();
		return count;
	}
	
	public int updateAction(String maid, String remark) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		MaintenanceDao maintenancedao = session.getMapper(MaintenanceDao.class);
		HashMap<String,Object> map = new HashMap<String, Object>();		
		map.put("maid", maid);
		map.put("remark", remark);
		int flg = maintenancedao.updateAction(map);
		session.commit();
		session.close();
		return flg;
	}
	
	private int getStartNum(int page_no, int page_num) {
		return page_num * ( page_no - 1) + 1;
	}
	
	private int getEndNum(int page_no, int page_num) {
		return page_num * ( page_no - 1) + page_num;
	}

	public int save(Maintenance pojo) throws SQLException {
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		try{
			MaintenanceDao dao =session.getMapper(MaintenanceDao.class);
			int result =dao.save(pojo);
			session.commit();
			return result;
		}catch(SQLException e){
			throw e;
		}
		// TODO Auto-generated method stub
		
	}

}
