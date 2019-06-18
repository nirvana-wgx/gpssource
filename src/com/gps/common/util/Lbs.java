package com.gps.common.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

public class Lbs {
	public static final String GET_URL = "http://api.zdoz.net/transgpsbd.aspx";
 
    public static final String POST_URL = "http://www.cngolon.com/request.action";
    
    //get()����
    public static Map<String,String> readContentFromGet(String lat,String lng) throws IOException{
    	Map<String,String> map = new HashMap<String, String>();
    	
        // ƴ��get�����URL�ִ���ʹ��URLEncoder.encode������Ͳ��ɼ��ַ����б���
        String getURL = GET_URL + "?lat="+lat+"&lng="+lng; //+ URLEncoder.encode("�й�����", "utf-8");
        URL getUrl = new URL(getURL);
        // ����ƴ�յ�URL�������ӣ�URL.openConnection���������URL�����ͣ�
        // ���ز�ͬ��URLConnection����Ķ�������URL��һ��http�����ʵ�ʷ��ص���HttpURLConnection
        HttpURLConnection connection = (HttpURLConnection) getUrl.openConnection();
        // �������ӣ�����ʵ����get requestҪ����һ���connection.getInputStream()�����вŻ���������
        // ������
        connection.connect();
        // ȡ������������ʹ��Reader��ȡ
        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"utf-8"));//���ñ���,������������

        String lines;
        while ((lines = reader.readLine()) != null){
        	//lines = new String(lines.getBytes(), "utf-8");
            String[] step1 = new String[2];
            String[] step2 = new String[2];
            step1 = lines.split(",");
            step2 = step1[0].split(":");
            String lngidute = step2[1];
            step2 = step1[1].split(":");
            String latidute = step2[1];
            
            map.put("lng", lngidute);
            map.put("lat", latidute.substring(0,latidute.length()-1));
        }
        
        reader.close();
        // �Ͽ�����
        connection.disconnect();

        return map;
    }
        
    //post()����
	public static void readContentFromPost() throws IOException{
        // Post�����url����get��ͬ���ǲ���Ҫ������
        URL postUrl = new URL(POST_URL);
        // ������
        HttpURLConnection connection = (HttpURLConnection) postUrl
                .openConnection();
        // Output to the connection. Default is
        // false, set to true because post
        // method must write something to the
        // connection
        // �����Ƿ���connection�������Ϊ�����post���󣬲���Ҫ����
        // http�����ڣ������Ҫ��Ϊtrue
        connection.setDoOutput(true);
        // Read from the connection. Default is true.
        connection.setDoInput(true);
        // Set the post method. Default is GET
        connection.setRequestMethod("POST");
        // Post cannot use caches
        // Post ������ʹ�û���
        connection.setUseCaches(false);
        // This method takes effects to
        // every instances of this class.
        // URLConnection.setFollowRedirects��static���������������е�URLConnection����
        // connection.setFollowRedirects(true);
 
        // This methods only
        // takes effacts to this
        // instance.
        // URLConnection.setInstanceFollowRedirects�ǳ�Ա�������������ڵ�ǰ����
        connection.setInstanceFollowRedirects(true);
        // Set the content type to urlencoded,
        // because we will write
        // some URL-encoded content to the
        // connection. Settings above must be set before connect!
        // ���ñ������ӵ�Content-type������Ϊapplication/x-www-form-urlencoded��
        // ��˼��������urlencoded�������form�������������ǿ��Կ������Ƕ���������ʹ��URLEncoder.encode
        // ���б���
        connection.setRequestProperty("Content-Type",
                "application/x-www-form-urlencoded");
        // ���ӣ���postUrl.openConnection()���˵����ñ���Ҫ��connect֮ǰ��ɣ�
        // Ҫע�����connection.getOutputStream�������Ľ���connect��
        connection.connect();
        DataOutputStream out = new DataOutputStream(connection
                .getOutputStream());
        // The URL-encoded contend
        // ���ģ�����������ʵ��get��URL��'?'��Ĳ����ַ���һ��
        String content = "key=j0r53nmbbd78x7m1pqml06u2&type=1&toemail=cngolon@gmail.com" + "&activatecode=" + URLEncoder.encode("�й�����", "utf-8");
        // DataOutputStream.writeBytes���ַ����е�16λ��unicode�ַ���8λ���ַ���ʽд��������
        out.writeBytes(content); 
        out.flush();
        out.close(); // flush and close
        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"utf-8"));//���ñ���,������������
        String line="";
        System.out.println("=============================");
        System.out.println("Contents of post request");
        System.out.println("=============================");
        while ((line = reader.readLine()) != null){
            //line = new String(line.getBytes(), "utf-8");
            System.out.println(line);
        }
        System.out.println("=============================");
        System.out.println("Contents of post request ends");
        System.out.println("=============================");
        reader.close();
        connection.disconnect();
    }
    
    public static void main(String[] args){
    	try {
			readContentFromGet("28.230875574758546","113.12280436550694");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}
