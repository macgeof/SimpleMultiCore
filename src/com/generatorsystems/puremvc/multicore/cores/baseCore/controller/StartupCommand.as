package com.generatorsystems.puremvc.multicore.cores.baseCore.controller
{
	import com.gb.puremvc.controller.AbstractStartupCommand;
	import com.generatorsystems.puremvc.multicore.cores.baseCore.model.BaseCoreProxy;
	import com.generatorsystems.puremvc.multicore.cores.baseCore.view.BaseCoreJunctionMediator;
	import com.generatorsystems.puremvc.multicore.cores.baseCore.view.BaseCoreMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	
	public class StartupCommand extends AbstractStartupCommand
	{
		override public function execute(__notification:INotification):void
		{
			//register the core data proxy
			facade.registerProxy(new BaseCoreProxy(BaseCoreProxy.NAME));
			
			//register required mediators
			var __core:IPipeAware = __notification.getBody() as IPipeAware;
			facade.registerMediator(new BaseCoreMediator(BaseCoreMediator.NAME, __core));
			facade.registerMediator(new BaseCoreJunctionMediator(BaseCoreJunctionMediator.NAME, new Junction()));
		}
	}
}