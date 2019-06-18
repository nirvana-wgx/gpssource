package com.gps.vehiclemng.service;

import java.sql.SQLException;
import java.util.List;

import com.gps.vehiclemng.entity.Refund;

public interface IRefundService {

	
	public int save (Refund pojo) throws SQLException ;
	public List<Refund> getRefundList(String deviceid, String serstarttime, String serendtime, int page_no, int page_num) throws SQLException;
	public int getRefundCount(String deviceid, String serstarttime, String serendtime) throws SQLException;
}
