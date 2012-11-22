package com.generatorsystems.puremvc.multicore.cores.simpleCore.controller
{
	import com.gb.puremvc.GBCore;
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.generatorsystems.puremvc.multicore.cores.baseCore.controller.StartupCommand;
	import com.generatorsystems.puremvc.multicore.cores.simpleCore.model.SimpleCoreProxy;
	import com.generatorsystems.puremvc.multicore.cores.simpleCore.view.SimpleCoreJunctionMediator;
	import com.generatorsystems.puremvc.multicore.cores.simpleCore.view.SimpleCoreMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	
	public class StartupCommand extends com.generatorsystems.puremvc.multicore.cores.baseCore.controller.StartupCommand
	{
		override public function execute(__notification:INotification):void
		{
			var __core:IPipeAware = __notification.getBody() as IPipeAware;
			
			//register the core data proxy
			facade.registerProxy(new SimpleCoreProxy(SimpleCoreProxy.NAME, (__core as GBCore).data));
			
			//register required mediators
			facade.registerMediator(new SimpleCoreMediator(SimpleCoreMediator.NAME, __core));
			facade.registerMediator(new SimpleCoreJunctionMediator(SimpleCoreJunctionMediator.NAME, new Junction()));
			
			//this will allow mediators to respond and start doing what they need to do
			//this notification can obviously be delayed until required resources are loaded/ready and sent from any framework class
			sendNotification(GBNotifications.STARTUP_COMPLETE);
		}
	}
}