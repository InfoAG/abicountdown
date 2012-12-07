package {
 
    import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	//import flash.utils.randomRange;
 
    public class Main extends MovieClip {
 
 		private var _screenTimer:Timer, _G8Timer:Timer;
		private var _targetDate:Date;
		private var _tutors:Array, _airlineExtensions:Array, _statusArray:Array;
		private var _allowG8:Boolean; 
 
 		public function Main()
		{
			_allowG8 = false;
			
			_targetDate = new Date();
			_targetDate.setTime(Date.UTC(2013, 3, 23, 12, 0));
			
			_tutors = new Array("perdun", "neubert", "schuengel", "priebs");
			_airlineExtensions = new Array(["air", true], ["air", false], ["jet", false], ["easy", true], ["wings", false],
										   ["travel", false], ["cargo", false], ["charter", false], ["fly", false]);
			_statusArray = new Array("on time","boarding", "delayed", "cancelled", "last call");
			
			//_G8Timer = new Timer(1200000);
			_G8Timer = new Timer(120000);
			_G8Timer.addEventListener(TimerEvent.TIMER, allowG8);
			_G8Timer.start();
			
			_screenTimer = new Timer(40000);
			_screenTimer.addEventListener(TimerEvent.TIMER, update);
			_screenTimer.start();
			update(new TimerEvent(TimerEvent.TIMER));
		}
		
		public function allowG8(e:TimerEvent)
		{
			_allowG8 = true;
		}
 
        public function update(e:TimerEvent)
		{
			var now:Date = new Date();			
			
			var diff:Number = _targetDate.valueOf() - now.valueOf();
			
			// convert to seconds
			diff = Math.round(diff/1000);
			
			// number of days
			var ourDays:int = Math.floor(diff/ (24 * 60 * 60));
			diff -= ourDays*(24 * 60 * 60 );
			
			// number of hours
			var ourHours:int = Math.floor(diff / (60 * 60))
			diff -= ourHours*60 * 60;
			
			// number of minutes
			var ourMins:int = Math.floor(diff/ 60);

			var gates:Array = new Array();
			for (var j:int = 0; j < 7; j++) {
				var gate:String = String.fromCharCode(65 + 25 * Math.random());
				do {
					gate = gate.charAt(0) + int(9 * Math.random());
				} while (gate == "G9" || gate == "G8" || gates.indexOf(gate) != -1)
				gates.push(gate);
			}

			var ourPos:int = 8 * Math.random();
			var G8Pos:int = -1;
			if (_allowG8) {
				_allowG8 = false;
				G8Pos = 7 * Math.random();
				if (ourPos <= G8Pos) G8Pos += 1;
			}
			
			for(var i:int = 0; i < 8; i++) //Anzahl der Zeilen
			{
				var days:String = new String(), hours:String = new String(), mins:String = new String(), flight:String = new String(), gate:String = new String(), statusStr:String = new String();

				if (i == ourPos) {
					days = ourDays.toString();
					hours = ourHours.toString();
					mins = ourMins.toString();
					flight = "ABI2013";
					gate = "G9";
					statusStr = "ON TIME";
				} else if (i == G8Pos) {
					days = "???";
					hours = "??";
					mins = "??";
					flight = "ABI2013"
					gate = "G8";
					statusStr = "CANCELLED";
				} else {
					days = "000";
					hours = int(24 * Math.random()).toString();
					if (hours.length == 1) hours = "0" + hours;
					mins = int(60 * Math.random()).toString();
					if (mins.length == 1) mins = "0" + mins;
					do {
						var extension:Array = _airlineExtensions[int(Math.random() * _airlineExtensions.length)];
						if (extension[1])
							flight = extension[0] + " " + _tutors[int(Math.random() * _tutors.length)];
						else
							flight =  _tutors[int(Math.random() * _tutors.length)] + " " + extension[0];
					} while (flight.length > 14)
					gate = gates.shift();
					statusStr = _statusArray[int(Math.random() * _statusArray.length)];
				}
				for (var j:int = 0; j < 3; j++) this["time" + i]["d" + j].goal = days.charAt(j);
				for (var j:int = 0; j < 2; j++) this["time" + i]["h" + j].goal = hours.charAt(j);
				for (var j:int = 0; j < 2; j++) this["time" + i]["m" + j].goal = mins.charAt(j);
				for(var j:int = 0; j < 14; j++) //14 Elemente in String
				{
				
					if(j < flight.length)
					{
						this["string" + i]["digit" + j].goal = flight.toUpperCase().charAt(j);
						
					}
					else
					{
						this["string" + i]["digit" + j].goal = " ";
					}
					
				}
				
				this["gate" + i].letter.goal = gate.charAt(0);
				this["gate" + i].gate_num.goal = gate.charAt(1);

				for(var j:int = 0; j < 9; j++)
				{
					if(j < statusStr.length)
					{
						this["status" + i]["l" + j].goal = statusStr.toUpperCase().charAt(j);
					}
					
					else
					{
						this["status" + i]["l" + j].goal = " ";
					}
				}
									
			}
			
        }
		
    }
 
}


