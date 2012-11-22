package com.generatorsystems.puremvc.multicore.demo.model
{
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class ApplicationProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "ApplicationProxy";
		
		public function ApplicationProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
	}
}