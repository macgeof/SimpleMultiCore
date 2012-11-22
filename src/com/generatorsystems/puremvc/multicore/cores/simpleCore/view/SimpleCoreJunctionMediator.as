package com.generatorsystems.puremvc.multicore.cores.simpleCore.view
{
	import com.gb.puremvc.pipes.PipeAwareCoreConstants;
	import com.generatorsystems.puremvc.multicore.cores.baseCore.view.BaseCoreJunctionMediator;
	import com.generatorsystems.puremvc.multicore.cores.simpleCore.model.SimpleCoreProxy;
	import com.generatorsystems.puremvc.multicore.utils.PipeConstants;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	public class SimpleCoreJunctionMediator extends BaseCoreJunctionMediator
	{
		public static const NAME:String = "SimpleCoreJunctionMediator";
		
		public function SimpleCoreJunctionMediator(name:String, viewComponent:Junction)
		{
			super(name, viewComponent);
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			_coreData = facade.retrieveProxy(SimpleCoreProxy.NAME);
			
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			
			_coreData = null;
		}
		
		override public function listNotificationInterests():Array
		{
			var __interests:Array = super.listNotificationInterests();

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
					var inputPipeName:String = __note.getType();
					var inputPipe:IPipeFitting = __note.getBody() as IPipeFitting;
					if ( junction.registerPipe(inputPipeName, Junction.INPUT, inputPipe) ) 
					{
						SimpleCoreProxy(_coreData).shellInConnected = (junction.addPipeListener( inputPipeName, this, handlePipeMessage ));
					}
					
					//send message to shell via out pipe if it exists
					if (junction.hasOutputPipe(PipeAwareCoreConstants.CORE_TO_APP_PIPE))
					{
						
						var __inConnectedMessage:Message = new Message(PipeConstants.SEND_MESSAGE_TO_SHELL,this.multitonKey, this, Message.PRIORITY_MED);
						sendNotification(PipeConstants.SEND_MESSAGE_TO_SHELL, __inConnectedMessage);
					}
					break;
				
				// accept an output pipe
				case JunctionMediator.ACCEPT_OUTPUT_PIPE:
					var outputPipeName:String = __note.getType();
					var outputPipe:IPipeFitting = __note.getBody() as IPipeFitting;
					SimpleCoreProxy(_coreData).shellOutConnect = junction.registerPipe( outputPipeName, Junction.OUTPUT, outputPipe );
					
					//send message to shell via new out pipe
					var __outConnectedMessage:Message = new Message(PipeConstants.SEND_MESSAGE_TO_SHELL,this.multitonKey, this, Message.PRIORITY_MED);
					sendNotification(PipeConstants.SEND_MESSAGE_TO_SHELL, __outConnectedMessage);
					break;
				
				default :
					super.handleNotification(__note);
					break;
			}

		}
		
		override public function handlePipeMessage(__message:IPipeMessage):void
		{
			//this check will allow response to messages specifically for this core
			var __targetCore:String = __message.getType().toString();
			
			if (__targetCore == this.multitonKey || __targetCore == PipeConstants.MESSAGE_TO_ALL_CORES)
			{
				trace(this, "handlePipeMessage", this.multitonKey, "MESSAGE DETAILS : getType() = ",__message.getType()," : getHeader() = ", __message.getHeader(), " : getBody = ", __message.getBody(), " : getPriority = ",__message.getPriority());
			}
		}
	}
}