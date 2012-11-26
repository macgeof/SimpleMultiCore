package com.generatorsystems.puremvc.multicore.demo
{
	import com.gb.puremvc.controller.ApplicationStartupCommand;
	import com.gb.puremvc.interfaces.IShellFacade;
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.gb.puremvc.patterns.GBFacade;
	import com.generatorsystems.puremvc.multicore.demo.model.enums.References;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	
	References;
	
	public class ApplicationFacade extends GBFacade implements IShellFacade
	{
		public static const NAME:String = "ApplicationFacade";
		
		public static const CORE_STARTED:String = "coreStarted";
		public static const SHOW_SHELL_MESSAGE:String = "showShellmessage";
		
		public function ApplicationFacade(__key:String)
		{
			super(__key);
		}
		
		/**
		 * ApplicationFacade Factory Method
		 */
		public static function getInstance( __key:String ) : ApplicationFacade 
		{
			if ( instanceMap[ __key ] == null ) instanceMap[ __key ]  = new ApplicationFacade( __key );
			return instanceMap[ __key ] as ApplicationFacade;
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