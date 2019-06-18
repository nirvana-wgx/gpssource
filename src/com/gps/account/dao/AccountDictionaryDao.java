package com.gps.account.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.gps.account.entity.AccountDictionary;

public interface AccountDictionaryDao {
	public int save(AccountDictionary  accountDictionary) throws SQLException;
	public int delete(String account_name) throws SQLException;
	public List<AccountDictionary> query(AccountDictionary  accountDictionary) throws SQLException;
	public int deleteChild(AccountDictionary accountDictionary) throws SQLException;
	public int isExistPowers(Map<String,Object> paramMap) throws SQLException;
}
