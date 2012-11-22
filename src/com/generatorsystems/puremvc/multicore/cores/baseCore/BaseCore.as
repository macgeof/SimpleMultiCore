package com.generatorsystems.puremvc.multicore.cores.baseCore
{
	import com.gb.puremvc.GBPipeAwareCore;
	import com.generatorsystems.puremvc.multicore.cores.baseCore.controller.StartupCommand;
	import com.generatorsystems.puremvc.multicore.cores.baseCore.model.BaseCoreProxy;
	import com.generatorsystems.puremvc.multicore.cores.baseCore.view.BaseCoreMediator;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	
	public class BaseCore extends GBPipeAwareCore implements IPipeAware
	{
		public function BaseCore(key:String=null, data:*=null)
		{
			super(key, data);
		}
		
		/**
		 * @inheritDoc
		 */		
		override public function startup():void
		{
			facade = BaseCoreFacade.getInstance(_key);
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
			return BaseCoreMediator;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get coreProxy():Class
		{
			return BaseCoreProxy;
		}
	}
}