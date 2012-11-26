package com.generatorsystems.components
{
	import com.gb.layout.*;
	import com.generatorsystems.interfaces.IComponent;
	
	import flash.display.*;
	
	/**
	 * Base class for components. 
	 */
	public class AbstractComponent extends Sprite implements IComponent
	{
		private var _layoutNamespace:Namespace = standard;
		
		public function AbstractComponent() 
		{	
			// Abstract class, don't instantiate directly.
		}
		
		public function init():void
		{
			// Implement in subclass
		}
		
		public function draw():void
		{
			/*
			* Implement in subclass.
			* Create draw methods for standard and rtl layouts and
			* invoke as follows:
			* layoutNamespace::draw();
			*/
		}
		
		public function destroy():void
		{
			// Implement in subclass
		}
		
		protected function removeAndNull(child:DisplayObject):void
		{
			if(child)
			{
				if(contains(child))
				{
					removeChild(child);
					child = null;
				}
			}
		}

		public function get layoutNamespace():Namespace
		{
			return _layoutNamespace;
		}

		public function set layoutNamespace(value:Namespace):void
		{
			_layoutNamespace = value;
		}
	}
}