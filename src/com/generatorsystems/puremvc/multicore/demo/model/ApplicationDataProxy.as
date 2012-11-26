package com.generatorsystems.puremvc.multicore.demo.model
{
	import com.gb.puremvc.model.AbstractLoaderProxy;
	import com.gb.puremvc.model.GBDataProxy;
	import com.gb.puremvc.model.XMLLoaderProxy;
	import com.generatorsystems.puremvc.multicore.demo.model.enums.Cores;
	import com.generatorsystems.puremvc.multicore.demo.model.vo.CoreVO;
	
	import flash.text.StyleSheet;
	
	import org.as3commons.logging.LoggerFactory;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	
	public class ApplicationDataProxy extends GBDataProxy implements IProxy
	{
		public static const NAME:String = "ApplicationDataProxy";
		
		protected var _cores:Vector.<CoreVO> = new Vector.<CoreVO>();
		
		public function ApplicationDataProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
		
		public function get coresData():Vector.<CoreVO>
		{
			return _cores;
		}
		
		public function getCoreByKey(__key:String):CoreVO
		{
			var __return:CoreVO;
			for each (var __core:CoreVO in _cores)
			{
				if (__core.coreKey == __key)
				{
					__return = __core;
					break;
				}
			}
			return __return;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
		}
		
		override protected function onLoad():void
		{
			super.onLoad();
			
			logger = LoggerFactory.getClassLogger(ApplicationDataProxy);
			
			_parseAdditionalData();
		}
		
		protected function _parseAdditionalData():void
		{
			_parseCores(xml.cores.core);
		}
		
		protected function _parseCores(__list:XMLList):void
		{
			var __coreVO:CoreVO;
			var __styleSheet:StyleSheet = serviceLocator.getStyleSheet(Cores.SHELL);
			for each (var __core:XML in __list)
			{
				logger.info(NAME +  " : destroyable = " + __core.@destroyable + " : " + ((__core.(@destroyable=="yes")).length() >0));
				__coreVO = new CoreVO(__core.@name, __core.@classPath, ((__core.(@destroyable=="yes")).length() >0), __core);
				__coreVO.displayData = __core.display;
				__coreVO.styleSheet = __styleSheet;
				_cores.push(__coreVO);
			}
		}
	}
}