package com.gps.login.service;

import java.sql.SQLException;
import java.util.List;
import org.apache.ibatis.session.SqlSession;
import com.gps.common.util.MybatisUtil;
import com.gps.login.dao.AccountDao;
import com.gps.login.entity.Account;
import com.gps.service.BasicService;

public class AccountServiceImpl extends BasicService implements IAccountService {

	public Account findByNameAndPass(Account instance) throws SQLException {
		SqlSession session = MybatisUtil.getSession();
		AccountDao accountDAO = session.getMapper(AccountDao.class);
		Account account =accountDAO.findByNameAndPass(instance);
		session.close();
		return account;
	}

	public void save(Account account) throws SQLException {
		SqlSession session = MybatisUtil.getSession();
		AccountDao accountDAO = session.getMapper(AccountDao.class);
		accountDAO.save(account);
		session.close();
	}

	public List<Account> findAll(Account params) throws SQLException {
		SqlSession session = MybatisUtil.getSession();
		AccountDao accountDAO = session.getMapper(AccountDao.class);
		int start =getStart(params.getCurentPage(), params.getPageSize());
		int end =getEnd(params.getCurentPage(), params.getPageSize());
		params.setStart(start);
		params.setEnd(end);
		List<Account> list =accountDAO.findAll(params);
 
		return list;
	}

	public List<Account> findChildren(Account params) throws SQLException {
		SqlSession session = MybatisUtil.getSession();
		AccountDao accountDAO = session.getMapper(AccountDao.class);
		int start =getStart(params.getCurentPage(), params.getPageSize());
		int end =getEnd(params.getCurentPage(), params.getPageSize());
		params.setStart(start);
		params.setEnd(end);
		List<Account> list =accountDAO.findChildren(params);
 
		return list;
	}

	public List<Account> findChildrenByname(String name) throws SQLException {
		SqlSession session = MybatisUtil.getSession();
		AccountDao accountDAO = session.getMapper(AccountDao.class);
		 
		List<Account> list =accountDAO.findChildrenByname(name);
 
		return list;
	}

}
