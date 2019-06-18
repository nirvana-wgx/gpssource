package com.gps.account.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;

import com.gps.account.dao.AccountDictionaryDao;
import com.gps.account.entity.AccountDictionary;
import com.gps.common.util.MybatisUtil;

public class AccountDictionaryServiceImpl implements IAccountDictionaryService {

	public int save(List<AccountDictionary> list) throws SQLException {
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.BATCH);
		try{
			AccountDictionaryDao dao =session.getMapper(AccountDictionaryDao.class);
			int result ;
			result=dao.delete(list.get(0).getAccount_name());
			for(AccountDictionary pojo :list){
				result =dao.save(pojo);
			}
			session.commit();
			return result;
		}catch(SQLException e){
			e.printStackTrace();
			throw e;
		}finally{
			session.close();
		}
	}

}
