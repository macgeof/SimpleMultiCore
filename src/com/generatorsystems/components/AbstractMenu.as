package com.generatorsystems.components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	
	import org.casalib.collection.IList;
	import org.casalib.collection.List;

	public class AbstractMenu extends AbstractComponent
	{
		public static const MENU_CLICK:String = "menuClick";
		
		// Collection of AbstractButton instances
		protected var _items:IList = new List();
		protected var _selected:AbstractButton;
		
		// DisplayObject
		protected var _leftArrow:DisplayObject;
		protected var _rightArrow:DisplayObject;
		
		// Boolean
		
		// Number
		protected var _showItems:Number;
		
		override public function init():void
		{
			super.init();
			
			for (var i:int = 0; i < _items.size; i ++)
			{
				var button:AbstractButton = _items.getItemAt(i);
				button.addEventListener(MouseEvent.CLICK, clickHandler);
				addChild (button);
			}
		}
		
		protected function clickHandler(event:Event):void
		{
			setSelected (event.target as AbstractButton);
			dispatchEvent (new Event (MENU_CLICK));
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			for (var i:int = 0; i < _items.size; i ++)
			{
				var button:AbstractButton = _items.getItemAt(i);
				button.removeEventListener(MouseEvent.CLICK, clickHandler);
				removeChild(button);
			}			
		}
		
		public function addItem(value:AbstractButton):void
		{
			_items.addItem(value);
		}
		
		public function setSelected(value:AbstractButton):void
		{
			_selected = value;
			
			for (var i:int = 0; i < _items.size; i ++)
			{
				var button:AbstractButton = _items.getItemAt(i);
				button.selected = (button == _selected);
			}
		}
		
		public function setSelectedByData(value:Object):void
		{
			for (var i:int = 0; i < _items.size; i ++)
			{
				var button:AbstractButton = _items.getItemAt(i);
				button.selected = (button.data == value);
			}
		}
		
		public function get items():IList
		{
			return _items;
		}

		public function set items(value:IList):void
		{
			_items = value;
		}

		public function get selected():AbstractButton
		{
			return _selected;
		}
		
		//---------------------------------------
		// Setters
		//---------------------------------------
		
		/**
		 * set showItems
		 * 
		 * @param p_items:Number
		 */
		
		public function set showItems (p_items:Number):void
		{
			_showItems = p_items;
		}
		
		/**
		 * set leftArrow
		 * 
		 * p_arrow:DisplayObject
		 */
		
		public function set leftArrow (p_arrow:DisplayObject):void
		{
			_leftArrow = p_arrow;
		}
		
		/**
		 * set rightArrow
		 * 
		 * p_arrow:DisplayObject
		 */
		
		public function set rightArrow (p_arrow:DisplayObject):void
		{
			_rightArrow = p_arrow;
		}
	}
}