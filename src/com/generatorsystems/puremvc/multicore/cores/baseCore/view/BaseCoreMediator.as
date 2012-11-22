package com.generatorsystems.puremvc.multicore.cores.baseCore.view
{
	import com.gb.puremvc.view.AbstractMediator;
	import com.generatorsystems.puremvc.multicore.cores.baseCore.BaseCore;
	import com.generatorsystems.puremvc.multicore.cores.baseCore.model.BaseCoreProxy;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	
	public class BaseCoreMediator extends AbstractMediator implements IMediator
	{
		public static const NAME:String = "SimpleCoreMediator";
		
		protected var _coreData:IProxy;
		
		public function BaseCoreMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			_coreData = facade.retrieveProxy(BaseCoreProxy.NAME);
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			
			_coreData = null;
		}
		
		override public function listNotificationInterests():Array
		{
			var __interests:Array = super.listNotificationInterests();
			return __interests;
		}
		
		override public function handleNotification(__note:INotification):void
		{
			switch (__note.getName())
			{
				default :
					super.handleNotification(__note);
					break;
			}
		}
		
		public function get iPipeAwareCore():IPipeAware
		{
			return viewComponent as IPipeAware;
		}
		
		protected function get core():IPipeAware
		{
			return viewComponent as BaseCore;
		}
	}
}