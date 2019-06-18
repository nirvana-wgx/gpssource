package com.gps.vehiclemng.service;

import java.sql.SQLException;
import java.util.HashMap;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;

import com.gps.account.dao.AccountDictionaryDao;
import com.gps.common.util.MybatisUtil;
import com.gps.service.BasicService;

public class QueryPowersServiceImpl extends BasicService implements
		IQueryPowersService {

	public boolean isExistPowers(String login_name, String d_code)
			throws SQLException {
		// TODO Auto-generated method stub
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		AccountDictionaryDao accountdictionarydao = session.getMapper(AccountDictionaryDao.class);
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("account_name", login_name);
		map.put("d_code", d_code);
		int flg = accountdictionarydao.isExistPowers(map);
		session.close();
		
		if(flg > 0) {
			return true;
		} else {
			return false;
		}
	}

}
