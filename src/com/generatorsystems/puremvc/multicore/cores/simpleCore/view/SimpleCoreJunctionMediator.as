package com.generatorsystems.puremvc.multicore.cores.simpleCore.view
{
	import com.gb.puremvc.pipes.PipeAwareCoreConstants;
	import com.generatorsystems.puremvc.multicore.cores.baseCore.view.BaseCoreJunctionMediator;
	import com.generatorsystems.puremvc.multicore.cores.model.vo.DisconnectPipeFittingsVO;
	import com.generatorsystems.puremvc.multicore.cores.simpleCore.model.SimpleCoreProxy;
	import com.generatorsystems.puremvc.multicore.utils.PipeConstants;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Pipe;
	
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
//				trace(this, "handlePipeMessage", this.multitonKey, "MESSAGE DETAILS : getType() = ",__message.getType()," : getHeader() = ", __message.getHeader(), " : getBody = ", __message.getBody(), " : getPriority = ",__message.getPriority());
				if (__message.getHeader().toString() == PipeConstants.UNPLUMB_CORE_FROM_SHELL)
				{
					var __success:Boolean =_disconnectCoreFromShell(__message.getBody() as DisconnectPipeFittingsVO);
				}
			}
		}
		
		//this is final - once disconnected this core is only accessible via methods exposed on the core class itself
		protected function _disconnectCoreFromShell(__fittingsVO:DisconnectPipeFittingsVO):Boolean
		{
			var __inPipe:IPipeFitting = junction.retrievePipe(_shellToCorePipeName);
			__inPipe = __fittingsVO.appOutFitting.disconnectFitting(__inPipe);
			
			var __outPipe:IPipeFitting = junction.retrievePipe(_coreToShellPipeName);
			var __disconnectedFitting:IPipeFitting = __outPipe.disconnect();
			
			var __return:Boolean = (__inPipe && __disconnectedFitting);
			__inPipe = null;
			__outPipe = null;
			
			return __return;
		}
	}
}