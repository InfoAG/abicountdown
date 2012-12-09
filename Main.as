package {
 
    import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	//import flash.utils.randomRange;
 
    public class Main extends MovieClip {
 
 		private var _screenTimer:Timer, _G8Timer:Timer;
		private var _targetDate:Date;
		private const _teachers:Array = ["perdun", "neubert", "schuengel", "priebs", "heinrich", "wiberny", "unkel", "becker",
										 "diehl", "fleger", "grave", "langela", "mueller", "schmitz", "schrand", "selle", "straub",
										 "wilk", "zech", "hubi", "uwe"];

		private const _airlineExtensions:Array = [["air", true], ["air", false], ["jet", false], ["easy", true], ["wings", false],
						 						  ["travel", false], ["cargo", false], ["charter", false], ["fly", false],
						 						  ["jumbo", false], ["express", false], ["sky", true], ["sky", false], ["aviation", false],
					 	 						  ["freight", false], ["horizon", false], ["shuttle", false]];
		private const _statusArray:Array =  ["on time","boarding", "delayed", "cancelled", "last call"];
		private var _allowG8:Boolean; 
 
 		public function Main()
		{
			_allowG8 = false;
			
			_targetDate = new Date(2013, 2, 22, 12, 0);
			
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
			
			var ourStatus:String;
			if (diff <= 0) {
				ourDays = 0;
				ourHours = 0;
				ourMins = 0;
				ourStatus = "DEPARTED";
			} else {
				// number of days
				var ourDays:int = Math.floor(diff/ (24 * 60 * 60));
				diff -= ourDays*(24 * 60 * 60 );
				
				// number of hours
				var ourHours:int = Math.floor(diff / (60 * 60))
				diff -= ourHours*60 * 60;
				
				// number of minutes
				var ourMins:int = Math.floor(diff/ 60);
				
				if (ourDays == 0 && ourHours < 6) {
					if (ourHours < 2)
						ourStatus = "LAST CALL";
					else 
						ourStatus = "BOARDING";
				} else
					ourStatus = "ON TIME";
			}

			var gates:Array = [];
			var teacherCopy = _teachers.concat();

			var ourPos:int = 8 * Math.random();
			var G8Pos:int = -1;
			if (_allowG8) {
				_allowG8 = false;
				G8Pos = 7 * Math.random();
				if (ourPos <= G8Pos) G8Pos += 1;
			}
			
			var days:String = new String(), hours:String = new String(), mins:String = new String(), flight:String = new String(), gate:String = new String(), statusStr:String = new String();
			var lineColor:int;
			for(var i:int = 0; i < 8; i++) //Anzahl der Zeilen
			{
				if (i == ourPos) {
					days = ourDays.toString();
					hours = ourHours.toString();
					mins = ourMins.toString();
					flight = "ABI2013";
					gate = "G9";
					statusStr = ourStatus;
					lineColor = 0xFCFF00;
				} else {
					lineColor = 0xFFFFFF;
					if (i == G8Pos) {
						days = "???";
						hours = "??";
						mins = "??";
						flight = "ABI2013"
						gate = "G8";
						statusStr = "CANCELLED";
					} else {
						days = "000";
						hours = int(24 * Math.random()).toString();
						mins = int(60 * Math.random()).toString();
	
						var teacherPos:int, extension:Array;
						do {
							extension = _airlineExtensions[int(Math.random() * _airlineExtensions.length)];
							teacherPos = int(Math.random() * teacherCopy.length);
						} while (extension[0].length + teacherCopy[teacherPos].length > 13)
	
						if (extension[1])
							flight = extension[0] + " " + teacherCopy[teacherPos];
						else
							flight =  teacherCopy[teacherPos] + " " + extension[0];
						
						
						do {
							gate = String.fromCharCode(65 + 25 * Math.random()) + int(1 + 9 * Math.random());
						} while (gate == "G9" || gate == "G8" || gates.indexOf(gate) != -1)
						gates.push(gate);
	
						if (teacherCopy[teacherPos] == "hubi")
							statusStr = "SMOKING";
						else
							statusStr = _statusArray[int(Math.random() * _statusArray.length)];
						
						teacherCopy.splice(teacherPos, 1);
					}
				}
				
				while (days.length < 3) days = "0" + days;
				if (hours.length == 1) hours = "0" + hours;
				if (mins.length == 1) mins = "0" + mins;
				for (var j:int = 0; j < 3; j++) this["time" + i]["d" + j].goal = [days.charAt(j), lineColor];
				for (var j:int = 0; j < 2; j++) this["time" + i]["h" + j].goal = [hours.charAt(j), lineColor];
				for (var j:int = 0; j < 2; j++) this["time" + i]["m" + j].goal = [mins.charAt(j), lineColor];

				for(var j:int = 0; j < 14; j++) //14 Elemente in String
				{
				
					if(j < flight.length)
					{
						this["string" + i]["digit" + j].goal = [flight.toUpperCase().charAt(j), lineColor];
						
					}
					else
					{
						this["string" + i]["digit" + j].goal = [" ", lineColor];
					}
					
				}

				this["gate" + i].letter.goal = [gate.charAt(0), lineColor];
				this["gate" + i].gate_num.goal = [gate.charAt(1), lineColor];

				for(var j:int = 0; j < 9; j++)
				{
					if(j < statusStr.length)
					{
						this["status" + i]["l" + j].goal = [statusStr.toUpperCase().charAt(j), lineColor];
					}
					
					else
					{
						this["status" + i]["l" + j].goal = [" ", lineColor];
					}
				}
									
			}
			
        }
		
    }
 
}


