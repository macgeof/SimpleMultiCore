package com.generatorsystems.puremvc.multicore.cores.simpleCore.controller
{
	import com.generatorsystems.puremvc.multicore.cores.simpleCore.view.SimpleCoreMediator;
	
	import flash.display.DisplayObjectContainer;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class DisableCoreCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var __mediator:SimpleCoreMediator = facade.retrieveMediator(SimpleCoreMediator.NAME) as SimpleCoreMediator;
			var __iDisplay:DisplayObjectContainer = __mediator.getViewComponent() as DisplayObjectContainer;
			__iDisplay.mouseChildren = false;
			__iDisplay.mouseEnabled = false;
		}
	}
}