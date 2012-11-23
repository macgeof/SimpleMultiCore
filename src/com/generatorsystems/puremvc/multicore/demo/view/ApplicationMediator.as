package com.generatorsystems.puremvc.multicore.demo.view
{
	import avmplus.getQualifiedClassName;
	
	import com.gb.puremvc.GBCore;
	import com.gb.puremvc.GBPipeAwareCore;
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.gb.puremvc.view.GBFlashMediator;
	import com.generatorsystems.puremvc.multicore.cores.simpleCore.SimpleCore;
	import com.generatorsystems.puremvc.multicore.demo.Application;
	import com.generatorsystems.puremvc.multicore.demo.ApplicationFacade;
	import com.generatorsystems.puremvc.multicore.demo.model.enums.Cores;
	import com.generatorsystems.puremvc.multicore.demo.view.components.MessageTracer;
	import com.generatorsystems.puremvc.multicore.utils.PipeConstants;
	
	import flash.display.DisplayObject;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	public class ApplicationMediator extends GBFlashMediator implements IMediator
	{
		public static const NAME:String = "ApplicationMediator";
		
		protected var _messageTracer:MessageTracer;
		
		public function ApplicationMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
		
		override public function onRegister():void
		{
			super.onRegister();
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
					_createCores();
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
		
		protected function _initializeView():void
		{
			_createFeedbackView();
			
			var __y:Number = _messageTracer.y + _messageTracer.height + 30;
			_addCore(Cores.SIMPLE_CORE_1, {data:{x:50, y:__y}, otherData:{colour:0xFF0000}});
			_addCore(Cores.SIMPLE_CORE_2, {data:{x:150, y:__y}, otherData:{colour:0x00FF00}});
			_addCore(Cores.SIMPLE_CORE_3, {data:{x:250, y:__y}, otherData:{colour:0x0000FF}});
			_addCore(Cores.SIMPLE_CORE_4, {data:{x:350, y:__y}, otherData:{colour:0x00FFFF}});
				
			//example send message to only simpleCore1 cores via out pipe
			var __outConnectedMessage:Message = new Message(Cores.SIMPLE_CORE_1, {prop:"second value", otherProp:"second other value"}, this, Message.PRIORITY_MED);
			sendNotification(PipeConstants.SEND_MESSAGE_TO_CORE, __outConnectedMessage);
		}
		
		protected function _createFeedbackView():void
		{
			_messageTracer = new MessageTracer();
			_messageTracer.init();
			var __format:TextFormat = _messageTracer.messageText.textField.getTextFormat();
			__format.size = 6;
			_messageTracer.messageText.textField.defaultTextFormat = __format;
			application.addChild(_messageTracer);
		}
		
		protected function _updateMessageTracer(__message:String):void
		{
			if (_messageTracer) _messageTracer.messageText.text += "NEW MESSAGE RECEIVED\n" + __message +"\n\n";
		}
		
		protected function _addCore(__key:String, __data:Object):void
		{
			//let's create a simple core instance
			//set data on the core so it can be used/parsed during core startup
			var __core:SimpleCore = new SimpleCore(__key, __data);
			__core.startup();
			trace("here");
			sendNotification(PipeConstants.CONNECT_CORE_TO_SHELL, __core);
			sendNotification(PipeConstants.CONNECT_SHELL_TO_CORE, __core);
			sendNotification(ApplicationFacade.CORE_STARTED, __core);
			
			//send message all cores via out pipe
			var __outConnectedMessage:Message = new Message(PipeConstants.MESSAGE_TO_ALL_CORES, {}, this, Message.PRIORITY_MED);
			sendNotification(PipeConstants.SEND_MESSAGE_TO_CORE, __outConnectedMessage);
			
			//add the new core to the display list
			application.addChild(__core);
		}
		
		//plumbing already disconnected for the cores
		protected function _destroyCores(__cores:Array):void
		{
			var __child:SimpleCore;
			for each (var __coreName:String in __cores)
			{
				for (var i:int = 0; i < application.numChildren; i++)
				{
					__child = application.getChildAt(i) as SimpleCore;
					if (__child)
					{
						if (__child.key == __coreName)
						{
							application.removeChild(__child);
							
							__child.destroy();
							__child = null;
							
							break;
						}
					}
				}
			}
		}
		
		protected function _createCores():void
		{
			var __y:Number = _messageTracer.y + _messageTracer.height + 30;
			_addCore(Cores.SIMPLE_CORE_1, {data:{x:50, y:__y}, otherData:{colour:0xFF0000}});
			_addCore(Cores.SIMPLE_CORE_2, {data:{x:150, y:__y}, otherData:{colour:0x00FF00}});
		}
		
		protected function get application():Application
		{
			return viewComponent as Application;
		}
	}
}