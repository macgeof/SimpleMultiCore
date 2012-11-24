package com.generatorsystems.puremvc.multicore.demo.view
{
	import com.gb.model.Settings;
	import com.gb.puremvc.interfaces.ICore;
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.gb.puremvc.view.GBFlashMediator;
	import com.generatorsystems.puremvc.multicore.cores.simpleCore.SimpleCore;
	import com.generatorsystems.puremvc.multicore.demo.Application;
	import com.generatorsystems.puremvc.multicore.demo.ApplicationFacade;
	import com.generatorsystems.puremvc.multicore.demo.model.ApplicationDataProxy;
	import com.generatorsystems.puremvc.multicore.demo.model.ApplicationStateProxy;
	import com.generatorsystems.puremvc.multicore.demo.model.DemoFontProxy;
	import com.generatorsystems.puremvc.multicore.demo.model.enums.Cores;
	import com.generatorsystems.puremvc.multicore.demo.model.enums.SettingsIDs;
	import com.generatorsystems.puremvc.multicore.demo.model.enums.Styles;
	import com.generatorsystems.puremvc.multicore.demo.model.vo.CoreVO;
	import com.generatorsystems.puremvc.multicore.demo.view.components.MessageTracer;
	import com.generatorsystems.puremvc.multicore.utils.PipeConstants;
	
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;
	
	import org.as3commons.logging.LoggerFactory;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	public class ApplicationMediator extends GBFlashMediator implements IMediator
	{
		public static const NAME:String = "ApplicationMediator";
		
		protected var _messageTracer:MessageTracer;
		
		protected var _dataProxy:ApplicationDataProxy;
		protected var _stateProxy:ApplicationStateProxy;
		protected var _fontProxy:DemoFontProxy;
		
		public function ApplicationMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			logger = LoggerFactory.getClassLogger(ApplicationMediator);
		}
		
		override public function onRemove():void
		{
			super.onRemove();
		}
		
		override public function listNotificationInterests():Array
		{
			var __interests:Array = super.listNotificationInterests();
			__interests.push(
					GBNotifications.STARTUP_COMPLETE,
					ApplicationFacade.SHOW_SHELL_MESSAGE,
					PipeConstants.CREATE_CORE,
					PipeConstants.DESTROY_CORE
				);
			
			return __interests;
		}
		
		override public function handleNotification(__note:INotification):void
		{
			switch(__note.getName())
			{
				case GBNotifications.STARTUP_COMPLETE:
				{
					_initializeResources();
					_initializeView();
					break;
				}
					
				case ApplicationFacade.SHOW_SHELL_MESSAGE:
				{
					_updateMessageTracer(__note.getBody().toString());
					break;
				}
					
				case PipeConstants.CREATE_CORE :
				{
					_recreateCores();
					break;
				}
					
				case PipeConstants.DESTROY_CORE :
				{
					_destroyCores(__note.getBody() as Array);
					break;
				}
						
				default:
				{
					super.handleNotification(__note);
					break;
				}
			}
		}
		
		protected function _initializeResources():void
		{
			_dataProxy = facade.retrieveProxy(ApplicationDataProxy.NAME) as ApplicationDataProxy;
			_stateProxy = facade.retrieveProxy(ApplicationStateProxy.NAME) as ApplicationStateProxy;
			styleSheet = serviceLocator.getStyleSheet(Cores.SHELL);
			settings = serviceLocator.getSettings(Cores.SHELL);
			dictionary = serviceLocator.getDictionary(Cores.SHELL);
			
		}
		
		protected function _initializeView():void
		{
			_createFeedbackView();
			
			//create the first 2 cores here - they are separated out as we can later recreate them
			var __coreData:Vector.<CoreVO> = _dataProxy.coresData;
			for each (var __coreVO:CoreVO in __coreData)
			{
				_addCore(__coreVO);
			}
				
			//example send message to only simpleCore1 cores via out pipe
			var __outConnectedMessage:Message = new Message(__coreData[1].coreKey, __coreData[1], this, Message.PRIORITY_MED);
			sendNotification(PipeConstants.SEND_MESSAGE_TO_CORE, __outConnectedMessage);
		}
		
		protected function _createFeedbackView():void
		{
			_messageTracer = new MessageTracer(settings.getSetting(SettingsIDs.PANEL_WIDTH), settings.getSetting(SettingsIDs.PANEL_HEIGHT), uint(settings.getSetting(SettingsIDs.PANEL_BACKGROUND_COLOUR)), Styles.PANEL_STYLE, styleSheet);
			_messageTracer.init();
			application.addChild(_messageTracer);
		}
		
		protected function _updateMessageTracer(__message:String):void
		{
			if (_messageTracer)
			{
				_messageTracer.addTextToTop("<span style='" + Styles.PANEL_STYLE + "'>NEW MESSAGE RECEIVED\n" + __message +"\n\n</span>");
			}
		}
		
		protected function _addCore(__vo:CoreVO):void
		{
			//let's create a simple core instance
			//set data on the core so it can be used/parsed during core startup
			var __coreClass:Class = getDefinitionByName(__vo.classPath) as Class;
			var __core:Object = new __coreClass();
			var __iDisplay:DisplayObject = __core as DisplayObject;
			var __iCore:ICore = __core as ICore;
			var __iPipeAware:IPipeAware = __core as IPipeAware;
			__iDisplay.name = __vo.coreKey;
			__iCore.key = __vo.coreKey;
			__iCore.data = __vo;
			__iCore.startup();

			sendNotification(PipeConstants.CONNECT_CORE_TO_SHELL, __iPipeAware);
			sendNotification(PipeConstants.CONNECT_SHELL_TO_CORE, __iPipeAware);
			sendNotification(ApplicationFacade.CORE_STARTED, __iPipeAware);
			
			//send message all cores via out pipe
			var __outConnectedMessage:Message = new Message(PipeConstants.MESSAGE_TO_ALL_CORES, {}, this, Message.PRIORITY_MED);
			sendNotification(PipeConstants.SEND_MESSAGE_TO_CORE, __outConnectedMessage);
			
			//add the new core to the display list
			application.addChild(__iDisplay);
		}
		
		//plumbing already disconnected for the cores
		protected function _destroyCores(__cores:Array):void
		{
			var __child:ICore;
			var __display:DisplayObject = __child as DisplayObject;
			var __coreData:Vector.<CoreVO> = _dataProxy.coresData;
			for each (var __coreVO:CoreVO in __coreData)
			{
				if (__coreVO.destroyable)
				{
					__display = application.getChildByName(__coreVO.coreKey);
					if (__display)
					{
						__child = __display as ICore;
						if (application.contains(__display)) application.removeChild(__display);
						__child.destroy();
						__child = null;
					}
				}
			}
		}
		
		protected function _recreateCores():void
		{
			var __coreData:Vector.<CoreVO> = _dataProxy.coresData;
			for each (var __coreVO:CoreVO in __coreData)
			{
				if (__coreVO.destroyable) _addCore(__coreVO);
			}
		}
		
		protected function get application():Application
		{
			return viewComponent as Application;
		}
	}
}