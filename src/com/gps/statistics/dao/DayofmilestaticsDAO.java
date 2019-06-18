package com.gps.statistics.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.gps.statistics.entity.Dayofmilestatics;
import com.gps.statistics.entity.MonthStatistics;

public interface DayofmilestaticsDAO {

	public List<Dayofmilestatics> getDailyWorkMile(Map<String, Object> paramMap) throws SQLException;
	public List<MonthStatistics> getMonthWorkMile(Map<String, Object> paramMap) throws SQLException;
}
