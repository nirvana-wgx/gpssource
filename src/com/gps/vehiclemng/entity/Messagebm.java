package com.gps.vehiclemng.entity;

import java.text.DecimalFormat;
import java.util.Date;

/**
 * Messagebm generated by MyEclipse Persistence Tools
 */

public class Messagebm implements java.io.Serializable {
	// Fields
	DecimalFormat decimalFormat = new DecimalFormat("#,##0.00000000");
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String mbmid;

	private String deviceid;

	private String infotype;

	private Date receivetime;

	private String gpslocate;

	private String gpsshell;

	private String gpsantenna;

	private String gpsrelay4;

	private String gpsrelay3;

	private String gpsrelay2;

	private String gpsrelay1;

	private String gpssleep;

	private String gpsminitor;

	private String gpspattern;

	private String gpsautolocktwomonth;

	private String gpsautolockshell;

	private String gpsautolockantenna;

	private String gpsautolockmain;

	private String carengine;

	private String carkey;

	private String satellitevisible;

	private String satelliteusable;

	private String latitude;

	private String longitude;

	private String speed;

	private String location;

	private Date locatetime;

	private String voltage;

	private String worktime;

	private String watertemperature;

	private String oiltemperature;

	private String oilpressure;

	private String oillevel;

	private String rotaryspeed;

	private String warnys;

	private String warncd;

	private String warnry;

	private String warnyy;

	private String warnsw;

	private String warnyw;

	private String warnyl;

	private String warnkl;

	private String warndydy;

	private Date collecttime;

	private String backup;

	private String envtemperature;
	
	private String positioninfo;
	
	private String outalarm;

	// Constructors

	/** default constructor */
	public Messagebm() {
	}

	/** full constructor */
	public Messagebm(String mbmid, String deviceid, String infotype, Date receivetime,
			String gpslocate, String gpsshell, String gpsantenna,
			String gpsrelay4, String gpsrelay3, String gpsrelay2,
			String gpsrelay1, String gpssleep, String gpsminitor,
			String gpspattern, String gpsautolocktwomonth,
			String gpsautolockshell, String gpsautolockantenna,
			String gpsautolockmain, String carengine, String carkey,
			String satellitevisible, String satelliteusable, String latitude,
			String longitude, String speed, String location, Date locatetime,
			String voltage, String worktime, String watertemperature,
			String oiltemperature, String oilpressure, String oillevel,
			String rotaryspeed, String warnys, String warncd, String warnry,
			String warnyy, String warnsw, String warnyw, String warnyl,
			String warnkl, String warndydy, Date collecttime, String backup,
			String envtemperature, String positioninfo, String outalarm) {
		this.mbmid = mbmid;
		this.deviceid = deviceid;
		this.infotype = infotype;
		this.receivetime = receivetime;
		this.gpslocate = gpslocate;
		this.gpsshell = gpsshell;
		this.gpsantenna = gpsantenna;
		this.gpsrelay4 = gpsrelay4;
		this.gpsrelay3 = gpsrelay3;
		this.gpsrelay2 = gpsrelay2;
		this.gpsrelay1 = gpsrelay1;
		this.gpssleep = gpssleep;
		this.gpsminitor = gpsminitor;
		this.gpspattern = gpspattern;
		this.gpsautolocktwomonth = gpsautolocktwomonth;
		this.gpsautolockshell = gpsautolockshell;
		this.gpsautolockantenna = gpsautolockantenna;
		this.gpsautolockmain = gpsautolockmain;
		this.carengine = carengine;
		this.carkey = carkey;
		this.satellitevisible = satellitevisible;
		this.satelliteusable = satelliteusable;
		this.latitude = latitude;
		this.longitude = longitude;
		this.speed = speed;
		this.location = location;
		this.locatetime = locatetime;
		this.voltage = voltage;
		this.worktime = worktime;
		this.watertemperature = watertemperature;
		this.oiltemperature = oiltemperature;
		this.oilpressure = oilpressure;
		this.oillevel = oillevel;
		this.rotaryspeed = rotaryspeed;
		this.warnys = warnys;
		this.warncd = warncd;
		this.warnry = warnry;
		this.warnyy = warnyy;
		this.warnsw = warnsw;
		this.warnyw = warnyw;
		this.warnyl = warnyl;
		this.warnkl = warnkl;
		this.warndydy = warndydy;
		this.collecttime = collecttime;
		this.backup = backup;
		this.envtemperature = envtemperature;
		this.positioninfo = positioninfo;
		this.outalarm = outalarm;
	}

	// Property accessors

	public String getMbmid() {
		return this.mbmid;
	}

	public void setMbmid(String mbmid) {
		this.mbmid = mbmid;
	}

	public String getDeviceid() {
		return this.deviceid;
	}

	public void setDeviceid(String deviceid) {
		this.deviceid = deviceid;
	}

	public String getInfotype() {
		return this.infotype;
	}

	public void setInfotype(String infotype) {
		this.infotype = infotype;
	}

	public Date getReceivetime() {
		return this.receivetime;
	}

	public void setReceivetime(Date receivetime) {
		this.receivetime = receivetime;
	}

	public String getGpslocate() {
		return this.gpslocate;
	}

	public void setGpslocate(String gpslocate) {
		this.gpslocate = gpslocate;
	}

	public String getGpsshell() {
		return this.gpsshell;
	}

	public void setGpsshell(String gpsshell) {
		this.gpsshell = gpsshell;
	}

	public String getGpsantenna() {
		return this.gpsantenna;
	}

	public void setGpsantenna(String gpsantenna) {
		this.gpsantenna = gpsantenna;
	}

	public String getGpsrelay4() {
		return this.gpsrelay4;
	}

	public void setGpsrelay4(String gpsrelay4) {
		this.gpsrelay4 = gpsrelay4;
	}

	public String getGpsrelay3() {
		return this.gpsrelay3;
	}

	public void setGpsrelay3(String gpsrelay3) {
		this.gpsrelay3 = gpsrelay3;
	}

	public String getGpsrelay2() {
		return this.gpsrelay2;
	}

	public void setGpsrelay2(String gpsrelay2) {
		this.gpsrelay2 = gpsrelay2;
	}

	public String getGpsrelay1() {
		return this.gpsrelay1;
	}

	public void setGpsrelay1(String gpsrelay1) {
		this.gpsrelay1 = gpsrelay1;
	}

	public String getGpssleep() {
		return this.gpssleep;
	}

	public void setGpssleep(String gpssleep) {
		this.gpssleep = gpssleep;
	}

	public String getGpsminitor() {
		return this.gpsminitor;
	}

	public void setGpsminitor(String gpsminitor) {
		this.gpsminitor = gpsminitor;
	}

	public String getGpspattern() {
		return this.gpspattern;
	}

	public void setGpspattern(String gpspattern) {
		this.gpspattern = gpspattern;
	}

	public String getGpsautolocktwomonth() {
		return this.gpsautolocktwomonth;
	}

	public void setGpsautolocktwomonth(String gpsautolocktwomonth) {
		this.gpsautolocktwomonth = gpsautolocktwomonth;
	}

	public String getGpsautolockshell() {
		return this.gpsautolockshell;
	}

	public void setGpsautolockshell(String gpsautolockshell) {
		this.gpsautolockshell = gpsautolockshell;
	}

	public String getGpsautolockantenna() {
		return this.gpsautolockantenna;
	}

	public void setGpsautolockantenna(String gpsautolockantenna) {
		this.gpsautolockantenna = gpsautolockantenna;
	}

	public String getGpsautolockmain() {
		return this.gpsautolockmain;
	}

	public void setGpsautolockmain(String gpsautolockmain) {
		this.gpsautolockmain = gpsautolockmain;
	}

	public String getCarengine() {
		return this.carengine;
	}

	public void setCarengine(String carengine) {
		this.carengine = carengine;
	}

	public String getCarkey() {
		return this.carkey;
	}

	public void setCarkey(String carkey) {
		this.carkey = carkey;
	}

	public String getSatellitevisible() {
		return this.satellitevisible;
	}

	public void setSatellitevisible(String satellitevisible) {
		this.satellitevisible = satellitevisible;
	}

	public String getSatelliteusable() {
		return this.satelliteusable;
	}

	public void setSatelliteusable(String satelliteusable) {
		this.satelliteusable = satelliteusable;
	}

	public String getLatitude() {
		return this.latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return this.longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getSpeed() {
		return this.speed;
	}

	public void setSpeed(String speed) {
		this.speed = speed;
	}

	public String getLocation() {
		return this.location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public Date getLocatetime() {
		return this.locatetime;
	}

	public void setLocatetime(Date locatetime) {
		this.locatetime = locatetime;
	}

	public String getVoltage() {
		return this.voltage;
	}

	public void setVoltage(String voltage) {
		this.voltage = voltage;
	}

	public String getWorktime() {
		return this.worktime;
	}

	public void setWorktime(String worktime) {
		this.worktime = worktime;
	}

	public String getWatertemperature() {
		return this.watertemperature;
	}

	public void setWatertemperature(String watertemperature) {
		this.watertemperature = watertemperature;
	}

	public String getOiltemperature() {
		return this.oiltemperature;
	}

	public void setOiltemperature(String oiltemperature) {
		this.oiltemperature = oiltemperature;
	}

	public String getOilpressure() {
		return this.oilpressure;
	}

	public void setOilpressure(String oilpressure) {
		this.oilpressure = oilpressure;
	}

	public String getOillevel() {
		return this.oillevel;
	}

	public void setOillevel(String oillevel) {
		this.oillevel = oillevel;
	}

	public String getRotaryspeed() {
		return this.rotaryspeed;
	}

	public void setRotaryspeed(String rotaryspeed) {
		this.rotaryspeed = rotaryspeed;
	}

	public String getWarnys() {
		return this.warnys;
	}

	public void setWarnys(String warnys) {
		this.warnys = warnys;
	}

	public String getWarncd() {
		return this.warncd;
	}

	public void setWarncd(String warncd) {
		this.warncd = warncd;
	}

	public String getWarnry() {
		return this.warnry;
	}

	public void setWarnry(String warnry) {
		this.warnry = warnry;
	}

	public String getWarnyy() {
		return this.warnyy;
	}

	public void setWarnyy(String warnyy) {
		this.warnyy = warnyy;
	}

	public String getWarnsw() {
		return this.warnsw;
	}

	public void setWarnsw(String warnsw) {
		this.warnsw = warnsw;
	}

	public String getWarnyw() {
		return this.warnyw;
	}

	public void setWarnyw(String warnyw) {
		this.warnyw = warnyw;
	}

	public String getWarnyl() {
		return this.warnyl;
	}

	public void setWarnyl(String warnyl) {
		this.warnyl = warnyl;
	}

	public String getWarnkl() {
		return this.warnkl;
	}

	public void setWarnkl(String warnkl) {
		this.warnkl = warnkl;
	}

	public String getWarndydy() {
		return this.warndydy;
	}

	public void setWarndydy(String warndydy) {
		this.warndydy = warndydy;
	}

	public Date getCollecttime() {
		return this.collecttime;
	}

	public void setCollecttime(Date collecttime) {
		this.collecttime = collecttime;
	}

	public String getBackup() {
		return this.backup;
	}

	public void setBackup(String backup) {
		this.backup = backup;
	}

	public String getEnvtemperature() {
		return this.envtemperature;
	}

	public void setEnvtemperature(String envtemperature) {
		this.envtemperature = envtemperature;
	}

	public String getPositioninfo() {
		return positioninfo;
	}

	public void setPositioninfo(String positioninfo) {
		this.positioninfo = positioninfo;
	}

	public String getOutalarm() {
		return outalarm;
	}

	public void setOutalarm(String outalarm) {
		this.outalarm = outalarm;
	}
	
	public String getLatitudeEx() {
		String lat = "";
		if (latitude != null && latitude.trim().length() != 0) {
			int begin = latitude.indexOf("度");
			String doX = latitude.substring(0, begin);
			int end = latitude.indexOf("分");
			String fenX = latitude.substring(begin + 1, end);
			double fenDouble = Double.parseDouble(fenX);
			fenDouble /= 60;
			String fenString = decimalFormat.format(fenDouble);
			lat = doX + fenString.substring(1);
		}
		return lat;
	}

	public String getLongitudeEx() {
		String lon = "";
		if (longitude != null && longitude.trim().length() != 0) {
			int begin = longitude.indexOf("度");
			String doX = longitude.substring(0, begin);
			int end = longitude.indexOf("分");
			String fenX = longitude.substring(begin + 1, end);
			double fenDouble = Double.parseDouble(fenX);
			fenDouble /= 60;
			String fenString = decimalFormat.format(fenDouble);
			lon = doX + fenString.substring(1);
		}
		return lon;
	}

}