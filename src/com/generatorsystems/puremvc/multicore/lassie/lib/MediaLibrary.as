package com.lassie.lib
{
	import flash.display.MovieClip;

	/**
	 * The document class for visual libraries created in the Flash IDE.
	 * <p>
	 * Provides methods to retrieve the elements of the library.</p>
	 */
	public dynamic class MediaLibrary extends MovieClip implements IMediaLibrary
	{
		/**
		 * Constructor.
		 */
		public function MediaLibrary():void
		{
			super();
		}

		/**
		 * @inheritDoc
		 */
		public function addClass($class:Class, $path:String = ""):void
		{
			if (($path.split(".")).length > 1)
			{
				this[$path] = $class;
			}
			else
			{
				var $cname:String = $class.toString();
				this[$cname.substr(7, $cname.length - 8)] = $class;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function get contents():Array
		{
			var classList:Array = new Array();

			for (var j:String in this)
			{
				classList.push(j);
			}
			classList.sort();
			return classList;
		}

		/**
		 * @inheritDoc
		 */
		public function getAsset(className:String):MovieClip
		{
			try
			{
				var classObj:Class = this[className];
				return new classObj();
			}
			catch (e:Error)
			{
				trace("error extracting requested class: " + className);
			}
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getAssetClass(className:String):Class
		{
			try
			{
				var classObj:Class = this[className];
				return classObj;
			}
			catch (e:Error)
			{
				trace("error extracting requested class: " + className);
			}
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function getFilters(className:String):Array
		{
			try
			{
				var instance:MovieClip = getAsset(className);
				return instance.getChildAt(0).filters;
			}
			catch (e:Error)
			{
				trace("error extracting filters from: " + className);
			}
			return null;
		}
	}
}