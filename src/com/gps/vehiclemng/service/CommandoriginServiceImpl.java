package com.gps.vehiclemng.service;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.time.DateUtils;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;

import com.gps.common.util.DateUtil;
import com.gps.common.util.MybatisUtil;
import com.gps.vehiclemng.entity.CmdDown;
import com.gps.vehiclemng.dao.CommandoriginDao;
import com.gps.vehiclemng.entity.Commandorigin;

public class CommandoriginServiceImpl implements ICommandoriginService {

	public int save(Commandorigin commandorigin) throws SQLException {
		SqlSession session =MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		try{
			CommandoriginDao dao =session.getMapper(CommandoriginDao.class);
			int result =dao.save(commandorigin);
			session.commit();
			return result;
		}catch(SQLException e){
			e.printStackTrace();
			throw e;
		}finally{
			session.close();
		}
	}
	public List<Commandorigin> getCommandoriginList(String deviceid,
			String serstarttime, String serendtime, int page_no, int page_num) throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		CommandoriginDao commandorigindao = session.getMapper(CommandoriginDao.class);
		HashMap<String,Object> map = new HashMap<String, Object>();
		int start = getStartNum(page_no, page_num);
		int end = getEndNum(page_no, page_num);
		map.put("deviceid", deviceid);
		map.put("serstarttime", serstarttime);
		map.put("serendtime", serendtime);
		map.put("start", start);
		map.put("end", end);
		List<Commandorigin> list = commandorigindao.getCommandoriginList(map);
		session.close();
		return list;
	}

	public int getCommandoriginCount(String deviceid, String serstarttime, String serendtime)
			throws SQLException {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		CommandoriginDao commandorigindao = session.getMapper(CommandoriginDao.class);		
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("deviceid", deviceid);
		map.put("serstarttime", serstarttime);
		map.put("serendtime", serendtime);
		int count = commandorigindao.getCommandoriginCount(map);
		session.close();
		return count;
	}
	
	/**
	 * ָ���·�
	 */
	public boolean send(String phone, String device, String commandcode,
			String commandparameter, String csid) {
		SqlSession  session = MybatisUtil.getSqlsessionfactory().openSession(ExecutorType.REUSE);
		CommandoriginDao commandorigindao = session.getMapper(CommandoriginDao.class);	
		try{
			// ��Ϣ����
			String content = "";
			String devicehead = device.substring(0, 2);
			if(devicehead.equals("YW")){
				content=parseContentOther(commandcode,phone,device,commandparameter);
			}else{
				content=parseContent(commandcode, commandparameter, device);
			}
			System.out.println("�������" + content);
			String createtime = DateUtil.formatMaskNull(new Date(), "yyyy-MM-dd HH:mm:ss");
			
			CmdDown cd = new CmdDown(phone,content,createtime,"","0","0");
			commandorigindao.insert(cd);

			// ����Ϊ�Ѿ�����״̬
			//commandorigindao.merge(csid);
			session.commit();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			session.close();
		}
		return true;
	}
	
	/**
	 * �����豸���·�ָ������
	 * @param commandcode
	 * @param commandparameter
	 * @param device
	 * @return
	 */
	private String parseContent(String commandcode, String commandparameter,
			String device) {

		if (commandcode.equalsIgnoreCase("GE3007"))
			commandcode += "01";
		String content = commandcode + commandparameter;

		content = content.toUpperCase();

		StringBuilder builderAll = new StringBuilder();
		StringBuilder builder = new StringBuilder();
		builderAll.append("#BM,").append(device);

		Calendar calendar = Calendar.getInstance();

		builder.append(String.valueOf(calendar.get(Calendar.YEAR)).substring(2,
				4));
		String month = String.valueOf(calendar.get(Calendar.MONTH) + 1);
		while (month.length() < 2)
			month = "0" + month;
		builder.append(month);

		String day = String.valueOf(calendar.get(Calendar.DAY_OF_MONTH));
		while (day.length() < 2)
			day = "0" + day;
		builder.append(day);

		String hour = String.valueOf(calendar.get(Calendar.HOUR_OF_DAY));
		while (hour.length() < 2)
			hour = "0" + hour;
		builder.append(hour);

		String minute = String.valueOf(calendar.get(Calendar.MINUTE));
		while (minute.length() < 2)
			minute = "0" + minute;
		builder.append(minute);

		String second = String.valueOf(calendar.get(Calendar.SECOND));
		while (second.length() < 2)
			second = "0" + second;
		builder.append(second);

		builderAll.append(builder.toString());

		char[] p = builder.toString().toCharArray();
		int h = 0;
		for (char c : p) {
			h = 5 * h + (c - 0x30);
		}
		h = h % 1000000;
		String strSum = String.valueOf(h);
		while (strSum.trim().length() < 6)
			strSum = "0" + strSum;
		builderAll.append(strSum).append(content);
		content = builderAll.toString();

		p = content.toCharArray();
		// char sum = 0;
		// for (char c : p) {
		// sum += c;
		// }
		int sum = 0;
		for (char c : p) {
			sum += (int) c;
		}
		strSum = Integer.toHexString(sum);
		strSum = strSum.substring(strSum.length() - 2, strSum.length());
		content = content + "*" + strSum;
		System.out.println(content);
		return content.toUpperCase();
	}
	
	/**
	 * ���������豸���·�ָ������
	 * @param page_no
	 * @param page_num
	 * @return
	 */
	private String parseContentOther(String commandcode, String phone,String device,String sjjg){
		String str1 = "AT+GTGBC=gl500,,"+device+",,,0,,,00000000000000,0900,24,1,";
		String str2 = ",5,0,0,0,0,-20+60,0,,,FFFF$";
		String upmethod = "0";//�ϴ�ģʽ
		String timejg = "1";
		if(commandcode.equals("GL0001")){//�����ϴ�
			upmethod="0";
			timejg="1";
		}else if(commandcode.equals("GL0002")){//�����ϴ�
			upmethod="1";
			timejg=sjjg;
		}
		str1 = str1+upmethod+","+timejg+str2;
		return str1;
	}
	
	private int getStartNum(int page_no, int page_num) {
		return page_num * ( page_no - 1) + 1;
	}
	
	private int getEndNum(int page_no, int page_num) {
		return page_num * ( page_no - 1) + page_num;
	}
	 
}