package com.lassie.lib
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * Interface definition for <code>MediaLibrary</code> implementations.
	 */
    public interface IMediaLibrary
    {
		/**
		 * Returns the contents of the library as an <code>Array</code>
		 * 
		 * @return 	the contents of the library as an <code>Array</code>
		 */
		function get contents():Array;

		/**
		 * Adds the supplied <code>Class</code>.
		 * 
		 * @param	$class	the <code>Class</code> to add
		 * @param	$path	the class path
		 */
		function addClass($class:Class, $path:String=""):void;
		
		/**
		 * Returns an instance of the supplied class.
		 * 
		 * @param 	className	the name of the class
		 * 
		 * @return 	an instance of the supplied class
		 */
        function getAsset(className:String):MovieClip;
		
		/**
		 * Returns the fully qualified class of the supplied class name.
		 * 
		 * @param 	className	the name of the class
		 * 
		 * @return the fully qualified path of the supplied class name
		 */		
		function getAssetClass(className:String):Class;
		
		/**
		 * Returns the filters property of the supplied class.
		 * 
		 * @param 	className	the name of the class
		 * 
		 * @return the filters property of the supplied class
		 */	
		function getFilters(className:String):Array;
    }
}