import Toybox.WatchUi;
import Toybox.Application.Storage;
import Toybox.Time.Gregorian;

class Save {

	var duration;
	var heartRate;
	var oxygenSaturation;
	
	function Save(duration, heartRate, oxygenSaturation) {
		if (duration == 0) {
			return;
		}
		
		var id = 1;
  		var lastCounter = id;
        var counter = Storage.getValue(HISTORY_CURSOR);
        if (counter == null) {
			counter = 1;
  		} else {
  			id = counter + 1;
  			lastCounter = id;
			
			while (id > 1) {

        		Storage.setValue(TIME + id.format("%02d"), Storage.getValue(TIME + counter.format("%02d")));
        		Storage.setValue(DURATION + id.format("%02d"), Storage.getValue(DURATION + counter.format("%02d")));
        		Storage.setValue(HEARTRATE + id.format("%02d"), Storage.getValue(HEARTRATE + counter.format("%02d")));
        		Storage.setValue(OXYGEN + id.format("%02d"), Storage.getValue(OXYGEN + counter.format("%02d")));
    			
				counter--;
				id--;
			}
  		}
  		
		var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		var dateString = Lang.format(
		    "$1$.$2$.$3$ $4$:$5$",
		    [
		   		today.day.format("%02d"),
		        today.month.format("%02d"),
		        today.year,
		        today.hour.format("%02d"),
		        today.min.format("%02d")
		    ]
		);
        
        Storage.setValue(HISTORY_CURSOR, lastCounter);
        Storage.setValue(TIME + id.format("%02d"), dateString);
        Storage.setValue(DURATION + id.format("%02d"), duration);
        Storage.setValue(HEARTRATE + id.format("%02d"), heartRate.format("%02d"));
        Storage.setValue(OXYGEN + id.format("%02d"), oxygenSaturation.format("%02d"));
	}
	
	function Menu(view) {
		var myMenu=new WatchUi.Menu2({:title=>WatchUi.loadResource(Rez.Strings.save_history)});
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.yes), "", YES, {}));
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.no), "", NO, {}));	 
		// TODO Fix		
	 	WatchUi.pushView(myMenu, new SaveMenuDelegate(view), WatchUi.SLIDE_RIGHT);
	 	WatchUi.pushView(myMenu, new SaveMenuDelegate(view), WatchUi.SLIDE_RIGHT);
	}
	
}