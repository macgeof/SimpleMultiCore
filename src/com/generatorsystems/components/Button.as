package com.generatorsystems.components
{
	import flash.display.MovieClip;
	
	/**
	 * The most basic button which applies states to supplied skin clip. 
	 */
	public class Button extends AbstractButton
	{
		/*
		* Skin clip must implement its states on frames labelled
		* according to the states specified in AbstractButton.
		*/
		protected var _skin:MovieClip;
		
		override public function init():void
		{
			super.init();
			
			if (_skin)
			{
				_skin.mouseEnabled = false;
				addChild(_skin);
			}	
		}

		override protected function handleState():void
		{
			super.handleState();
			
			if (_skin) 
				_skin.gotoAndStop(_state);
		}		

		override public function destroy():void
		{
			super.destroy();
			
			if (_skin) 
			{
				if (contains(_skin))
					removeChild(_skin);
				
				_skin = null;
			}
		}
		
		public function get skin():MovieClip
		{
			return _skin;
		}
		
		public function set skin(value:MovieClip):void
		{
			_skin = value;
		}
		
		override public function set enabled(value:Boolean):void 
		{
			super.enabled = value;
			
			if (_skin)
				_skin.enabled = value;
		}
	}
}