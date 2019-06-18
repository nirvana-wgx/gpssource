package com.gps.statistics.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;

import com.gps.common.util.MybatisUtil;
import com.gps.service.BasicService;
import com.gps.statistics.dao.DayofmilestaticsDAO;
import com.gps.statistics.entity.Dayofmilestatics;
import com.gps.statistics.entity.MonthStatistics;

public class DayofmilestaticsServiceImpl extends BasicService implements
		IDayofmilestaticsService {

	public List<Dayofmilestatics> getDailyMileData(String deviceid, String startdate, String enddate) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		DayofmilestaticsDAO dayofmilestaticsdao = session.getMapper(DayofmilestaticsDAO.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("deviceid", deviceid);
		map.put("startdate", startdate);
		map.put("enddate", enddate);
		List<Dayofmilestatics> list = dayofmilestaticsdao.getDailyWorkMile(map);
		session.close();
		return list;
	}

	public List<MonthStatistics> getMonthMileData(String deviceid,
			String startdate, String enddate) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		DayofmilestaticsDAO dayofmilestaticsdao = session.getMapper(DayofmilestaticsDAO.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("deviceid", deviceid);
		map.put("startdate", startdate);
		map.put("enddate", enddate);
		List<MonthStatistics> list =dayofmilestaticsdao.getMonthWorkMile(map);
		session.close();
		return list;
	}

}
