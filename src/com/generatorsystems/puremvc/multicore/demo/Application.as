package com.generatorsystems.puremvc.multicore.demo
{
	import com.gb.puremvc.GBApplication;
	import com.gb.puremvc.interfaces.IShell;
	import com.generatorsystems.puremvc.multicore.demo.controller.StartupCommand;
	import com.generatorsystems.puremvc.multicore.demo.model.enums.Cores;
	import com.generatorsystems.puremvc.multicore.demo.view.ApplicationMediator;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(width="350", height="250", frameRate="30", backgroundColor="#FFFFFF")]
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
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			startup();
		}
		
		override protected function startup():void
		{
			facade = ApplicationFacade.getInstance(Cores.SHELL);
			facade.startup(this, StartupCommand);
		}
		
		
	}
}