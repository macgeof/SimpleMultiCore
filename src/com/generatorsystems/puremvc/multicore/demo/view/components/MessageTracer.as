package com.generatorsystems.puremvc.multicore.demo.view.components
{
	import fl.controls.TextArea;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.StyleSheet;
	import flash.text.TextField;

	
	public class MessageTracer extends Sprite
	{
		protected var _messageText:TextField;
		
		public var backgroundWidth:int;
		public var backgroundHeight:int;
		public var backgroundColour:uint;
		public var cssStyleName:String;
		public var styleSheet:StyleSheet;
		
		public function MessageTracer(__width:int = 100, __height:int = 100, __backgroundColour:uint = 0x000000, __styleName:String = null, __styleSheet:StyleSheet = null)
		{
			super();
			backgroundWidth = __width;
			backgroundHeight = __height;
			backgroundColour = __backgroundColour;
			cssStyleName = __styleName;
			styleSheet = __styleSheet;
			
		}
		
		public function get messageText():TextField
		{
			return _messageText;
		}

		public function init():void
		{
			_draw();
		}
		
		protected function _draw():void
		{
			var __bg:Sprite = new Sprite();
			var __graphics:Graphics = __bg.graphics;
			__graphics.lineStyle(1, 0x000000);
			__graphics.beginFill(backgroundColour, 1);
			__graphics.drawRect(0, 0, backgroundWidth, backgroundHeight);
			__graphics.endFill();
			addChild(__bg);
			
			_messageText = new TextField();
			_messageText.x = _messageText.y = 10;
			_messageText.width = backgroundWidth - 20;
			_messageText.height = backgroundHeight - 20;
			_messageText.border = true;
			_messageText.backgroundColor = 0xFFFFFF;
			_messageText.wordWrap = true;
			_messageText.selectable = true;
			_messageText.htmlText = "<span style='" + cssStyleName + "'>SHELL\n\n</span>";
			_messageText.styleSheet = styleSheet;
			addChild(_messageText);
		}
		
		public function addTextToTop(__value:String):void
		{
			var __currentText:String = _messageText.htmlText;
			_messageText.htmlText = __value + __currentText;;
		}
		
		public function addTextToBottom(__value:String):void
		{
			_messageText.htmlText += __value;
		}
	}
}