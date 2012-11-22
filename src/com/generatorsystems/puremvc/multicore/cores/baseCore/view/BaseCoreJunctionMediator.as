package com.generatorsystems.puremvc.multicore.cores.baseCore.view
{
	import com.gb.puremvc.pipes.PipeAwareCoreConstants;
	import com.generatorsystems.puremvc.multicore.cores.baseCore.model.BaseCoreProxy;
	import com.generatorsystems.puremvc.multicore.utils.PipeConstants;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	public class BaseCoreJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = "SimpleCoreJunctionMediator";
		
		protected var _coreData:IProxy;
		
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
			super.onRemove();
			
			_coreData = null;
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
					var inputPipeName:String = __note.getType();
					var inputPipe:IPipeFitting = __note.getBody() as IPipeFitting;
					if ( junction.registerPipe(inputPipeName, Junction.INPUT, inputPipe) ) 
					{
						BaseCoreProxy(_coreData).shellInConnected = (junction.addPipeListener( inputPipeName, this, handlePipeMessage ));
					} 
					break;
				
				// accept an output pipe
				case JunctionMediator.ACCEPT_OUTPUT_PIPE:
					var outputPipeName:String = __note.getType();
					var outputPipe:IPipeFitting = __note.getBody() as IPipeFitting;
					BaseCoreProxy(_coreData).shellOutConnect = junction.registerPipe( outputPipeName, Junction.OUTPUT, outputPipe );
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
			if (junction.hasOutputPipe(PipeAwareCoreConstants.CORE_TO_APP_PIPE)) junction.sendMessage(PipeAwareCoreConstants.CORE_TO_APP_PIPE,__message);
		}
		
		override public function handlePipeMessage(__message:IPipeMessage):void
		{
			trace(this, "handlePipeMessage", this.multitonKey, "MESSAGE DETAILS : getType() = ",__message.getType()," : getHeader() = ", __message.getHeader(), " : getBody = ", __message.getBody(), " : getPriority = ",__message.getPriority());
		}
	}
}