package com.generatorsystems.puremvc.multicore.demo.model.vo
{
	import flash.text.StyleSheet;

	public class CoreVO
	{
		public function CoreVO(__key:String = null, __classPath:String = null, __destroyable:Boolean = false, __data:XML = null)
		{
			coreKey = __key;
			classPath = __classPath;
			destroyable = __destroyable;
			data = __data;
		}
		
		public var coreKey:String;
		public var classPath:String;
		public var destroyable:Boolean;
		public var displayData:XMLList;
		public var data:XML;
		public var styleSheet:StyleSheet;
	}
}