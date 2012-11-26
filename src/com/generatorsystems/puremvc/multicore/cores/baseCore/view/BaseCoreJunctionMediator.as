package com.generatorsystems.puremvc.multicore.cores.baseCore.view
{
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.gb.puremvc.pipes.PipeAwareCoreConstants;
	import com.generatorsystems.puremvc.multicore.cores.baseCore.model.BaseCoreProxy;
	import com.generatorsystems.puremvc.multicore.utils.PipeConstants;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	public class BaseCoreJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = "SimpleCoreJunctionMediator";
		
		protected var _coreData:IProxy;
		protected var _coreToShellPipeName:String;
		protected var _shellToCorePipeName:String;
		
		public function BaseCoreJunctionMediator(name:String, viewComponent:Junction)
		{
			super(name, viewComponent);
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			_coreData = facade.retrieveProxy(BaseCoreProxy.NAME);
		}
		
		override public function onRemove():void
		{			
			//go through the pipes
			var __pipe:IPipeFitting = junction.retrievePipe(_coreToShellPipeName);
			_removePipe(__pipe, _coreToShellPipeName);
			__pipe = junction.retrievePipe(_shellToCorePipeName);
			_removePipe(__pipe, _shellToCorePipeName);
			
			_coreData = null;
			
			super.onRemove();
		}
		
		override public function listNotificationInterests():Array
		{
			var __interests:Array = super.listNotificationInterests();
			__interests.push(
				PipeConstants.SEND_MESSAGE_TO_SHELL,
				PipeAwareCoreConstants.CORE_TO_SHELL_MESSAGE
			);
			return __interests;
		}
		
		override public function handleNotification(__note:INotification):void
		{
			switch (__note.getName())
			{
				
				//override superclass handling of pipe connections
				//required so we can inform proxy as required
				
				// accept an input pipe
				// register the pipe and if successful 
				// set this mediator as its listener
				case JunctionMediator.ACCEPT_INPUT_PIPE:
					_shellToCorePipeName = __note.getType();
					var inputPipe:IPipeFitting = __note.getBody() as IPipeFitting;
					if ( junction.registerPipe(_shellToCorePipeName, Junction.INPUT, inputPipe) ) 
					{
						BaseCoreProxy(_coreData).shellInConnected = (junction.addPipeListener( _shellToCorePipeName, this, handlePipeMessage ));
					} 
					
					//send message to shell via out pipe if it exists
					if (junction.hasOutputPipe(_coreToShellPipeName))
					{
						
						var __inConnectedMessage:Message = new Message(PipeConstants.SEND_MESSAGE_TO_SHELL,this.multitonKey, this, Message.PRIORITY_MED);
						sendNotification(PipeConstants.SEND_MESSAGE_TO_SHELL, __inConnectedMessage);
					}
					break;
				
				// accept an output pipe
				case JunctionMediator.ACCEPT_OUTPUT_PIPE:
					_coreToShellPipeName = __note.getType();
					var outputPipe:IPipeFitting = __note.getBody() as IPipeFitting;
					BaseCoreProxy(_coreData).shellOutConnect = junction.registerPipe( _coreToShellPipeName, Junction.OUTPUT, outputPipe );
					
					//send message to shell via new out pipe
					var __outConnectedMessage:Message = new Message(PipeConstants.SEND_MESSAGE_TO_SHELL,this.multitonKey, this, Message.PRIORITY_MED);
					sendNotification(PipeConstants.SEND_MESSAGE_TO_SHELL, __outConnectedMessage);
					break;
				
				//cover both cases in case of mistakes!
				case PipeAwareCoreConstants.CORE_TO_SHELL_MESSAGE :
				case PipeConstants.SEND_MESSAGE_TO_SHELL :
					var __messageToSend:IPipeMessage = __note.getBody() as IPipeMessage;
					_sendMessage(__messageToSend);
					break;
				
				default :
					super.handleNotification(__note);
					break;
			}
		}
		
		protected function _sendMessage(__message:IPipeMessage):void
		{
			if (junction.hasOutputPipe(_coreToShellPipeName))
			{
				junction.sendMessage(_coreToShellPipeName, __message);
			}
		}
		
		override public function handlePipeMessage(__message:IPipeMessage):void
		{
//			trace(this, "handlePipeMessage", this.multitonKey, "MESSAGE DETAILS : getType() = ",__message.getType()," : getHeader() = ", __message.getHeader(), " : getBody = ", __message.getBody(), " : getPriority = ",__message.getPriority());
		}
		
		private function _removePipe(__pipe:IPipeFitting, __name:String):void
		{
			if (__pipe)
			{
				__pipe.disconnect();
				junction.removePipe(__name);
				__pipe = null;
			}
		}
	}
}