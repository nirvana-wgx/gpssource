package com.gps.statistics.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;

import com.gps.common.util.MybatisUtil;
import com.gps.service.BasicService;
import com.gps.statistics.dao.MessagereportDAO;
import com.gps.statistics.entity.Messagereport;
import com.gps.statistics.entity.MonthStatistics;

public class MessagereportServiceImpl extends BasicService implements
		IMessagereportService {

	public List<Messagereport> getDailyWorkingData(String deviceid, String startdate, String enddate) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		MessagereportDAO messagereportdao = session.getMapper(MessagereportDAO.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
//		String start = startdate.substring(2, 4) + "年" + startdate.substring(5, 7) + "月" + startdate.substring(8) + "日";
//		String end = enddate.substring(2, 4) + "年" + enddate.substring(5, 7) + "月" + enddate.substring(8) + "日";
		map.put("deviceid", deviceid);
		map.put("startdate", startdate);
		map.put("enddate", enddate);
		List<Messagereport> list =messagereportdao.getDailyWorkTime(map);
		session.close();
		return list;
	}
	
	public List<MonthStatistics> getMonthWorkingData(String deviceid, String startdate, String enddate) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		MessagereportDAO messagereportdao = session.getMapper(MessagereportDAO.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
//		String start = startdate.substring(2, 4) + "年" + startdate.substring(5, 7) + "月" + startdate.substring(8) + "日";
//		String end = enddate.substring(2, 4) + "年" + enddate.substring(5, 7) + "月" + enddate.substring(8) + "日";
		map.put("deviceid", deviceid);
		map.put("startdate", startdate);
		map.put("enddate", enddate);
		List<MonthStatistics> list =messagereportdao.getMonthWorkTime(map);
		session.close();
		return list;
	}
}
