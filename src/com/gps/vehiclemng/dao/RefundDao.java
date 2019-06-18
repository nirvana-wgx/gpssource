package com.gps.vehiclemng.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.gps.vehiclemng.entity.Refund;

public interface RefundDao {
	public int save (Refund pojo) throws SQLException;
	public List<Refund> getRefundList(Map<String, Object> paramMap) throws SQLException;
	public int getRefundCount(Map<String, Object> paramMap) throws SQLException;
}
