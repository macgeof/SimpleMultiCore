package com.generatorsystems.fonts.classes
{
	public class NobelBook
	{
		
		[Embed(source="../resources/Nobel-Book.otf", fontFamily="Nobel-Book", mimeType="application/x-font", embedAsCFF="false")]
		private var _NobelBook:String;
		public static const NOBEL_BOOK:String = "Nobel-Book";
		
		public function NobelBook()
		{
		}
	}
}