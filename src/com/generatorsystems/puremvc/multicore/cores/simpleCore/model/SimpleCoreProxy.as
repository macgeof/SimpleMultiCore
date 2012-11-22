package com.generatorsystems.puremvc.multicore.cores.simpleCore.model
{
	import com.generatorsystems.puremvc.multicore.cores.baseCore.model.BaseCoreProxy;
	
	import flash.geom.Point;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	
	public class SimpleCoreProxy extends BaseCoreProxy implements IProxy
	{
		public static const NAME:String = "SimpleCoreProxy";
		
		public function SimpleCoreProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
		
		public function get corePoint():Point
		{
			var __point:Point = new Point(data.data.x, data.data.y);
			
			return __point;
		}
		
		public function get coreColour():uint
		{
			var __colour:uint = data.otherData.colour as uint;
			
			return __colour;
		}
	}
}