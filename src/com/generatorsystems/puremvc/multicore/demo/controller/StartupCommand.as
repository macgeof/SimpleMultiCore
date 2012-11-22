package com.generatorsystems.puremvc.multicore.demo.controller
{
	import com.gb.puremvc.controller.AbstractStartupCommand;
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.generatorsystems.puremvc.multicore.demo.model.ApplicationProxy;
	import com.generatorsystems.puremvc.multicore.demo.view.ApplicationJunctionMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	
	public class StartupCommand extends AbstractStartupCommand
	{
		override public function execute(__notification:INotification):void
		{
			super.execute(__notification);
			
			facade.registerProxy(new ApplicationProxy(ApplicationProxy.NAME));
			facade.registerMediator(new ApplicationJunctionMediator(ApplicationJunctionMediator.NAME, new Junction()));
			
			sendNotification(GBNotifications.STARTUP_COMPLETE);
		}
	}
}