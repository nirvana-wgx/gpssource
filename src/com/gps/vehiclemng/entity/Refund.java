package com.gps.vehiclemng.entity;


 
public class Refund implements java.io.Serializable{

	/**
	 * ����
	 */
	private static final long serialVersionUID = 1L;

	private String rid ;//����
	private String frid ;//����������
	private String refundmoney;//������
	private String refundtime ;//����ʱ��
	private String remainmoney;//ʣ����
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getFrid() {
		return frid;
	}
	public void setFrid(String frid) {
		this.frid = frid;
	}
	 
	public String getRefundtime() {
		return refundtime;
	}
	public void setRefundtime(String refundtime) {
		this.refundtime = refundtime;
	}
	public String getRefundmoney() {
		return refundmoney;
	}
	public void setRefundmoney(String refundmoney) {
		this.refundmoney = refundmoney;
	}
	public String getRemainmoney() {
		return remainmoney;
	}
	public void setRemainmoney(String remainmoney) {
		this.remainmoney = remainmoney;
	}
	 
}
