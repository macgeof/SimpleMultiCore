package com.generatorsystems.puremvc.multicore.demo.transitions
{
	import com.gb.transitions.AbstractTransition;
	import com.greensock.TweenMax;
	
	public class ExitLeftTransition extends AbstractTransition
	{
		public function ExitLeftTransition(target:*=null)
		{
			super(target);
		}
		
		/**
		 * @inheritDoc
		 */ 
		override public function play():void
		{
			TweenMax.to(target, _duration, {autoAlpha:0, x:target.x-500, onComplete: onComplete, onUpdate: onUpdate});
		}
		
		/**
		 * @inheritDoc
		 */ 
		override public function reverse():void
		{
			TweenMax.to(target, _duration, {autoAlpha:1, onComplete: onReverseComplete});
		}
	}
}