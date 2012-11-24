package com.generatorsystems.puremvc.multicore.cores.simpleCore.model
{
	import com.generatorsystems.puremvc.multicore.cores.baseCore.model.BaseCoreProxy;
	import com.generatorsystems.puremvc.multicore.demo.model.vo.CoreVO;
	
	import flash.geom.Point;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	
	public class SimpleCoreProxy extends BaseCoreProxy implements IProxy
	{
		public static const NAME:String = "SimpleCoreProxy";
		
		protected var _coreData:CoreVO;
		
		public function SimpleCoreProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			_coreData = data as CoreVO;
		}
		
		override public function onRemove():void
		{
			super.onRemove();
		}
		
		
		public function get corePoint():Point
		{
			var __point:Point = new Point(_coreData.displayData.@x, _coreData.displayData.@y);
			
			return __point;
		}
		
		public function get coreColour():uint
		{
			var __colour:uint = uint(_coreData.displayData.@colour);
			
			return __colour;
		}
	}
}