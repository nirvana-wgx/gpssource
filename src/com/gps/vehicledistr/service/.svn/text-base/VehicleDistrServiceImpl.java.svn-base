package com.gps.vehicledistr.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;

import com.gps.common.util.GetPosition;
import com.gps.common.util.MybatisUtil;
import com.gps.login.dao.AccountDao;
import com.gps.login.entity.Account;
import com.gps.service.BasicService;
import com.gps.vehicledistr.dao.OutAlarmDao;
import com.gps.vehicledistr.dao.VehicleInfNewDao;
import com.gps.vehicledistr.entity.OutAreaAlarm;
import com.gps.vehicledistr.entity.VehicleInfNew;
import com.gps.vehiclemng.dao.RelationDao;
import com.gps.vehiclemng.entity.Car;

public class VehicleDistrServiceImpl extends BasicService implements
		VehicleDistrService{
	List<Account> acList = new ArrayList<Account>();
	
	/**
	 * 获取车辆分布的数据
	 */
	public List<VehicleInfNew> getVehicleInf(Account account) throws Exception {
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		try{
			
			//根据当前账号获取对应子账号，生成一个包含本身账号和子账号的列表
			getAllChildAccount(account,session);
			List<String> dt = new ArrayList<String>();
			String name="";
			for(Account ac:acList){
				name=ac.getName();
				dt.add(name);
			}
			dt.add(account.getName());//添加本账号
			acList.clear();
			
			//根据账号列表，取出来对应的车辆信息列表
			RelationDao rtdao = session.getMapper(RelationDao.class);
			List<Car> carlist = rtdao.findCarByAccount(dt);//找出所有车辆
			List<String> dvid = new ArrayList<String>();
			String deviceid="";
			for(Car car:carlist){
				deviceid=car.getDeviceid();
				dvid.add(deviceid);
			}
			
			
			
			//根据车辆信息去最新车辆信息表中取对应的车辆数据信息
			VehicleInfNewDao vindao = session.getMapper(VehicleInfNewDao.class);
			List<VehicleInfNew> list = vindao.getListByDeviceid(dvid);
			
			//获取地理位置
			String lat = "";
			String lon="";
			String locate = "";
			for(VehicleInfNew vn:list){
				lat=getValue(vn.getLatitude());
				lon=getValue(vn.getLongitude());
				locate = GetPosition.getPositionByXY1(vn.getLongitude(),vn.getLatitude());
				vn.setLatitude(lat);
				vn.setLongitude(lon);
				vn.setLocate(locate);
			}
			
			/*VehicleInfNew vi1 = new VehicleInfNew("root","BM00000001","28.12345","112.59123","1935.45小时","正在工作","湖南省，长沙市，雨花区，广济桥社区");
			VehicleInfNew vi2 = new VehicleInfNew("root","BM00000002","29.90351","113.89251","814.21小时","休眠","湖南省，长沙市，雨花区，广济桥社区");
			VehicleInfNew vi3 = new VehicleInfNew("root","BM00000003","30.00351","112.69123","1935.45小时","正在工作","湖南省，长沙市，雨花区，广济桥社区");
			VehicleInfNew vi4 = new VehicleInfNew("root","BM00000004","25.24345","111.89123","1935.45小时","正在工作","湖南省，长沙市，雨花区，广济桥社区");
			list.add(vi1);
			list.add(vi2);
			list.add(vi3);
			list.add(vi4);*/
			return list;
		}catch(Exception e){
			e.printStackTrace();
			throw e;
		}finally{
			session.close();
		}
	}
	
	private static String getValue(String x){
		int begin = x.indexOf("度");
		String doX = x.substring(0, begin);
		int end = x.indexOf("分");
		String fenX = x.substring(begin + 1, end);
		double doXdouble = Double.valueOf(doX);
		double fenXdouble = Double.valueOf(fenX);
		double value = doXdouble + fenXdouble / 60;
		return value+"";
	}
	
	private void getAllChildAccount(Account account,SqlSession session) {
		
		AccountDao acdao = session.getMapper(AccountDao.class);
		
		
		// 找出当前账号对应子账号列表
		List<Account> childrenlist = acdao.findChildrenAc(account);

		// 遍历子账号列表，将子账号加入全局的子账号列表中,递归查找这些子账号的子账号列表
		for (Account children : childrenlist) {
			// 加入全局列表
			acList.add(children);
			// 递归调用
			getAllChildAccount(children,session);
		}
	}
	
	/**
	 * 获取越界报警的列表
	 */
	public List<OutAreaAlarm> getAlarmInf(Map<String, String> map)
			throws Exception {
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		try{
			OutAlarmDao dao = session.getMapper(OutAlarmDao.class);
			
			List<OutAreaAlarm> list = new ArrayList<OutAreaAlarm>();
			list = dao.getAlarmInf(map);
			return list;
		}catch(Exception e){
			e.printStackTrace();
			throw e;
		}finally{
			session.close();
		}
	}
}
