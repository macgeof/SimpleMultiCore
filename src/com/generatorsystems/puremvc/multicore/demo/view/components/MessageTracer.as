package com.generatorsystems.puremvc.multicore.demo.view.components
{
	import com.gb.components.GBTextField;
	
	import fl.containers.ScrollPane;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.StyleSheet;
	import flash.text.TextFieldAutoSize;
	
	import flashx.textLayout.container.ScrollPolicy;

	
	public class MessageTracer extends Sprite
	{
		protected var _messageText:GBTextField;
		protected var _messageTextContainer:Sprite;
		protected var _scrollPane:ScrollPane;
		
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
		public function init():void
		{
			_draw();
		}
		
		protected function _draw():void
		{
			_drawBackground();
			_drawMessageBox();
			_drawScrollPane();
		}
		
		protected function _drawBackground():void
		{
			var __bg:Sprite = new Sprite();
			var __graphics:Graphics = __bg.graphics;
			__graphics.lineStyle(1, 0x000000);
			__graphics.beginFill(backgroundColour, 1);
			__graphics.drawRect(0, 0, backgroundWidth, backgroundHeight);
			__graphics.endFill();
			addChild(__bg);
		}
		
		protected function _drawMessageBox():void
		{
			_messageTextContainer = new Sprite();
			_messageTextContainer.x = _messageTextContainer.y = 10;
			addChild(_messageTextContainer);
			
			_messageText = new GBTextField();
			_messageText.width = backgroundWidth - 20;
			_messageText.height = backgroundHeight - 20;
			_messageText.selectable = false;
			_messageText.background = true;
			_messageText.autoSize = TextFieldAutoSize.LEFT;
			_messageText.backgroundColor = 0xFFFFFF;
			_messageText.wordWrap = true;
			_messageText.selectable = true;
			_messageText.htmlText = "<span style='" + cssStyleName + "'>SHELL\n\n</span>";
			_messageText.styleSheet = styleSheet;
			_messageTextContainer.addChild(_messageText);
		}
		
		protected function _drawScrollPane():void
		{
			_scrollPane = new ScrollPane();
			addChild(_scrollPane);
			_scrollPane.move(10, 10);
			_scrollPane.setSize(backgroundWidth - 20, backgroundHeight - 20);
			_scrollPane.scrollDrag = false;
			_scrollPane.source = _messageTextContainer;
			_scrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
			_scrollPane.verticalScrollPolicy = ScrollPolicy.ON;
		}
		
		public function addTextToTop(__value:String):void
		{
			var __currentText:String = _messageText.text;
			_messageText.htmlText = "<span class='" + cssStyleName + "'>" + __value + "\n\n" + __currentText + "</span>";
			
			_scrollPane.update();
		}
		
		public function addTextToBottom(__value:String):void
		{
			var __currentText:String = _messageText.text;
			_messageText.htmlText = "<span class='" + cssStyleName + "'>" + __currentText + "\n\n" + __value + "</span>";
			
			_scrollPane.update();
		}
	}
}