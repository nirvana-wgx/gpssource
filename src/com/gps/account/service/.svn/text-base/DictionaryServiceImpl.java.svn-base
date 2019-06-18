package com.gps.account.service;

import java.sql.SQLException;
import java.util.ArrayList;
 
import java.util.Collections;
import java.util.List;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;

import com.gps.account.dao.DictionaryDao;
import com.gps.account.entity.Dictionary;
import com.gps.common.util.MybatisUtil;
import com.gps.login.entity.Account;
import com.gps.service.BasicService;

public class DictionaryServiceImpl extends BasicService implements IDictionaryService {

	public List<Dictionary> getTypes() throws SQLException {
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		List<Dictionary> list =null;
		try{
			DictionaryDao dao =session.getMapper(DictionaryDao.class);
			list =dao.getTypes();
			return list;
		}catch(SQLException e){
			e.printStackTrace();
			throw e;
		}finally{
			session.close();
		}
	}

	public List<Dictionary> query() throws SQLException {
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		List<Dictionary> list =null;
		try{
			DictionaryDao dao =session.getMapper(DictionaryDao.class);
			list =dao.query();
			return list;
		}catch(SQLException e){
			e.printStackTrace();
			throw e;
		}finally{
			session.close();
		}
	}

	public List<Dictionary> queryByparms(Account account) throws SQLException {
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		List<Dictionary> list =null;
		try{
			DictionaryDao dao =session.getMapper(DictionaryDao.class);
			list =dao.queryByparms(account);
			return list;
		}catch(SQLException e){
			e.printStackTrace();
			throw e;
		}finally{
			session.close();
		}
	}

	public List<Dictionary> queryByDictionary(Dictionary params)
			throws SQLException {
		if(params.getStart()!=null){
			params.setStart(getStart(params.getCurentPage(), params.getPageSize()));
			params.setEnd(getEnd(params.getCurentPage(), params.getPageSize()));
		}
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		List<Dictionary> list =null;
		try{
			DictionaryDao dao =session.getMapper(DictionaryDao.class);
			list =dao.queryByDictionary(params);
			return list;
		}catch(SQLException e){
			e.printStackTrace();
			throw e;
		}finally{
			session.close();
		}
	}

	public int delete(Dictionary dictionary) throws SQLException {
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		 
		try{
			DictionaryDao dao =session.getMapper(DictionaryDao.class);
			int result =dao.delete(dictionary);
			session.commit();
			return result;
		}catch(SQLException e){
			e.printStackTrace();
			throw e;
		}finally{
			session.close();
		}
	}

	public int save(Dictionary dictionary) throws SQLException {
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		 
		try{
			DictionaryDao dao =session.getMapper(DictionaryDao.class);
			String d_type =dictionary.getD_type();
			String d_code="";
			if("jxzl".equals(d_type)){
				  d_code=selectKey(dictionary.getD_type());
				  dictionary.setD_code(d_code);
			}
			if("jxlx".equals(d_type)){
				d_code=dictionary.getD_value();
				dictionary.setD_code(d_code);
			}
			int result =dao.save(dictionary);
			session.commit();
			return result;
		}catch(SQLException e){
			e.printStackTrace();
			throw e;
		}finally{
			session.close();
		}
	}

	public int update(Dictionary dictionary) throws SQLException {
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		 
		try{
			DictionaryDao dao =session.getMapper(DictionaryDao.class);
			 
			int result =dao.update(dictionary);
			session.commit();
			return result;
		}catch(SQLException e){
			e.printStackTrace();
			throw e;
		}finally{
			session.close();
		}
	}

	private String selectKey(String d_type) throws SQLException{
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		 
		try{
			DictionaryDao dao =session.getMapper(DictionaryDao.class);
			Dictionary dictionary=new Dictionary();
			dictionary.setD_type(d_type);
			List<Dictionary> list =dao.queryByDictionary(dictionary);
			List<Integer> plist=new ArrayList<Integer>();
			for(Dictionary pojo :list){
				Integer number =Integer.valueOf(pojo.getD_code().substring(5));
				plist.add(number);
			}
			Collections.sort(plist);
			int size=plist.size();
			int result =Math.max(plist.get(0), plist.get(size-1))+1;
			StringBuffer d_code =new StringBuffer();
			d_code.append(d_type);
			if(result<=9){
				d_code.append("0").append(result);
			}else{
				d_code.append(d_code);
			}
			return d_code.toString();
		}catch(SQLException e){
			e.printStackTrace(); 
			throw e;
		}finally{
			session.close();
		}
	 
	}
}
