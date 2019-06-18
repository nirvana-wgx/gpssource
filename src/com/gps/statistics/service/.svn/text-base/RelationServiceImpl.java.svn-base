package com.gps.statistics.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;

import com.gps.common.util.MybatisUtil;
import com.gps.service.BasicService;
import com.gps.statistics.dao.RelationDAO;
import com.gps.statistics.entity.Relation;

public class RelationServiceImpl extends BasicService implements
		IRelationService {

	public List<Relation> getVehicleList(String vehicleid, String deviceid, String login_name, int page_no, int page_num) throws SQLException {
		// TODO Auto-generated method stub
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		RelationDAO relationdao = session.getMapper(RelationDAO.class);
		
		int start = getStartNum(page_no, page_num);
		int end = getEndNum(page_no, page_num);
		
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("vehicleid", vehicleid);
		map.put("deviceid", deviceid);
		map.put("login_name", login_name);
		map.put("start", start);
		map.put("end", end);
		List<Relation> list = relationdao.getVehicleList(map);
		session.close();
		return list;
	}
	
	public int getVehicleCount(String vehicleid, String deviceid, String login_name) throws SQLException {
		// TODO Auto-generated method stub
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		RelationDAO relationdao = session.getMapper(RelationDAO.class);
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("vehicleid", vehicleid);
		map.put("deviceid", deviceid);
		map.put("login_name", login_name);
		int count = relationdao.getVehicleCount(map);
		session.close();
		return count;
	}
	
	private int getStartNum(int page_no, int page_num) {
		return page_num * ( page_no - 1) + 1;
	}
	
	private int getEndNum(int page_no, int page_num) {
		return page_num * ( page_no - 1) + page_num;
	}

}
