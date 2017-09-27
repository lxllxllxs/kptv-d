package com.xly.ess.test;

import com.bstek.dorado.core.CommonContext;
import com.bstek.dorado.core.Context;
import com.bstek.dorado.core.EngineStartupListenerManager;
 
public class MockContext extends CommonContext {
    public static Context init() throws Exception {
        MockContext context = new MockContext();
        attachToThreadLocal(context);
 
        // Initialize Spring ApplicationContext
        context.initApplicationContext();
 
        EngineStartupListenerManager.notifyStartup();
        return context;
    }
 
}