package com.generatorsystems.puremvc.multicore.demo
{
	import com.gb.puremvc.GBApplication;
	import com.gb.puremvc.interfaces.ICore;
	import com.gb.puremvc.interfaces.IShell;
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.generatorsystems.puremvc.multicore.demo.controller.StartupCommand;
	import com.generatorsystems.puremvc.multicore.demo.model.enums.Cores;
	import com.generatorsystems.puremvc.multicore.demo.view.ApplicationMediator;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(width="600", height="500", frameRate="30", backgroundColor="#FFFFFF")]
	public class Application extends GBApplication implements IShell
	{
		public function Application()
		{
			super();
		}
		
		override public function get applicationMediator():Class
		{
			return ApplicationMediator;
		}
		
		override protected function init(event:Event=null):void
		{
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP_LEFT;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			startup();
		}
		
		override protected function startup():void
		{
			facade = ApplicationFacade.getInstance(Cores.SHELL);
			facade.startup(this, StartupCommand);
		}
		
		override public function coreTransitionedOut(__core:ICore):void
		{
			var __display:DisplayObject = __core as DisplayObject;
			__display = this.getChildByName(__core.key);
			if (__display)
			{
				if (this.contains(__display)) this.removeChild(__display);
				__core.destroy();
				__core = null;
			}
			facade.sendNotification(GBNotifications.ENABLE);
		}
		
		
	}
}