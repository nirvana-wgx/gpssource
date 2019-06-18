package com.gps.login.service;

import java.sql.SQLException;
import java.util.List;

import com.gps.login.entity.Account;

public interface IAccountService {
	public void save(Account account) throws SQLException;
	public Account findByNameAndPass(Account instance)throws SQLException;
	public List<Account> findAll(Account params) throws SQLException;
	public List<Account> findChildren(Account params) throws SQLException;
	public List<Account> findChildrenByname(String name) throws SQLException;
}
