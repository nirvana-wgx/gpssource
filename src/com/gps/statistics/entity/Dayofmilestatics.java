package com.gps.statistics.entity;

import java.util.Date;

public class Dayofmilestatics implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String deviceid;
	private String mile;
	private String staticsdate;
	private Date createtime;
	
	public Dayofmilestatics(){}
	
	public Dayofmilestatics(String id,String deviceid,String mile,String staticsdate,Date createtime){
		this.id = id;
		this.deviceid = deviceid;
		this.mile = mile;
		this.staticsdate = staticsdate;
		this.createtime = createtime;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDeviceid() {
		return deviceid;
	}
	public void setDeviceid(String deviceid) {
		this.deviceid = deviceid;
	}
	public String getMile() {
		return mile;
	}
	public void setMile(String mile) {
		this.mile = mile;
	}
	public String getStaticsdate() {
		return staticsdate;
	}
	public void setStaticsdate(String staticsdate) {
		this.staticsdate = staticsdate;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
}
