package com.gps.vehiclemng.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;

import com.gps.common.util.MybatisUtil;
import com.gps.service.BasicService;
import com.gps.vehiclemng.dao.MessageoriginDao;
import com.gps.vehiclemng.entity.Messageorigin;

public class MessageoriginServiceImpl extends BasicService implements
		IMessageoriginService {

	public List<Messageorigin> getMessageoriginList(String deviceid, String serstarttime, String serendtime, int page_no, int page_num)
			throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		MessageoriginDao messageorigindao = session.getMapper(MessageoriginDao.class);
		HashMap<String,Object> map = new HashMap<String, Object>();
		int start = getStartNum(page_no, page_num);
		int end = getEndNum(page_no, page_num);
		map.put("deviceid", deviceid);
		map.put("serstarttime", serstarttime);
		map.put("serendtime", serendtime);
		map.put("start", start);
		map.put("end", end);
		List<Messageorigin> list = messageorigindao.getMessageoriginList(map);
		session.close();
		return list;
	}

	public int getMessageoriginCount(String deviceid, String serstarttime, String serendtime) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		MessageoriginDao messageorigindao = session.getMapper(MessageoriginDao.class);
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("deviceid", deviceid);
		map.put("serstarttime", serstarttime);
		map.put("serendtime", serendtime);
		int count = messageorigindao.getMessageoriginCount(map);
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
