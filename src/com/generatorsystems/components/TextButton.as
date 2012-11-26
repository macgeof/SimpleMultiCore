package com.generatorsystems.components
{
	import com.gb.components.GBTextField;
	import com.generatorsystems.interfaces.*;
	
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * Text button with optional skin.
	 * <p>
	 * You can implement this directly, or more likely extend and
	 * override the draw method to create a layout which suits.
	 */
	public class TextButton extends Button implements ITextComponent
	{
		protected var _styleSheet:StyleSheet;
		protected var _language:String;
		
		protected var _label:String = "I'm a text button";
		protected var _text:GBTextField = new GBTextField();		
		
		protected var _upStyle:String;
		protected var _overStyle:String;
		protected var _downStyle:String;
		protected var _selectedStyle:String;
		protected var _disabledStyle:String;
		
		protected var _padding:Number = 0;
		
		protected var _topPadding:Number = 0;
		protected var _rightPadding:Number = 0;
		protected var _bottomPadding:Number = 0;
		protected var _leftPadding:Number = 0;
		
		//filters for the various states
		protected var _upFilters:Array = new Array();
		protected var _overFilters:Array = new Array();
		protected var _downFilters:Array = new Array();
		protected var _selectedFilters:Array = new Array();
		
		// readability
		protected var _antiAliasType:String = AntiAliasType.ADVANCED;
		
		override public function init():void
		{
			super.init();
			
			text.autoSize = TextFieldAutoSize.LEFT;
			text.antiAliasType = antiAliasType;
			text.language = _language;
			text.styleSheet = _styleSheet;
			text.selectable = false;
			text.mouseEnabled = false;
			addChild(text);
			
			applyFilters();
		}
		
		override protected function handleState():void
		{
			super.handleState();
			
			var style:String;
			
			switch (_state)
			{
				case OVER:
					style = _overStyle;
					break;
				
				case DOWN:
					style = _downStyle;
					break;
				
				case SELECTED:
					style = _selectedStyle;
					break;
				
				case DISABLED:
					style = _disabledStyle;
					break
			}
		
			// Default to up style if other styles aren't specified.
			if (!style) style = _upStyle;
			
			text.htmlText = "<span class='" + style + "'>" + _label + "</span>";
			
			applyFilters();
		}
		
		protected function applyFilters():void
		{
			if (_skin)
			{
				_skin.filters = new Array();
				
				switch (_state)
				{
					case	"up"	:	
						_skin.filters = _upFilters;
						break;
					case	"over"	:	
						_skin.filters = _overFilters;
						break;
					case	"down"	:	
						_skin.filters = _downFilters;
						break;
					case	"disabled"	:	
						_skin.filters = [];
						break;
					case	"selected"	:	
						_skin.filters = _selectedFilters;
						break;
				}
			}
		}

		public function set label(value:String):void
		{
			_label = value;
		}		
		
		public function set styleSheet(value:StyleSheet):void
		{
			_styleSheet = value;
		}

		public function set language(value:String):void
		{
			_language = value;
		}

		public function set upStyle(value:String):void
		{
			_upStyle = value;
		}

		public function set overStyle(value:String):void
		{
			_overStyle = value;
		}

		public function set downStyle(value:String):void
		{
			_downStyle = value;
		}

		public function set selectedStyle(value:String):void
		{
			_selectedStyle = value;
		}

		public function set disabledStyle(value:String):void
		{
			_disabledStyle = value;
		}

		public function get text():GBTextField
		{
			return _text;
		}

		public function set padding(value:Number):void
		{
			_padding = value;
		}

		public function set topPadding(value:Number):void
		{
			_topPadding = value;
		}

		public function set rightPadding(value:Number):void
		{
			_rightPadding = value;
		}

		public function set bottomPadding(value:Number):void
		{
			_bottomPadding = value;
		}

		public function set leftPadding(value:Number):void
		{
			_leftPadding = value;
		}
		
		public function set upFilters(value:Array):void
		{
			if (value) _upFilters = value;
		}
		
		public function set overFilters(value:Array):void
		{
			if (value) _overFilters = value;
		}
		
		public function set downFilters(value:Array):void
		{
			_downFilters = value;
		}
		
		public function set selectedFilters(value:Array):void
		{
			if (value) _selectedFilters = value;
		}

		public function get antiAliasType():String
		{
			return _antiAliasType;
		}

		public function set antiAliasType(value:String):void
		{
			_antiAliasType = value;
		}


	}
}