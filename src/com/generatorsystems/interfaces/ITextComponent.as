package com.generatorsystems.interfaces
{
	import flash.text.StyleSheet;

	public interface ITextComponent extends IComponent
	{
		function set styleSheet(value:StyleSheet):void;
		function set language(value:String):void;
	}
}