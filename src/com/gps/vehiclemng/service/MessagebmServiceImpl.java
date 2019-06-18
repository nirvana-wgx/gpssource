package com.gps.vehiclemng.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;

import com.gps.common.util.MybatisUtil;
import com.gps.service.BasicService;
import com.gps.vehiclemng.dao.MessagebmDAO;
import com.gps.vehiclemng.entity.Messagebm;

public class MessagebmServiceImpl extends BasicService implements
		IMessagebmService {

	public Messagebm getLastByReceivetime(String deviceid, String serchdate, String tablename)
			throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		MessagebmDAO messagebmdao = session.getMapper(MessagebmDAO.class);
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("deviceid", deviceid);
		map.put("serchdate", serchdate);
		map.put("tablename", tablename);
		Messagebm messagebm = messagebmdao.getLastByReceivetime(map);
		session.close();
		return messagebm;
	}
	
	public Messagebm getNewMessagebm(String deviceid)
			throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		MessagebmDAO messagebmdao = session.getMapper(MessagebmDAO.class);
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("deviceid", deviceid);
		Messagebm messagebm = messagebmdao.getNewMessagebm(map);
		session.close();
		return messagebm;
	}
	
	public List<Messagebm> getMessagebmList(Map<String, Object> paramMap) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		MessagebmDAO messagebmdao = session.getMapper(MessagebmDAO.class);
		List<Messagebm> list = messagebmdao.getMessagebmList(paramMap);
		session.close();
		return list;
	}
	
	public int getMessagebmListCount(Map<String, Object> paramMap) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		MessagebmDAO messagebmdao = session.getMapper(MessagebmDAO.class);
		int count = messagebmdao.getMessagebmListCount(paramMap);
		session.close();
		return count;
	}

}
