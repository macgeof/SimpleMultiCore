package com.generatorsystems.puremvc.multicore.demo.view
{
	import com.gb.puremvc.GBPipeAwareCore;
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.gb.puremvc.pipes.PipeAwareCoreConstants;
	import com.generatorsystems.puremvc.multicore.cores.model.vo.DisconnectPipeFittingsVO;
	import com.generatorsystems.puremvc.multicore.demo.ApplicationFacade;
	import com.generatorsystems.puremvc.multicore.demo.model.ApplicationDataProxy;
	import com.generatorsystems.puremvc.multicore.demo.model.enums.Cores;
	import com.generatorsystems.puremvc.multicore.demo.model.vo.CoreVO;
	import com.generatorsystems.puremvc.multicore.utils.PipeConstants;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Pipe;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeMerge;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeSplit;
	
	public class ApplicationJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = "ApplicationJunctionMediator";
		
		public function ApplicationJunctionMediator(name:String, viewComponent:Junction)
		{
			super(name, viewComponent);
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// The output pipe from the shell to all modules 
			junction.registerPipe( PipeAwareCoreConstants.APP_TO_CORE_PIPE,  Junction.OUTPUT, new TeeSplit() );
			
			// The input pipe to the shell from all modules 
			junction.registerPipe( PipeAwareCoreConstants.CORE_TO_APP_PIPE,  Junction.INPUT, new TeeMerge() );
			junction.addPipeListener( PipeAwareCoreConstants.CORE_TO_APP_PIPE, this, handlePipeMessage );
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
					PipeConstants.CONNECT_CORE_TO_SHELL,
					PipeConstants.CONNECT_SHELL_TO_CORE,
					PipeConstants.SEND_MESSAGE_TO_CORE
				);
			return __interests;
		}
		
		override public function handleNotification(__note:INotification):void
		{
			var __core:IPipeAware;
			switch(__note.getName())
			{
				case GBNotifications.STARTUP_COMPLETE:
				{
					break;
				}
					
				case PipeConstants.CONNECT_SHELL_TO_CORE:
				{
					__core = __note.getBody() as IPipeAware;
					_connectShellToCore(__core);
					break;
				}
					
				case PipeConstants.CONNECT_CORE_TO_SHELL:
				{
					__core = __note.getBody() as IPipeAware;
					_connectCoreToShell(__core);
					break;
				}
					
				case PipeConstants.SEND_MESSAGE_TO_CORE :
				{
					var __message:IPipeMessage = __note.getBody() as IPipeMessage;
					_sendMessageToCore(__message);
					break;
				}
						
				default:
				{
					super.handleNotification(__note);
					break;
				}
			}
		}
		
		protected function _connectCoreToShell(__core:IPipeAware):void
		{
			var __coreKey:String = (__core as GBPipeAwareCore).key;
			var __pipeName:String = PipeAwareCoreConstants.CORE_TO_APP_PIPE + __coreKey;
			var __coreToShell:Pipe = new Pipe();
			var __shellIn:TeeMerge = junction.retrievePipe(PipeAwareCoreConstants.CORE_TO_APP_PIPE) as TeeMerge;
			var __boolSuccess:Boolean = __shellIn.connectInput(__coreToShell);
			__core.acceptOutputPipe(__pipeName, __coreToShell);
		}
		
		protected function _connectShellToCore(__core:IPipeAware):void
		{
			var __coreKey:String = (__core as GBPipeAwareCore).key;
			var __pipeName:String = PipeAwareCoreConstants.APP_TO_CORE_PIPE + __coreKey;
			var __shellToCore:Pipe = new Pipe();
			__core.acceptInputPipe(__pipeName, __shellToCore);
			var __shellOut:IPipeFitting = junction.retrievePipe(PipeAwareCoreConstants.APP_TO_CORE_PIPE) as IPipeFitting;
			var __boolSuccess:Boolean = __shellOut.connect(__shellToCore);
		}
		
		protected function _sendMessageToCore(__message:IPipeMessage):void
		{
			if (junction.hasOutputPipe(PipeAwareCoreConstants.APP_TO_CORE_PIPE)) junction.sendMessage(PipeAwareCoreConstants.APP_TO_CORE_PIPE,__message);
		}
		
		protected function _destroyCores(__cores:Vector.<CoreVO>):void
		{
			
			//destroy is misnomer as here we only want to remove the pipe connections out and in from the relevant cores
			var __appOutFitting:TeeSplit = junction.retrievePipe(PipeAwareCoreConstants.APP_TO_CORE_PIPE) as TeeSplit;
			var __appInFitting:TeeMerge = junction.retrievePipe(PipeAwareCoreConstants.CORE_TO_APP_PIPE) as TeeMerge;
			var __vo:DisconnectPipeFittingsVO = new DisconnectPipeFittingsVO(__appOutFitting, __appInFitting);
			for each (var __core:CoreVO in __cores)
			{
				junction.sendMessage(PipeAwareCoreConstants.APP_TO_CORE_PIPE,
					new Message(__core.coreKey,
						PipeConstants.UNPLUMB_CORE_FROM_SHELL,
						__vo,
						Message.PRIORITY_HIGH
					)
				);
			}
			
			
			//now we can go on and notify application mediator to handle the removeChild and destroy functionality on the core
		}

		
		/**
		 * Handle incoming pipe messages for the ShellJunction.
		 * <P>
		 * The LoggerModule sends its LogButton and LogWindow instances
		 * to the Shell for display management via an output Pipe it 
		 * knows as STDSHELL. The PrattlerModule instances also send
		 * their manufactured FeedWindow instances to the shell via
		 * their STDSHELL pipe. Those messages all show up and are
		 * handled here.</P>
		 * <P>
		 * Note that we are handling PipeMessages with the same idiom
		 * as Notifications. Conceptually they are the same, and the
		 * Mediator role doesn't change much. It takes these messages
		 * and turns them into notifications to be handled by other 
		 * actors in the main app / shell.</P> 
		 * <P>
		 * Also, it is logging its actions by sending INFO messages
		 * to the STDLOG output pipe.</P> 
		 */
		
		override public function handlePipeMessage(__message:IPipeMessage):void
		{
			var __messageString:String = this + " : handlePipeMessage in " + this.multitonKey + " MESSAGE DETAILS : getType() = " + __message.getType() + " : getHeader() = " + __message.getHeader() + " : getBody = " + __message.getBody() + " : getPriority = " + __message.getPriority();
			sendNotification(ApplicationFacade.SHOW_SHELL_MESSAGE, __messageString);
			
			//now let's try and kill off simplecore1 on click of simplecore3
			//done in a hacky way as using many instances of same core class
			if (__message.getBody().toString() == Cores.SIMPLE_CORE_3)
			{
				var __action:String = (Facade.hasCore(Cores.SIMPLE_CORE_1) && Facade.hasCore(Cores.SIMPLE_CORE_2)) ? PipeConstants.DESTROY_CORE : PipeConstants.CREATE_CORE;
				var __coresData:Vector.<CoreVO> = (facade.retrieveProxy(ApplicationDataProxy.NAME) as ApplicationDataProxy).coresData;
				var __destroyableCoresData:Vector.<CoreVO> = new Vector.<CoreVO>();
				for each (var __coreVO:CoreVO in __coresData)
				{
					if  (__coreVO.destroyable) __destroyableCoresData.push(__coreVO);
				}
				
				if (__action == PipeConstants.DESTROY_CORE) _destroyCores(__destroyableCoresData);
				sendNotification(__action, __destroyableCoresData);
			}
		}
	}
}