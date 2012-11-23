package com.generatorsystems.puremvc.multicore.cores.model.vo
{
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeMerge;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeSplit;

	public class DisconnectPipeFittingsVO
	{
		protected var _appOutFitting:TeeSplit;
		protected var _appInFitting:TeeMerge;
		
		public function DisconnectPipeFittingsVO(__out:TeeSplit = null, __in:TeeMerge = null)
		{
			_appOutFitting = __out;
			_appInFitting = __in;
		}

		public function get appInFitting():TeeMerge
		{
			return _appInFitting;
		}

		public function set appInFitting(value:TeeMerge):void
		{
			_appInFitting = value;
		}

		public function get appOutFitting():TeeSplit
		{
			return _appOutFitting;
		}

		public function set appOutFitting(value:TeeSplit):void
		{
			_appOutFitting = value;
		}

	}
}