import Toybox.WatchUi;
import Toybox.Application.Storage;

class NumberPickerDelegate extends WatchUi.Menu2InputDelegate {

	var myValue;
	
    function initialize() {
        Menu2InputDelegate.initialize();
    }
    
    function onSelect(item) {
  		var id=item.getId().toNumber();
  		
  		var lastCounter = Storage.getValue(HISTORY_CURSOR);
        
        if(lastCounter == null) {
			return false;
  		} 
			
		var counter = id + 1;

		while (counter <= lastCounter) {

        	Storage.setValue(TIME + id.format("%02d"), Storage.getValue(TIME + counter.format("%02d")));
        	Storage.setValue(DURATION + id.format("%02d"), Storage.getValue(DURATION + counter.format("%02d")));
        	Storage.setValue(HEARTRATE + id.format("%02d"), Storage.getValue(HEARTRATE + counter.format("%02d")));
        	Storage.setValue(OXYGEN + id.format("%02d"), Storage.getValue(OXYGEN + counter.format("%02d")));

    		id++;	
			counter = id + 1;
		}
			
		Storage.deleteValue(TIME + lastCounter.format("%02d"));
        Storage.deleteValue(DURATION + lastCounter.format("%02d"));
        Storage.deleteValue(HEARTRATE + lastCounter.format("%02d"));
        Storage.deleteValue(OXYGEN + lastCounter.format("%02d"));
        Storage.setValue(HISTORY_CURSOR, lastCounter - 1);
  		
  		// TODO Fix
  		WatchUi.popView(WatchUi.SLIDE_LEFT);
  		WatchUi.popView(WatchUi.SLIDE_LEFT);
  		
  		return true;
    }
}