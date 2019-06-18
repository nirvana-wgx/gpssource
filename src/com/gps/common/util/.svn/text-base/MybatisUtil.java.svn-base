package com.gps.common.util;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public final class MybatisUtil {

	private static SqlSessionFactory sessionFactory;   
	   
	  
	    static {   
	    	 String resource = "mybatis3-config.xml";   
	         InputStream inputStream = null;   
        try {   
	            inputStream = Resources.getResourceAsStream(resource);   
	       } catch (IOException e) {   
	             e.printStackTrace();   
	        }   
	         sessionFactory = new SqlSessionFactoryBuilder().build(inputStream);   
	    }   
   
	    public static SqlSessionFactory getSqlsessionfactory() {   
	         return sessionFactory;   
	    }   
	   
	    public static SqlSession getSession() {   
         return sessionFactory.openSession(false);   
	     }   
	   
	   public void closeSession(SqlSession session) {   
        if (session != null) {   
             session.close();   
             session = null;   
        }   
	    } 

}
