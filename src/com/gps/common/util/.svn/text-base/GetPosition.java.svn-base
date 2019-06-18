package com.gps.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.canna.geodata.GeoData;
import com.mapprsoft.zion.geo.core.GeoMapImpl;

public class GetPosition extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	static GeoData geoData;

	
	public GetPosition(){
		
	}

	public void destroy()
	{
		super.destroy();
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{

		String x = request.getParameter("x");
		String y = request.getParameter("y");
		String gisdata = "";

		if ((x != null) && (x.trim().length() > 0) && (y != null)
				&& (y.trim().length() > 0))
		{
			try
			{
				gisdata = getDiscInfo(Double.parseDouble(x), Double.parseDouble(y));
			}
			catch (Exception e)
			{
			}
		}

		request.getSession().setAttribute("gisdata", gisdata);
		return;
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		doGet(request, response);
	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occure
	 */
	@Override
	public void init() throws ServletException
	{
		try{
		if (geoData == null)
		{
			geoData = new GeoData();//D:/pony/eclipse/workspace/felix/temp/cm/com/mapprsoft/zion/geocoding/core/china
//			geoData.load("E:/pony/china_desc.ppm","E:/pony/china_desc.ppc");
			geoData.load(Cache.getPpm(),Cache.getPpc());
			//String locate=GetPosition.getPositionByXY1("113.89251","29.90351");//"101度25.00897分","30度04.20226分"
			//System.out.println(locate);
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}

	private synchronized String getDiscInfo(Double x, Double y)
	{
		String discInfo = "";
		try
		{GeoData geoData=null;
			GeoMapImpl geoMap = new GeoMapImpl(geoData);
			discInfo = geoMap.positionDescript(x.doubleValue(),
					y.doubleValue(), "0000000007", "00000001F8", 10000,
					"FFFFFFFE", 10000);
		}
		catch (Exception exception)
		{
		}
		return discInfo;
	}

	public static String getPositionByXY(String x, String y) {
		String discInfo = "";
		try {
//			GeoData geoData = null;
//			geoData = new GeoData();
			GeoMapImpl geoMap = new GeoMapImpl(geoData);
			discInfo = geoMap.positionDescript(GetValue(x), GetValue(y),"0000000007", "00000001F8", 10000, "FFFFFFFE", 10000);
		} catch (Exception exception) {
			exception.printStackTrace();
		}
//		 if(x!=null && x.length()>0 &&y!=null&&y.length()>0){
//		 discInfo=sendGet("http://219.236.247.123:9094/DiscInfo/getDisc","pointX="+GetValue(x)+"&pointY="+GetValue(y));
//		 }
		return discInfo;

	}
	

	public static String getPositionByXY1(String x, String y) {
		String discInfo = "";
		try {
//			GeoData geoData = null;
//			geoData = new GeoData();
			System.out.println(GetValue(x));System.out.println(GetValue(y));
			GeoMapImpl geoMap = new GeoMapImpl(geoData);
			discInfo = geoMap.positionDescript(GetValue(x), GetValue(y),"0000000007", "00000001F8", 10000, "FFFFFFFE", 10000);
		} catch (Exception exception) {
			exception.printStackTrace();
		}
//		 if(x!=null && x.length()>0 &&y!=null&&y.length()>0){
//		 discInfo=sendGet("http://219.236.247.123:9094/DiscInfo/getDisc","pointX="+GetValue(x)+"&pointY="+GetValue(y));
//		 }
		return discInfo;

	}
	
	public static String sendGet(String url, String param) {
		String result = "";
		BufferedReader in = null;
		try {
			String urlName = url + "?" + param;
			URL realUrl = new URL(urlName);
			// 打开和URL之间的连接
			URLConnection conn = realUrl.openConnection();
			// 设置通用的请求属性
			conn.setRequestProperty("accept", "*/*");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("user-agent",
					"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)");
			// 建立实际的连接
			conn.connect();
			// 获取所有响应头字段
			// Map<String,List<String>> map = conn.getHeaderFields();
			// // 遍历所有的响应头字段
			// for (String key : map.keySet())
			// {
			// System.out.println(key + "--->" + map.get(key));
			// }
			// 定义BufferedReader输入流来读取URL的响应
			in = new BufferedReader(new InputStreamReader(
					conn.getInputStream(), "UTF8"));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			System.out.println("发送GET请求出现异常！" + e);
			e.printStackTrace();
		}
		// 使用finally块来关闭输入流
		finally {
			try {
				if (in != null) {
					in.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		return result;
	}

	private static double GetValue(String x)
	{
		if(x.indexOf("度")==-1){
			return 0.0;
		}
		if(x.indexOf("分")==-1){
			return 0.0;
		}
		int begin = x.indexOf("度");
		String doX = x.substring(0, begin);
		int end = x.indexOf("分");
		String fenX = x.substring(begin + 1, end);
		double doXdouble = Double.valueOf(doX);
		double fenXdouble = Double.valueOf(fenX);
		
		double value = doXdouble + Double.valueOf(MathUtil.cut(fenXdouble / 60, 5));
		System.out.println(value);
		return value;
	}
}