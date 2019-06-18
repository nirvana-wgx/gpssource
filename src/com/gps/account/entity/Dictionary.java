package com.gps.account.entity;

public class Dictionary implements java.io.Serializable {

	/**
	 * Êý¾Ý×Öµä
	 */
	private static final long serialVersionUID = 1L;
	private String d_code;
	private String d_value;
	private String d_type;
	private String d_typeName;
	private String name;
	private Integer start ;
	private Integer end  ;
	private Integer curentPage =1;
	private Integer pageSize=10;
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	public Integer getEnd() {
		return end;
	}
	public void setEnd(Integer end) {
		this.end = end;
	}
	public Integer getCurentPage() {
		return curentPage;
	}
	public void setCurentPage(Integer curentPage) {
		this.curentPage = curentPage;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public String getD_code() {
		return d_code;
	}
	public void setD_code(String d_code) {
		this.d_code = d_code;
	}
	public String getD_value() {
		return d_value;
	}
	public void setD_value(String d_value) {
		this.d_value = d_value;
	}
	public String getD_type() {
		return d_type;
	}
	public void setD_type(String d_type) {
		this.d_type = d_type;
	}
	public String getD_typeName() {
		return d_typeName;
	}
	public void setD_typeName(String name) {
		d_typeName = name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	 
	
}
