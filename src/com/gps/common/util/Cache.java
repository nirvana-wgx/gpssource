package com.gps.common.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.List;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.gps.account.entity.Dictionary;
import com.gps.account.service.DictionaryServiceImpl;
import com.gps.login.entity.Menu;
import com.gps.login.service.ILoginlogService;
import com.gps.login.service.LoginlogServiceImpl;
public class Cache {
	private Logger log =Logger.getLogger(Cache.class);
	static private List<Menu> menu;
	static private List<Menu> leftMenu;
	static private List<Dictionary> types;
	static private String ppm ;
	static private String ppc;
	public static String getPpm() {
		return ppm;
	}
	public static String getPpc() {
		return ppc;
	}
	public Cache(){
		
	}
	public void init(){
		log.info("init load cache....");
		ILoginlogService logService =new LoginlogServiceImpl(); 
		try {
			menu =logService.selectHeadMenu();
			leftMenu =logService.selectLeftMenu("2");
			types=new DictionaryServiceImpl().getTypes();
			InputStream inStream =getClass().getClassLoader().getResourceAsStream("gps.properties");
			Properties properties =new Properties();
			properties.load(inStream);
			ppm=properties.getProperty("ppm");
			ppc=properties.getProperty("ppc");
			log.info("ppm:	"+ppm);
			log.info("ppc:	"+ppc);
		} catch (SQLException e) {
			e.printStackTrace();
			log.info(e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
			log.info(e.getMessage());
		}
		 
		
	}
	public static List<Menu> getMenu() {
		return menu;
	}
	public static List<Menu> getLeftMenu() {
		return leftMenu;
	}
	public static List<Dictionary> getTypes() {
		return types;
	}
	 
	
}
