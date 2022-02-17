import Toybox.WatchUi;
import Toybox.Application.Storage;

class TestHistoryMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }
    
    function onSelect(item) {
        var id=item.getId();
        
  		if (id.equals(CLEAR_ALL_ROWS)) {
			var counter = 0;
	        var lastCounter = Storage.getValue(HISTORY_CURSOR);
	        
	        if (lastCounter == null) {
	        	WatchUi.popView(WatchUi.SLIDE_LEFT);
	        }

			while (counter <= lastCounter) {
				Storage.deleteValue(TIME + counter.format("%02d"));
	        	Storage.deleteValue(DURATION + counter.format("%02d"));
	        	Storage.deleteValue(HEARTRATE + counter.format("%02d"));
	        	Storage.deleteValue(OXYGEN + counter.format("%02d"));
	    			
				counter++;
			}
  		
  			Storage.deleteValue(HISTORY_CURSOR);
  			
  			WatchUi.popView(WatchUi.SLIDE_LEFT);
  		}
  		
  		if (id.equals(DELETE_ROW)) {
  			var myMenu=new WatchUi.Menu2({:title=>WatchUi.loadResource(Rez.Strings.row_num)});
  			
  			var lastCounter = Storage.getValue(HISTORY_CURSOR);
  			if (lastCounter == null || lastCounter == 0) {
				WatchUi.popView(WatchUi.SLIDE_LEFT);
				return true;
			}

			var counter = 1;
			while (counter <= lastCounter) {
				myMenu.addItem(new WatchUi.MenuItem(counter.format("%02d"), "", counter.format("%02d"), {}));
    			counter++;
			}
            
  			WatchUi.pushView(myMenu, new NumberPickerDelegate(), WatchUi.SLIDE_RIGHT);
  		}
    }

}