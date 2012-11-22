package com.generatorsystems.puremvc.multicore.cores.baseCore
{
	import com.gb.puremvc.controller.ApplicationStartupCommand;
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.gb.puremvc.patterns.GBCoreFacade;
	
	public class BaseCoreFacade extends GBCoreFacade
	{
		public static const NAME:String = "SimpleCoreFacade";
		
		public function BaseCoreFacade(key:String)
		{
			super(key);
		}
		
		/**
		 * ApplicationFacade Factory Method
		 */
		public static function getInstance( __key:String ) : BaseCoreFacade 
		{
			if ( instanceMap[ __key ] == null ) instanceMap[ __key ]  = new BaseCoreFacade( __key );
			return instanceMap[ __key ] as BaseCoreFacade;
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
	}
}