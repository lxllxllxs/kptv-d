package com.xly.ess.test;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.jexl2.JexlContext;
import org.apache.commons.jexl2.MapContext;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.security.core.userdetails.UserDetails;


import com.bstek.bdf2.core.context.CoreContextLocationConfigurer;
import com.bstek.bdf2.core.context.OrmContextLocationConfigurer;
import com.bstek.dorado.core.CommonContext;
import com.bstek.dorado.core.Configure;
import com.bstek.dorado.core.ConfigureStore;
import com.bstek.dorado.core.EngineStartupListenerManager;
import com.bstek.dorado.core.el.DefaultExpressionHandler;
import com.bstek.dorado.core.el.Expression;
import com.bstek.dorado.core.el.ExpressionHandler;
import com.bstek.dorado.core.io.BaseResourceLoader;
import com.bstek.dorado.core.pkgs.PackageConfigurer;
import com.bstek.dorado.web.ConsoleUtils;
import com.bstek.dorado.web.loader.DoradoLoader;

import junit.framework.TestCase;

public class Sample1 extends TestCase {
	private static final Log logger = LogFactory.getLog(DoradoLoader.class);
	
	private String locations = "";
	
	public Sample1() {
		addExtensionContextConfigLocation("com/bstek/dorado/core/context.xml");
		addExtensionContextConfigLocation("com/bstek/dorado/config/context.xml");
		addExtensionContextConfigLocation("com/bstek/dorado/common/context.xml");
		addExtensionContextConfigLocation("com/bstek/dorado/data/context.xml");
		addExtensionContextConfigLocation("com/bstek/dorado/view/context.xml");
		addExtensionContextConfigLocation("com/bstek/dorado/web/context.xml");
		
		PackageConfigurer configure = new CoreContextLocationConfigurer();
		addAddonConfigs(configure);
		configure = new OrmContextLocationConfigurer();
		addAddonConfigs(configure);
		/*
		loadConfigureProperties("bdf2-uflo.properties");
		loadConfigureProperties("uflo-client.properties");
		loadConfigureProperties("uflo-console.properties");

		addExtensionContextConfigLocation("uflo-context-configs.xml");		
		addExtensionContextConfigLocation("uflo-console-configs.xml");		
		addExtensionContextConfigLocation("uflo-client-configs.xml");
		*/
		addExtensionContextConfigLocation("com/bstek/dorado/sample/test-context.xml");
	}
	
	private void addAddonConfigs(PackageConfigurer configure){
		try {
			BaseResourceLoader resourceLoader = new BaseResourceLoader();
			String[] propertieFiles;
				propertieFiles = configure.getPropertiesConfigLocations(resourceLoader);
			for (String propertyFile: propertieFiles){
				loadConfigureProperties(propertyFile);
			}
			String[] contextFiles = configure.getContextConfigLocations(resourceLoader);
			for (String contextFile: contextFiles){
				addExtensionContextConfigLocation(contextFile);
			}
			String[] servletContextFiles = configure.getServletContextConfigLocations(resourceLoader);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private void loadConfigureProperties(String configureLocation) {
		ConfigureStore configureStore = Configure.getStore();
		// 装载附加的基本配置信息
		ConsoleUtils.outputLoadingInfo("Loading configure from ["
				+ configureLocation + "]...");
		if (StringUtils.isNotEmpty(configureLocation)) {
			DefaultResourceLoader resourceLoader =  new DefaultResourceLoader();
			Resource resource = resourceLoader.getResource(configureLocation);
			if (!resource.exists()) {
					logger.warn("Can not found resource [" + configureLocation
							+ "].");
					return;
			}
			InputStream in;
			Properties properties = new Properties();
			try {
				in = resource.getInputStream();
				try {
					properties.load(in);
				} finally {
					in.close();
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			ExpressionHandler expressionHandler = new DefaultExpressionHandler() {
				@Override
				public JexlContext getJexlContext() {
					JexlContext elContext = new MapContext();
					elContext.set("env", System.getenv());
					return elContext;
				}
			};

			for (Map.Entry<?, ?> entry : properties.entrySet()) {
				String text = (String) entry.getValue();
				Object value = text;
				if (StringUtils.isNotEmpty(text)) {
					Expression expression = expressionHandler.compile(text);
					if (expression != null) {
						value = expression.evaluate();
					}
				}
				configureStore.set((String) entry.getKey(), value);
			}
		}
	}
	
	protected void addExtensionContextConfigLocation(String location) {
		if (StringUtils.isNotEmpty(locations)) {
			locations += ';';
		}
		locations += location;
	}

	protected String getLocations() {
		return locations;
	}

	@Override
	protected void setUp() throws Exception {
		Configure.getStore().set("core.contextConfigLocation", getLocations());
		super.setUp();
		MockContext.init();

		EngineStartupListenerManager.notifyStartup();

	}

	@Override
	protected void tearDown() throws Exception {
		MockContext.dispose();
		super.tearDown();
	}
	

	@Test
	public void testAAA1(){
		System.out.print("");
	}

}