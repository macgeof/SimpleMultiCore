package com.generatorsystems.puremvc.multicore.demo.model
{
	import com.gb.puremvc.model.FontProxy;
	
	public class DemoFontProxy extends com.gb.puremvc.model.FontProxy
	{
		public static const NAME:String = "DemoFontProxy";
		
		[Embed(source="../../../../../../fonts/HelveticaNeueLTStd-Hv_2.otf", fontFamily="_HelveticaNeueLTStd-Hv", mimeType="application/x-font", embedAsCFF="false")]
		private var _HelveticaNeueLTStd_Hv:String;
		public static const HELVETICA_NEUE_HV:String = "_HelveticaNeueLTStd-Hv";
		
		[Embed(source="../../../../../../fonts/HelveticaNeueLTStd-Lt_0.otf", fontFamily="_HelveticaNeueLTStd-Lt", mimeType="application/x-font", embedAsCFF="false")]
		private var _HelveticaNeueLTStd_Lt:String;
		public static const HELVETICA_NEUE_LT:String = "_HelveticaNeueLTStd-Lt";
		
		[Embed(source="../../../../../../fonts/HelveticaNeueLTStd-Roman.otf", fontFamily="_HelveticaNeueLTStdRoman", mimeType="application/x-font", embedAsCFF="false")]
		private var _HelveticaNeueLTStd_Roman:String;
		public static const HELVETICA_NEUE_ROMAN:String = "_HelveticaNeueLTStdRoman";
		
		
		public function DemoFontProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
	}
}