package com.generatorsystems.puremvc.multicore.cores.baseCore.model
{
	import com.gb.puremvc.model.AbstractProxy;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	
	public class BaseCoreProxy extends AbstractProxy implements IProxy
	{
		public static const NAME:String = "SimpleCoreProxy";
		
		protected var _shellInConnected:Boolean;
		protected var _shellOutConnect:Boolean;
		
		public function BaseCoreProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}

		public function get shellOutConnect():Boolean
		{
			return _shellOutConnect;
		}

		public function set shellOutConnect(value:Boolean):void
		{
			_shellOutConnect = value;
		}

		public function get shellInConnected():Boolean
		{
			return _shellInConnected;
		}

		public function set shellInConnected(value:Boolean):void
		{
			_shellInConnected = value;
		}

	}
}