﻿package {
 
    import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.utils.setInterval;
	import flash.utils.Timer;
	
	import com.greensock.*
	import com.greensock.easing.*
 
    public class Digit extends MovieClip {
        private const TOP:int = 0;
        private const BOTTOM:int = 1;
 
        private var _currentDigit:Array;
        private var _nextDigit:Array;
        private var _number:String = "0";
		private var _tickSound:Sound = new TickSound();
         
        // CONSTRUCTOR
        public function Digit()
		{
            _currentDigit = new Array( top1, bottom1 );
            _nextDigit = new Array( top2, bottom2 );
			
			reset();
        }
		
		
		public function flipTo(num:String):void
		{
			_tickSound.play();
    		_number = num;
    		_nextDigit[TOP].t_num.text = num;
    		_nextDigit[BOTTOM].t_num.text = num;
     
			// flip down the top of the digit to the halfway point
			TweenLite.to(_currentDigit[TOP], .15, {scaleY: 0, ease: Linear.easeNone});
			// flip the next digit bottom down
			TweenLite.to(_nextDigit[BOTTOM], .3, {scaleY:1, onComplete: flipComplete,  ease: Bounce.easeOut});
		}
		
		private function flipComplete():void
		{
			// swap digits
			var next:Array = _currentDigit;
			_currentDigit = _nextDigit;
			_nextDigit = next;
			 
			// reset layering
			reset();
		}
		
		private function reset():void
		{
    		addChild(_nextDigit[BOTTOM]);
    		addChild(_currentDigit[TOP]);
     
    		// flip up the next bottom to be behind the current top
    		_nextDigit[BOTTOM].scaleY = -1;
    		_nextDigit[TOP].scaleY = 1;
		}
		
		public function get number():String {
    		return _number;
		}
		
	
	}
}