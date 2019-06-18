package com.gps.account.service;

import java.sql.SQLException;
import java.util.List;


import com.gps.account.entity.AccountDictionary;
import com.gps.login.entity.Account;

public interface IAccountMangerService {

	public Account getAccount(Account account) throws SQLException;
	public int updateAccountByAid(Account account,List<AccountDictionary> list) throws SQLException;
	public int saveAccount(Account account,List<AccountDictionary> list) throws SQLException;
	public int deleteAccountByAid(Account account) throws SQLException;
	public List<Account> findChildren(Account params) throws SQLException;
}
