package com.gps.vehiclemng.entity;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.Date;

public class OffSet implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	DecimalFormat decimalFormat = new DecimalFormat("#,##0.00000000");

	// Fields
	
	private double lng;//经度

	private double lat;//纬度

	private double offsetlng;//经度

	private double offsetlat;//纬度

	
}