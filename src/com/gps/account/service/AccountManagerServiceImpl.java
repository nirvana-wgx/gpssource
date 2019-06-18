package com.gps.account.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;

import com.gps.account.dao.AccountDictionaryDao;
import com.gps.account.entity.AccountDictionary;
import com.gps.common.util.MybatisUtil;
import com.gps.login.dao.AccountDao;
import com.gps.login.entity.Account;
import com.gps.service.BasicService;

public class AccountManagerServiceImpl extends BasicService implements IAccountMangerService {

	public Account getAccount(Account instance) throws SQLException {
	
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		try{
			AccountDao dao =session.getMapper(AccountDao.class);
			Account pojo =dao.findByNameAndPass(instance);
			session.commit();
			return pojo;
		}catch(SQLException e){
			e.printStackTrace();
			throw e;
		}finally{
			session.close();
		}
		
	}

	public int updateAccountByAid(Account account,List<AccountDictionary> list) throws SQLException {
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		try{
			
			AccountDao dao =session.getMapper(AccountDao.class);
			AccountDictionaryDao adao =session.getMapper(AccountDictionaryDao.class);
			
			int result =dao.updateAccountByAid(account);
			if(list!=null){
				List<String> dlist= differenceList(list);
				String account_name =list.get(0).getAccount_name();
				adao.delete(account_name);
				for(AccountDictionary pojo :list){
					adao.save(pojo);
				}
				
				for( String d_code:dlist){
					AccountDictionary pojo=new AccountDictionary();
					pojo.setD_code(d_code);
					pojo.setAccount_name(account_name);
					adao.deleteChild(pojo);
				}
				
				
				//修改下级目录用户的数据权限, 只考虑被减少的权限更改，新增的修改由用户自己去修改
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

	public List<Account> findChildren(Account params) throws SQLException {
		if(params.getStart()!=null){
			params.setStart(getStart(params.getCurentPage(), params.getPageSize()));
			params.setEnd(getEnd(params.getCurentPage(), params.getPageSize()));
		}
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		try{
			AccountDao dao =session.getMapper(AccountDao.class);
			List<Account>  list =dao.findChildren(params);
			session.commit();
			return list;
		}catch(SQLException e){
			e.printStackTrace();
			throw e;
		}finally{
			session.close();
		}
	}

	public int deleteAccountByAid(Account account) throws SQLException {
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		try{
			AccountDao dao =session.getMapper(AccountDao.class);
			AccountDictionaryDao adao =session.getMapper(AccountDictionaryDao.class);
			int result =dao.deleteAccountByAid(account);
			adao.delete(account.getName());
			session.commit();
			return result;
		}catch(SQLException e){
			e.printStackTrace();
			throw e;
		}finally{
			session.close();
		}
	}

	public int saveAccount(Account account,List<AccountDictionary> list) throws SQLException {
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		try{
			AccountDao dao =session.getMapper(AccountDao.class);
			AccountDictionaryDao adao =session.getMapper(AccountDictionaryDao.class);
			dao.save(account);
			if(list!=null){
				adao.delete(list.get(0).getAccount_name());
				for(AccountDictionary pojo :list){
					adao.save(pojo);
				}
			}
			session.commit();
			return 1;
		}catch(SQLException e){
			e.printStackTrace();
			throw e;
		}finally{
			session.close();
		}
	}
	/**
	 * 
	 * @author 肖海兵
	 * @param  paramslist,list
	 * 
	 * @return diffrent_list
	 * 
	 *********************/
	private  List<String> differenceList(List<AccountDictionary> paramslist) throws SQLException{
	 
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		List<String> list_ =new ArrayList<String>();
		List<String> paramslist_ =new ArrayList<String>();
		try{
			AccountDictionaryDao adao =session.getMapper(AccountDictionaryDao.class);
			AccountDictionary pojo =new AccountDictionary();
			pojo.setAccount_name(paramslist.get(0).getAccount_name());
		    List<AccountDictionary> alist =adao.query(pojo); 
		    for(int i=0;i<alist.size();i++){
		    		String key =alist.get(i).getD_code().trim();
		    		list_.add(key);
		    }
		    for(int i=0;i<paramslist.size();i++){
		    		String key =paramslist.get(i).getD_code().trim();
		    		paramslist_.add(key);
		    }
		    list_.removeAll(paramslist_);
		    return list_;
		}catch(SQLException e){
			e.printStackTrace();
			throw e;
		}finally{
			session.close();
		}
	}
public static void main(String[] args) {
	Account account=new Account();
	account.setName("haibing");
	account.setPass("123456");
	account.setParentname("root");
	account.setMaxchild(100);
	account.setMaxlevel(2);
	 
}
}
