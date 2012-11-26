package com.generatorsystems.fonts.classes
{
	public class NobelLight
	{
		
		[Embed(source="../resources/Nobel-Light.otf", fontFamily="Nobel-Light", mimeType="application/x-font", embedAsCFF="false")]
		private var _NobelLight:String;
		public static const NOBEL_LIGHT:String = "Nobel-Light";
		
		public function NobelLight()
		{
		}
	}
}