/**
 * @project		Amaze - CarExplorer
 * @author		paulmassey
 * @version		1.0.0
 * @created		Aug 26, 2010 - 10:11:15 AM
 */

/*
(c) Copyright 2010 Milkstorm, all rights reserved.
http://www.milkstorm.com
*/

//===============================================
// Begin package
//===============================================

/**
 * com.amaze.components
 */

package com.generatorsystems.components
{
	//===========================================
	// Import required classes 
	//===========================================
	
	// Adobe
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	//===========================================
	// Begin class
	//===========================================
	
	/**
	 * Begin Class
	 */
	
	public class AssetButton extends AbstractButton
	{
		//---------------------------------------
		// Static
		//---------------------------------------
		
		// Public
		public static const NAME:String = "AssetButton";
		
		//---------------------------------------
		// Protected
		//---------------------------------------
		
		// DisplayObject
		protected var _asset:DisplayObject;
		
		//---------------------------------------
		// Public
		//---------------------------------------
		
		// Empty
		
		//---------------------------------------
		// Begin class
		//---------------------------------------
		
		/**
		 * Class constructor
		 */
		
		public function AssetButton (p_asset:DisplayObject)
		{
			super ();
			
			addChild (p_asset);
			
			_asset = p_asset;
		}
		
		//---------------------------------------
		// 
		//---------------------------------------
		
		/**
		 * 
		 */
		
		override public function init ():void 
		{
			super.init ();
		}
		
		//---------------------------------------
		// 
		//---------------------------------------
		
		/**
		 * 
		 */
		
		override protected function handleState ():void
		{
			try
			{
				var tmpClip:MovieClip = _asset as MovieClip;
				tmpClip.gotoAndStop (_state);
			}
			catch (e:Error)
			{
				// trace ("\t" + NAME + " - Error changing asset button state :: " + e.message);
			}
			
			switch (_state)
			{
				case UP :
					dispatchEvent (new MouseEvent (MouseEvent.ROLL_OUT));
				break;
				case OVER :
					dispatchEvent (new MouseEvent (MouseEvent.ROLL_OVER));
				break;
				case DOWN :
					dispatchEvent (new MouseEvent (MouseEvent.CLICK));
				break;
			}
		}
		
		//---------------------------------------
		// 
		//---------------------------------------
		
		/**
		 * 
		 */
		
		public function get asset ():DisplayObject
		{
			return _asset;
		}
		
		//---------------------------------------
		// End of class
		//---------------------------------------
	}
	
	//===========================================
	// End of package
	//===========================================
}

//===============================================
// End of file
//===============================================
