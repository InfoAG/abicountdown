﻿package {
	
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	public class Clock extends MovieClip {
		private var _clockTimer:Timer;
		private var _targetDate:Date;
		
		// CONSTRUCTOR
		public function Clock() {
			
		}
		
		// set the target date and start the countdown timer
		public function set(date:Date):void {
			_targetDate = date;
			
			_clockTimer = new Timer(1000) // tick every second (1000 milliseconds)
			_clockTimer.addEventListener(TimerEvent.TIMER, update);
			_clockTimer.start();
			update();
		}
		
		private function update(e:TimerEvent = null):void {
			var now:Date = new Date(); // get the current time
			
			// find the difference (in ms) between the target and now
			var diff:Number = _targetDate.valueOf() - now.valueOf();
			if(diff <=0){
				// TIME'S UP!
				// do something cool here
				_clockTimer.stop();
				_clockTimer.removeEventListener(TimerEvent.TIMER, update);
				diff = 0;
			} 
			
			// convert to seconds
			diff = Math.round(diff/1000);
			
			// number of days
			var days:int = Math.floor(diff/ (24 * 60 * 60));
			diff -= days*(24 * 60 * 60 );
			
			// number of hours
			var hours:int = Math.floor(diff / (60 * 60))
			diff -= hours*60 * 60;
			
			// number of minutes
			var min:int = Math.floor(diff/ 60);
			diff -= min*60;
			
			// seconds are all that remain
			var sec:int = diff;
			
			// create an array of strings to hold the number for each value
			var diffArr:Array = new Array(String(days), String(hours), String(min), String(sec));
			var diffString:String = ""
			var len:int = 3; // the first value (days) has 3 digits. All the rest have 2
			for each(var s:String in diffArr){
				// pad the string with a leading zero if needed
				while(s.length <len){
					s = "0"+s;
				}
				
				len = 2; // all the other values are 2 digits in length
				diffString += s; // add the padded string to the diffString
			}
			
			// go through each character in the diffString and set the corresponding digit
			for(var i:int = 0; i<diffString.length; i++){
				if(diffString.charAt(i) != this["digit"+i].number){
					this["digit"+i].flipTo(diffString.substr(i, 1));
				}
			}

		}
	
	}

}