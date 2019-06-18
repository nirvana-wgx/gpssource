package com.gps.alarm.entity;

public class SellAlarm implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String vehicleid;
	private String account;
	private String exptime;
	private int totmonth;
	private double totamt;
	private String paymonth;
	private int payterm;
	private String refundmoney;
	private int month_count;
	private String paywarndate;
	private String refundtime;
	public String getVehicleid() {
		return vehicleid;
	}
	public void setVehicleid(String vehicleid) {
		this.vehicleid = vehicleid;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getExptime() {
		return exptime;
	}
	public void setExptime(String exptime) {
		this.exptime = exptime;
	}
	public int getTotmonth() {
		return totmonth;
	}
	public void setTotmonth(int totmonth) {
		this.totmonth = totmonth;
	}
	public double getTotamt() {
		return totamt;
	}
	public void setTotamt(double totamt) {
		this.totamt = totamt;
	}
	public String getPaymonth() {
		return paymonth;
	}
	public void setPaymonth(String paymonth) {
		this.paymonth = paymonth;
	}
	public int getPayterm() {
		return payterm;
	}
	public void setPayterm(int payterm) {
		this.payterm = payterm;
	}
	public String getRefundmoney() {
		return refundmoney;
	}
	public void setRefundmoney(String refundmoney) {
		this.refundmoney = refundmoney;
	}
	public String getPaywarndate() {
		return paywarndate;
	}
	public void setPaywarndate(String paywarndate) {
		this.paywarndate = paywarndate;
	}
	public String getRefundtime() {
		return refundtime;
	}
	public void setRefundtime(String refundtime) {
		this.refundtime = refundtime;
	}
	public int getMonth_count() {
		return month_count;
	}
	public void setMonth_count(int month_count) {
		this.month_count = month_count;
	}	
	
}
