package com.generatorsystems.puremvc.multicore.demo.controller
{
	import com.gb.puremvc.controller.ApplicationStartupCommand;
	import com.generatorsystems.puremvc.multicore.demo.model.ApplicationStateProxy;
	import com.generatorsystems.puremvc.multicore.demo.model.DemoFontProxy;
	import com.generatorsystems.puremvc.multicore.demo.view.ApplicationJunctionMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	
	public class StartupCommand extends ApplicationStartupCommand
	{
		override public function execute(__notification:INotification):void
		{
			super.execute(__notification);
			
			//register framework classes which have no external resources to load
			facade.registerMediator(new ApplicationJunctionMediator(ApplicationJunctionMediator.NAME, new Junction()));
			facade.registerProxy(new ApplicationStateProxy(ApplicationStateProxy.NAME));
			facade.registerProxy(new DemoFontProxy(DemoFontProxy.NAME));
		}
	}
}