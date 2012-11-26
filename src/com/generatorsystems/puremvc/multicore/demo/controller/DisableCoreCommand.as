package com.generatorsystems.puremvc.multicore.demo.controller
{
	import com.gb.puremvc.interfaces.ICore;
	import com.generatorsystems.puremvc.multicore.demo.view.ApplicationMediator;
	
	import flash.display.DisplayObjectContainer;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class DisableCoreCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var __logger:ILogger = LoggerFactory.getClassLogger(DisableCoreCommand);
			var __mediator:ApplicationMediator = facade.retrieveMediator(ApplicationMediator.NAME) as ApplicationMediator;
			var __iDisplay:DisplayObjectContainer = __mediator.getViewComponent() as DisplayObjectContainer;
			var __iCore:ICore;
			for (var i:int = 0; i < __iDisplay.numChildren; i++)
			{
				__iCore = __iDisplay.getChildAt(i) as ICore;
				if (__iCore)
				{
					__logger.info(" : executing disable() on " + __iCore.key);
					__iCore.disable();
				}
			}
		}
	}
}