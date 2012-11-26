package com.generatorsystems.puremvc.multicore.demo.transitions
{
	import com.gb.transitions.AbstractTransition;
	import com.greensock.TweenMax;
	
	public class EnterLeftTransition extends AbstractTransition
	{
		public function EnterLeftTransition(target:*=null)
		{
			super(target);
		}
		
		/**
		 * @inheritDoc
		 */ 
		override public function play():void
		{
			TweenMax.fromTo(target, _duration, {autoAlpha:0, x:-500}, {autoAlpha:1, x: target.x, onComplete: onComplete, onUpdate: onUpdate});
		}
		
		/**
		 * @inheritDoc
		 */ 
		override public function reverse():void
		{
			TweenMax.fromTo(target, _duration, {autoAlpha:1, x:target.x}, {autoAlpha:0, x:-500, onComplete: onReverseComplete});
		}
	}
}