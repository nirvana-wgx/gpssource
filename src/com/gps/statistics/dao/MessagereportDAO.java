package com.gps.statistics.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.gps.statistics.entity.Messagereport;
import com.gps.statistics.entity.MonthStatistics;


public interface MessagereportDAO {

	public List<Messagereport> getDailyWorkTime(Map<String, Object> paramMap) throws SQLException;
	public List<MonthStatistics> getMonthWorkTime(Map<String, Object> paramMap) throws SQLException;
}
