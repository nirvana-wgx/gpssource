package com.gps.vehiclemng.service;

import java.sql.SQLException;

public interface IQueryPowersService {

	public boolean isExistPowers(String login_name, String d_code) throws SQLException;
}
