package com.gps.account.service;

import java.sql.SQLException;
import java.util.List;

import com.gps.account.entity.Dictionary;
import com.gps.login.entity.Account;

public interface IDictionaryService {

	List<Dictionary> getTypes() throws SQLException;
	List<Dictionary> query() throws SQLException;
	int delete(Dictionary dictionary) throws SQLException;
	List<Dictionary> queryByparms(Account account) throws SQLException;
	List<Dictionary> queryByDictionary(Dictionary dictionary) throws SQLException;
	int save(Dictionary dictionary) throws SQLException;
	int update(Dictionary dictionary) throws SQLException;
}
