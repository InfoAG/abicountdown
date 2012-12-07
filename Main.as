package {
 
    import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	//import flash.utils.randomRange;
 
    public class Main extends MovieClip {
 
 		private var _timer:Timer;
 
 		public function Main()
		{
			_timer = new Timer(40000);
			_timer.addEventListener(TimerEvent.TIMER, update);
			_timer.start();
			update(new TimerEvent(TimerEvent.TIMER));
		}
 
        public function update(e:TimerEvent)
		{
			
			var targetDate:Date = new Date();
			targetDate.setTime(Date.UTC(2013, 3, 23, 12, 0));
			//clock.set(targetDate);
			var now:Date = new Date();			
			
			var flights:Array = new Array("Kairo","Kapstadt","Nairobi","Las Vegas","Miami","Montreal","New York","Toronto","Havanna","Montevideo","Bangkok","Dubai","Hongkong","Jakarta","Manila","Singapur","Adelaide","Canberra","Melbourne","Perth","Sydney","Benelux","Amsterdam","Luxemburg","Berlin","Nizza","Paris","London","Florenz","Mailand","Rom","Venedig","Lissabon","Kopenhagen","Stockholm","Oslo","Barcelona","Madrid","Budapest","Dublin","Moskau","Prag","Wien");
			var gates:Array = new Array("A5","S2","D6","E1","A1","B8","C9","A9","B3","C6","D0","E3","F2,G8","A6");
			var statusArray:Array = new Array("on time","boarding");
			
			for(var i:int = 0; i < 5; i++) //Anzahl der Zeilen
			{

				this["time" + i].hour0.goal = int(now.getHours()/10);
				this["time" + i].hour1.goal = now.getHours()%10;
				this["time" + i].hour2.goal = int(now.getMinutes()/10);
				this["time" + i].hour3.goal = int(now.getMinutes()%10);

				
				var k:int = Math.random() * (flights.length - 1);
				flights[k] = flights[k].toUpperCase();			
				for(var j:int = 0; j < 14; j++) //14 Elemente in String
				{
				
					if(j < flights[k].toString().length)
					{
						this["string" + i]["digit" + j].goal = flights[k].toString().charAt(j);
						
					}
					else
					{
						this["string" + i]["digit" + j].goal = " ";
					}
					
				}
				
				k = Math.random() * (statusArray.length - 1);
				statusArray[k] = statusArray[k].toUpperCase();
				for(var j:int = 0; j < 9; j++)
				{
					if(j < statusArray[k].toString().length)
					{
						this["status"+i]["l"+j].goal = statusArray[k].toString().charAt(j);
					}
					
					else
					{
						this["status"+i]["l"+j].goal = " ";
					}
				}
									
			}
			
			
			
			
			
			
			
			
			
        }
		
    }
 
}


