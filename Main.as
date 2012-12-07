package {
 
    import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	//import flash.utils.randomRange;
 
    public class Main extends MovieClip {
		var timer:DataTimer
 
        public function Main()
		{
			var targetDate:Date = new Date();
			targetDate.setTime(Date.UTC(2013, 3, 23, 12, 0));
			clock.set(targetDate);
			var now:Date = new Date();			
			
			var flights:Array = new Array("Kairo","Kapstadt","Nairobi","Las Vegas","Miami","Montreal","New York","Toronto","Havanna","Montevideo","Bangkok","Dubai","Hongkong","Jakarta","Manila","Singapur","Adelaide","Canberra","Melbourne","Perth","Sydney","Benelux","Amsterdam","Luxemburg","Berlin","Nizza","Paris","London","Florenz","Mailand","Rom","Venedig","Lissabon","Kopenhagen","Stockholm","Oslo","Barcelona","Madrid","Budapest","Dublin","Moskau","Prag","Wien");
			var gates:Array = new Array("A5","S2","D6","E1","A1","B8","C9","A9","B3","C6","D0","E3","F2,G8","A6");
			var statusArray:Array = new Array("on time","boarding");
			
			
			
			for(var i:int = 0; i < 5; i++) //Anzahl der Zeilen
			{
				for(var j:int = 0; j < 4; j++) //4 Elemente in Time
				{
					timer = new DataTimer(50*j,1);
					timer.data.stringNumber = "time" + i;
					timer.data.digitNumber = "hour" + j;
					if(j == 0)
						timer.data.char = int(now.getHours()/10);
					else if(j == 1)
						timer.data.char = now.getHours()%10;
					else if(j == 2)
						timer.data.char = int(now.getMinutes()/10);
					else
						timer.data.char = now.getMinutes()%10;
					timer.addEventListener(TimerEvent.TIMER_COMPLETE,letter_set);
					timer.start();
				}
				
				var k:int = Math.random() * (flights.length-1 - 0) + 0;
				flights[k] = flights[k].toUpperCase();			
				for(var j:int = 0; j < 14; j++) //14 Elemente in String
				{
				
					if(j < flights[k].toString().length)
					{
						for(var l:int = 32; l <= flights[k].toString().charAt(j).charCodeAt(0); l++)
						{
							if((l <= 47 && l >=34) || (l >= 58 && l <= 64))
								continue;
							timer = new DataTimer(50*(l-31),1);
							timer.data.char = String.fromCharCode(l);
							timer.data.digitNumber = "digit" + j;
							timer.data.stringNumber = "string" + i;
							timer.addEventListener(TimerEvent.TIMER_COMPLETE,letter_set);
							timer.start();
						}
						
					}
					else
					{
						this["string"+i]["digit"+j].flipTo("");
					}
					
				}
				
				k = Math.random() * (statusArray.length-1 - 0) + 0;
				statusArray[k] = statusArray[k].toUpperCase();
				for(var j:int = 0; j < 9; j++)
				{
					if(j < statusArray[k].toString().length)
					{
						for(var l:int = 32; l <= statusArray[k].toString().charAt(j).charCodeAt(0); l++)
						{
							if((l <= 47 && l >=34) || (l >= 58 && l <= 64))
								continue;
							timer = new DataTimer(50*(l-31),1);
							timer.data.char = String.fromCharCode(l);
							timer.data.digitNumber = "l" + j;
							timer.data.stringNumber = "status" + i;
							timer.addEventListener(TimerEvent.TIMER_COMPLETE,letter_set);
							timer.start();
						}
					}
					
					else
					{
						this["status"+i]["l"+j].flipTo("");
					}
				}
									
			}
			
			
			
			
			
			
			
			
			
        }
		
		public function letter_set(event:TimerEvent)
		{
			var tmr:DataTimer = event.currentTarget as DataTimer;
			this[tmr.data.stringNumber][tmr.data.digitNumber].flipTo(tmr.data.char);
			 
		}
		
    }
 
}


