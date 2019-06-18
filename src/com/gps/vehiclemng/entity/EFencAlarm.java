package com.gps.vehiclemng.entity;


 
public class EFencAlarm implements java.io.Serializable{

	/**
	 * 电子围栏配置
	 */
	private static final long serialVersionUID = 1L;

	private String id ;//主键
	private String deviceid;//设备号
	private String fenname;//围栏名称
	private String creattime;//创建时间
	private String fencontent;//围栏经纬度内容
	private String type;//报警类型1-如界2-出界
	
	public EFencAlarm(){}
	
	public EFencAlarm(String id,String deviceid,String fenname,String creattime,String fencontent,String type){
		this.id = id;
		this.deviceid = deviceid;
		this.fenname = fenname;
		this.creattime = creattime;
		this.fencontent = fencontent;
		this.type = type;
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
	public String getFenname() {
		return fenname;
	}
	public void setFenname(String fenname) {
		this.fenname = fenname;
	}
	public String getCreattime() {
		return creattime;
	}
	public void setCreattime(String creattime) {
		this.creattime = creattime;
	}
	public String getFencontent() {
		return fencontent;
	}
	public void setFencontent(String fencontent) {
		this.fencontent = fencontent;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	 
}
