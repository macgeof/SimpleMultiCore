package com.generatorsystems.puremvc.multicore.demo.view.components
{
	import fl.controls.TextArea;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class MessageTracer extends Sprite
	{
		protected var _messageText:TextArea;
		
		public function MessageTracer()
		{
			super();
		}
		
		public function get messageText():TextArea
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
			__graphics.beginFill(0xE1E1E1, 1);
			__graphics.drawRect(0, 0, 300, 125);
			__graphics.endFill();
			addChild(__bg);
			
			_messageText = new TextArea();
			_messageText.x = _messageText.y = 10;
			_messageText.width = 280;
			_messageText.height = 105;
			_messageText.wordWrap = true;
			_messageText.textField.selectable = true;
			_messageText.editable = false;
			_messageText.text = "SHELL\n\n";
			addChild(_messageText);
		}
	}
}