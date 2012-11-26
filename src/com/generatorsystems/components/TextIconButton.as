package com.generatorsystems.components
{
	import flash.display.MovieClip;
	
	/**
	 * 
	 */
	public class TextIconButton extends TextButton
	{
		protected var _icon:MovieClip;
		
		override public function init():void 
		{
			super.init();
			
			if (_icon)
				addChild(_icon);
		}

		override protected function handleState():void
		{
			super.handleState();
			
			if (_icon) 
				_icon.gotoAndStop(_state);
		}			
		
		override public function destroy():void
		{
			if (_icon) 
			{
				if (contains(_icon))
					removeChild(_icon);
				
				_icon = null;
			}
		}
		
		public function get icon():MovieClip
		{
			return _icon;
		}

		public function set icon(value:MovieClip):void
		{
			_icon = value;
		}
		
		override public function set enabled(value:Boolean):void 
		{
			super.enabled = value;
			
			if (_icon)
				_icon.enabled = value;
		}
	}
}