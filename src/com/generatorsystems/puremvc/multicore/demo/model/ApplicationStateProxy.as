package com.generatorsystems.puremvc.multicore.demo.model
{
	import com.gb.puremvc.model.AbstractProxy;
	
	public class ApplicationStateProxy extends AbstractProxy
	{
		public static const NAME:String = "ApplicationStateProxy";
		
		public function ApplicationStateProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
		
		override public function onRegister():void
		{
			super.onRegister();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
		}
	}
}