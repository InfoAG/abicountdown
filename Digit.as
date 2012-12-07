package {
 
    import flash.display.MovieClip;
	import flash.utils.setInterval;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	import com.greensock.*
	import com.greensock.easing.*
 
    public class Digit extends MovieClip {
        private const TOP:int = 0;
        private const BOTTOM:int = 1;
 
        private var _currentDigit:Array;
        private var _nextDigit:Array;
		private var _goal:String;
        private var _current:String = "0";
		private var _timer:Timer;
		private var _distance:int;
         
        // CONSTRUCTOR
        public function Digit()
		{
            _currentDigit = new Array( top1, bottom1 );
            _nextDigit = new Array( top2, bottom2 );
			
			_timer = new Timer(1 + 100 * Math.random(), 1);
			_timer.addEventListener(TimerEvent.TIMER, flip);
			
			reset();
        }
		
		public function set goal(goal:String):void
		{
			_goal = goal;
			if (goal != _current) {
				if (goal.charCodeAt() > _current.charCodeAt())
					_distance = goal.charCodeAt() - _current.charCodeAt();
				else _distance = 90 - _current.charCodeAt() + goal.charCodeAt() - 32 + 1;
				
				_timer.start();
			}
		}
		
		
		public function flip(e:TimerEvent):void
		{
			if (_current == "Z") _current = " ";
			else _current = String.fromCharCode(_current.charCodeAt() + 1);
    		_nextDigit[TOP].t_num.text = _current;
    		_nextDigit[BOTTOM].t_num.text = _current;
     
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
			
			if (--_distance != 0) _timer.start();
			 
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
	
	}
}