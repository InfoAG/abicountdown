package {
 
    import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	//import flash.utils.randomRange;
 
    public class Main extends MovieClip {
 
 		private var _timer:Timer;
		private var _targetDate:Date;
 
 		public function Main()
		{
			_targetDate = new Date();
			_targetDate.setTime(Date.UTC(2013, 3, 23, 12, 0));
			
			_timer = new Timer(40000);
			_timer.addEventListener(TimerEvent.TIMER, update);
			_timer.start();
			update(new TimerEvent(TimerEvent.TIMER));
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
			
			var flights:Array = new Array("Kairo","Kapstadt","Nairobi","Las Vegas","Miami","Montreal","New York","Toronto","Havanna","Montevideo","Bangkok","Dubai","Hongkong","Jakarta","Manila","Singapur","Adelaide","Canberra","Melbourne","Perth","Sydney","Benelux","Amsterdam","Luxemburg","Berlin","Nizza","Paris","London","Florenz","Mailand","Rom","Venedig","Lissabon","Kopenhagen","Stockholm","Oslo","Barcelona","Madrid","Budapest","Dublin","Moskau","Prag","Wien");
			var statusArray:Array = new Array("on time","boarding", "delayed", "cancelled", "last call");

			var gates:Array = new Array();
			for (var j:int = 0; j < 7; j++) {
				var gate:String = String.fromCharCode(65 + 25 * Math.random());
				do {
					gate = gate.charAt(0) + int(9 * Math.random());
				} while (gates.indexOf(gate) != -1)
				gates.push(gate);
			}

			var ourPos:int = 8 * Math.random();
			
			for(var i:int = 0; i < 8; i++) //Anzahl der Zeilen
			{
				var days:String = new String(), hours:String = new String(), mins:String = new String(), flight:String = new String(), gate:String = new String(), statusStr:String = new String();

				if (i == ourPos) {
					days = ourDays.toString();
					hours = ourHours.toString();
					mins = ourMins.toString();
					flight = "ABI13";
					gate = "G9";
					statusStr = "ON TIME";
				} else {
					days = "000";
					hours = int(24 * Math.random()).toString();
					if (hours.length == 1) hours = "0" + hours;
					mins = int(60 * Math.random()).toString();
					if (mins.length == 1) mins = "0" + mins;
					flight = flights[int(Math.random() * (flights.length - 1))].toUpperCase();
					gate = gates.shift();
					statusStr = statusArray[int(Math.random() * (statusArray.length - 1))].toUpperCase();
				}
				for (var j:int = 0; j < 3; j++) this["time" + i]["d" + j].goal = days.charAt(j);
				for (var j:int = 0; j < 2; j++) this["time" + i]["h" + j].goal = hours.charAt(j);
				for (var j:int = 0; j < 2; j++) this["time" + i]["m" + j].goal = mins.charAt(j);
				for(var j:int = 0; j < 14; j++) //14 Elemente in String
				{
				
					if(j < flight.length)
					{
						this["string" + i]["digit" + j].goal = flight.charAt(j);
						
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
						this["status" + i]["l" + j].goal = statusStr.charAt(j);
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


