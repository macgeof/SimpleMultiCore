package  com.generatorsystems.library {
	
	import flash.display.MovieClip;
	import com.lassie.lib.MediaLibrary
	
	/**
	 * The document class for visual libraries created in the Flash IDE.
	 * <p>
	 * This is a rather silly workaround caused by the fact that the Flash IDE
	 * will not accept a class stored within a SWC as the document class.</p>
	 * <p>
	 * We can, however, get access to the <code>MediaLibrary</code> class in the 
	 * AmazePureMVC framework SWC by extending it and setting the subclass as the 
	 * document class for the library.</p>
	 */
	public dynamic class Library extends MediaLibrary 
	{	
		public function Library() 
		{
			// constructor code
		}
	}	
}
