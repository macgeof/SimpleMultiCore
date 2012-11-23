package com.generatorsystems.puremvc.multicore.cores.simpleCore
{
	import com.gb.puremvc.controller.ApplicationStartupCommand;
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.generatorsystems.puremvc.multicore.cores.baseCore.BaseCoreFacade;
	import com.generatorsystems.puremvc.multicore.cores.simpleCore.model.SimpleCoreProxy;
	import com.generatorsystems.puremvc.multicore.cores.simpleCore.view.SimpleCoreJunctionMediator;
	import com.generatorsystems.puremvc.multicore.cores.simpleCore.view.SimpleCoreMediator;
	
	public class SimpleCoreFacade extends BaseCoreFacade
	{
		public static const NAME:String = "SimpleCoreFacade";
		
		public function SimpleCoreFacade(key:String)
		{
			super(key);
		}
		
		/**
		 * ApplicationFacade Factory Method
		 */
		public static function getInstance( __key:String ) : SimpleCoreFacade 
		{
			if ( instanceMap[ __key ] == null ) instanceMap[ __key ]  = new SimpleCoreFacade( __key );
			return instanceMap[ __key ] as SimpleCoreFacade;
		}
		
		/**
		 * Register Commands with the Controller 
		 */
		override protected function initializeController( ) : void 
		{
			super.initializeController();
		}
		
		/**
		 * Starts up application.
		 * 
		 * @param	Object		reference to document class
		 * @param 	Class		custom startup command. Optional, defaults to core framework command
		 */
		override public function startup(__application:Object, __startupCommand:Class = null):void
		{
			// Default to standard GBPureMVC startup command if a custom command isn't specified.
			if (!__startupCommand)
				__startupCommand = ApplicationStartupCommand;
			
			registerCommand(GBNotifications.STARTUP, __startupCommand);
			sendNotification(GBNotifications.STARTUP, __application);
		}
		
		override public function destroy():void
		{
			removeMediator(SimpleCoreJunctionMediator.NAME);
			removeMediator(SimpleCoreMediator.NAME);
			
			removeProxy(SimpleCoreProxy.NAME);
			
			super.destroy();
		}
	}
}