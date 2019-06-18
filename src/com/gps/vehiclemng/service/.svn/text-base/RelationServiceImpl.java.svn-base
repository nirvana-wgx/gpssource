package com.gps.vehiclemng.service;

import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import java.util.Collections;

import java.util.List;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;

import com.gps.common.util.MybatisUtil;
import com.gps.common.util.StringUtil;
import com.gps.service.BasicService;
import com.gps.vehiclemng.dao.RelationDao;
import com.gps.vehiclemng.entity.Car;
import com.gps.vehiclemng.entity.VehicleInfNew;
 

public class RelationServiceImpl extends BasicService implements IRelationService {

	public int modify(Car pojo) throws SQLException {
		SqlSession session = MybatisUtil.getSqlsessionfactory().openSession(
				ExecutorType.REUSE);
		try {
			RelationDao dao = session.getMapper(RelationDao.class);
			int result = dao.modify(pojo);
			session.commit();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			session.close();
		}
	}

	public List<Car> query(Car params) throws SQLException {
		SqlSession session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		if(params.getStart()!=null){
			params.setStart(getStart(params.getCurentPage(), params.getPageSize()));
			params.setEnd(getEnd(params.getCurentPage(), params.getPageSize()));
		}
		try {
			RelationDao dao = session.getMapper(RelationDao.class);
			List<Car> list = dao.query(params);
			session.commit();
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			session.close();
		}
	}

	public int remove(Car pojo) throws SQLException {
		SqlSession session = MybatisUtil.getSqlsessionfactory().openSession(
				ExecutorType.REUSE);
		try {
			RelationDao dao = session.getMapper(RelationDao.class);
			Car car =dao.getCarByrid(pojo.getRid());
			String tablename =car.getTablename();
			int result = dao.remove(pojo);
			dropTable(tablename);//删除表
			session.commit();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			session.close();
		}
	}

	public int save(Car pojo) throws SQLException {
		SqlSession session = MybatisUtil.getSqlsessionfactory().openSession(
				ExecutorType.REUSE);
		try {
			RelationDao dao = session.getMapper(RelationDao.class);
			String tablename =getRelationTablename();
			pojo.setTablename(tablename);
			int result = dao.save(pojo);
			createTable(tablename);//创建表
			session.commit();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			session.close();
		}
	}
	private void  createTable(String tablename) throws SQLException{
		java.sql.Connection conn =MybatisUtil.getSession().getConnection();
		Statement stm =conn.createStatement();
		StringBuffer sql =new StringBuffer();
	    sql.append("	create table ").append(tablename)
	    .append("		as select * from messagebm where 1<>1 ");
		stm.execute(sql.toString());
		stm.close();
		conn.close();
	} 
	private void  dropTable(String tablename) throws SQLException{
		java.sql.Connection conn =MybatisUtil.getSession().getConnection();
		Statement stm =conn.createStatement();
		StringBuffer sql =new StringBuffer();
	    sql.append("	drop table ").append(tablename);
		stm.execute(sql.toString());
		stm.close();
		conn.close();
	} 
	private String getRelationTablename() throws SQLException {
		StringBuffer tablename = new StringBuffer();
		Car pojo = new Car();
		try {
			List<Car> list = query(pojo);
			if (list == null || list.size() == 0) {
				tablename.append("relation_").append(1);
				return tablename.toString();
			}
			List<Integer> seqlist = new ArrayList<Integer>();
			for (Car Car : list) {
				if (!StringUtil.isEmpty(Car.getTablename())) {
					Integer seq = Integer.parseInt(Car.getTablename()
							.split("_")[1]);
					seqlist.add(seq);
				}

			}
			Collections.sort(seqlist);
			int size = seqlist.size();
			int seq;
			if (size == 0) {
				seq = 1;
			} else if (size >= 2) {
				seq = Math.max(seqlist.get(0), seqlist.get(size - 1)) + 1;
			} else {
				seq = seqlist.get(0) + 1;
			}
			tablename.append("relation_").append(seq);
			return tablename.toString();
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		}

	}

	public static void main(String[] args) {
		IRelationService service = new RelationServiceImpl();

		Car pojo = new Car();
		pojo.setRid("402881ef2e7e5b5f012e8119a3de00d1");
		try {
			service.remove(pojo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/*
		 * pojo.setRid("402881ef2e7e5b5f012e8119a3de00d1");
		 * pojo.setAccount("wyq"); try { service.modify(pojo); } catch
		 * (SQLException e) { // TODO Auto-generated catch block
		 * e.printStackTrace(); }
		 */
		/*
		 * pojo.setAccount("wyq"); pojo.setCarstate("clzt01");
		 * pojo.setCreatetime(DateUtil.format(new Date()));
		 * pojo.setDeviceid("111"); pojo.setOwnername("xiaohaibing");
		 * pojo.setOwnerphone("18229490845"); pojo.setSim("001");
		 * pojo.setType("01"); pojo.setTypename("typename");
		 * pojo.setVehicleid("111"); try { service.save(pojo); } catch
		 * (SQLException e) { // TODO Auto-generated catch block
		 * e.printStackTrace(); }
		 */
	}

	public List<Car> queryAll(Car pojo) throws SQLException {
		SqlSession session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		 
		try {
			RelationDao dao = session.getMapper(RelationDao.class);
			List<Car> list = dao.queryAll(pojo);
			session.commit();
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			session.close();
		}
	}

	public List<VehicleInfNew> queryAllVehicleInfNew() throws SQLException {
		SqlSession session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		 
		try {
			RelationDao dao = session.getMapper(RelationDao.class);
			List<VehicleInfNew> list = dao.queryAllVehicleInfNew();
		 
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			session.close();
		}
	}

	public Car getCarByrid(String rid) throws SQLException {
		SqlSession session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		 
		try {
			RelationDao dao = session.getMapper(RelationDao.class);
			Car car = dao.getCarByrid(rid);
		 
			return car;
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			session.close();
		}
	}
}
