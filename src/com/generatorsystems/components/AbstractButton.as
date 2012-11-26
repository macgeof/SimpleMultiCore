package com.generatorsystems.components
{
	
	import com.generatorsystems.components.AbstractComponent;
	import com.generatorsystems.interfaces.IData;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * Base class for buttons. 
	 */
	public class AbstractButton extends AbstractComponent implements IData
	{
		// Supported states.
		public static const UP:String = "up";
		public static const OVER:String = "over";
		public static const DOWN:String = "down";
		public static const SELECTED:String = "selected";
		public static const DISABLED:String = "disabled";
		
		// Default state. 
		protected var _state:String = UP;		
		protected var _data:*;
		protected var _enabled:Boolean = true;
		protected var _selected:Boolean = false;
		
		public function AbstractButton() 
		{	
			// Don't instantiate directly. Won't do anything anyway.
		}
		
		override public function init():void
		{
			super.init();
			
			addListeners();
			enabled = true;
		}
		
		protected function addListeners():void
		{
			if (!hasEventListener(MouseEvent.MOUSE_UP))
			{
				addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
				addEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
				addEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
				addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			}
		}
		
		protected function mouseHandler(event:MouseEvent):void
		{
			var state:String;
					
			// Convert mouse events names into our Button states.
			switch (event.type)
			{
				case MouseEvent.MOUSE_OUT:
					state = UP;
				break;
				case MouseEvent.MOUSE_DOWN:
					state = DOWN;
					dispatchEvent(new MouseEvent(MouseEvent.CLICK));
				break;
				case MouseEvent.MOUSE_UP:
				case MouseEvent.MOUSE_OVER:
					state = OVER;
				break;	
			}
			
			setState(state);
		}
		
		override public function draw():void
		{
			super.draw();
			
			handleState();
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			removeListeners();
			
			_state = null;
			_data = null;
		}
		
		protected function removeListeners():void
		{
			if (hasEventListener(MouseEvent.MOUSE_UP))
			{
				removeEventListener(MouseEvent.MOUSE_UP, mouseHandler);
				removeEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
				removeEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
				removeEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			}
		}		
		
		public function setState(value:String):void
		{
			_state = value;
			handleState();
		}		
		
		protected function handleState():void
		{
			// implement in subclass
		}
		
		public function set enabled (value:Boolean):void
		{
			_enabled = value;			
			mouseChildren = !value;
			buttonMode = value;
			mouseEnabled = value;
			useHandCursor = value;
			
			var state:String;
			
			if (_enabled)
			{
				addListeners();
				state = selected ? SELECTED : UP;
			}
			else
			{
				removeListeners();
				state = selected ? SELECTED : DISABLED;
			}
			
			setState(state);
		}
		
		public function get enabled():Boolean
		{
			return _enabled
		}
		
		public function get data():* { return _data; }
		
		public function set data(value:*):void 
		{
			_data = value;
		}

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
			enabled = !_selected;
		}
	}
}