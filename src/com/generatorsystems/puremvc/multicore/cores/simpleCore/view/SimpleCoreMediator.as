package com.generatorsystems.puremvc.multicore.cores.simpleCore.view
{
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.gb.puremvc.pipes.PipeAwareCoreConstants;
	import com.generatorsystems.components.TextButton;
	import com.generatorsystems.puremvc.multicore.cores.baseCore.view.BaseCoreMediator;
	import com.generatorsystems.puremvc.multicore.cores.simpleCore.SimpleCore;
	import com.generatorsystems.puremvc.multicore.cores.simpleCore.model.SimpleCoreProxy;
	import com.generatorsystems.puremvc.multicore.demo.model.enums.Cores;
	import com.generatorsystems.puremvc.multicore.utils.PipeConstants;
	
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	public class SimpleCoreMediator extends BaseCoreMediator implements IMediator
	{
		public static const NAME:String = "SimpleCoreMediator";
		
		public function SimpleCoreMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			_coreData = facade.retrieveProxy(SimpleCoreProxy.NAME);
			library = (_coreData as SimpleCoreProxy).library
			styleSheet = serviceLocator.getStyleSheet(Cores.SHELL);
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			
			_coreData = null;
			viewComponent = null;
		}
		
		override public function listNotificationInterests():Array
		{
			var __interests:Array = super.listNotificationInterests();
			__interests.push(
					GBNotifications.STARTUP_COMPLETE,
					PipeConstants.DESTROY_CORE
				);
			return __interests;
		}
		
		override public function handleNotification(__note:INotification):void
		{
			switch (__note.getName())
			{
				case GBNotifications.STARTUP_COMPLETE :
					_initializeView();
					break;
				
				case PipeConstants.DESTROY_CORE :
					(core as SimpleCore).destroy();
					break;
				
				default :
					super.handleNotification(__note);
					break;
			}
		}
		
		protected function _initializeView():void
		{
			//going to do some dummy drawing to show how we handle stuff
			var __point:Point = coreData.corePoint;
			var __core:Sprite = core as Sprite;
			__core.x = __point.x;
			__core.y = __point.y;
			
/*			var __sprite:Sprite = new Sprite();
			__core.addChild(__sprite);
			var __graphics:Graphics = __sprite.graphics;
			__graphics.beginFill(coreData.coreColour, 1);
			__graphics.lineStyle(1, 0x000000, 1);
			__graphics.drawCircle(25, 25, 25);
			__graphics.endFill();
			__sprite.addEventListener(MouseEvent.CLICK, _clickhandler);*/
			
			var __class:Class = library.getAssetClass("CentreSkin");
			var __button:TextButton = new TextButton();
			__core.addChild(__button);
			__button.skin = new __class() as MovieClip;
			__button.styleSheet = styleSheet;
			__button.label = this.multitonKey;
			__button.upStyle = "buttonUp";
			__button.overStyle = "buttonOver";
			__button.downStyle = "buttonOut";
			__button.init();
			__button.draw();
			__button.addEventListener(MouseEvent.MOUSE_UP, _clickhandler);
		}
		
		protected function _clickhandler(__event:MouseEvent):void
		{
			var __message:Message = new Message(MouseEvent.CLICK, this, this.multitonKey, Message.PRIORITY_HIGH);
			sendNotification(PipeConstants.SEND_MESSAGE_TO_SHELL, __message);
		}
		
		override public function get iPipeAwareCore():IPipeAware
		{
			return viewComponent as IPipeAware;
		}
		
		override protected function get core():IPipeAware
		{
			return viewComponent as SimpleCore;
		}
		
		protected function get coreData():SimpleCoreProxy
		{
			return _coreData as SimpleCoreProxy;
		}
	}
}