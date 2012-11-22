package com.generatorsystems.puremvc.multicore.cores.simpleCore
{
	import com.generatorsystems.puremvc.multicore.cores.baseCore.BaseCore;
	import com.generatorsystems.puremvc.multicore.cores.simpleCore.controller.StartupCommand;
	import com.generatorsystems.puremvc.multicore.cores.simpleCore.model.SimpleCoreProxy;
	import com.generatorsystems.puremvc.multicore.cores.simpleCore.view.SimpleCoreMediator;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	
	public class SimpleCore extends BaseCore implements IPipeAware
	{
		public function SimpleCore(key:String=null, data:*=null)
		{
			super(key, data);
		}
		
		/**
		 * @inheritDoc
		 */		
		override public function startup():void
		{
			facade = SimpleCoreFacade.getInstance(_key);
			facade.startup(this, StartupCommand);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function destroy():void
		{
			facade.destroy();
			Facade.removeCore(key);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get coreMediator():Class
		{
			return SimpleCoreMediator;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get coreProxy():Class
		{
			return SimpleCoreProxy;
		}
	}
}