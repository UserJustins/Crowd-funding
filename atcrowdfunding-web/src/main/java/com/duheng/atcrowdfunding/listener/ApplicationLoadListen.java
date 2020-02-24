package com.duheng.atcrowdfunding.listener;

import com.duheng.crowdfunding.utils.Const;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * 上下文路径监听器
 */
public class ApplicationLoadListen implements ServletContextListener{
	
	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		//获取上下文 
		ServletContext application = arg0.getServletContext();
		//获取上下文的路径
		String contextPath = application.getContextPath();
		//将上下文路径放到application域中
		application.setAttribute(Const.PATH, contextPath);
		
	}
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	

}
