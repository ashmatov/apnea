import Toybox.WatchUi;
import Toybox.Application.Storage;

class Sec extends WatchUi.Menu2InputDelegate {

	hidden var type;
	hidden var alertNum;
	hidden var min;
	
    function initialize(t, anum, m) {
        Menu2InputDelegate.initialize();
        type = t;
        alertNum = anum;
        min = m;
    }
    
    function onSelect(item) {
  		var sec=item.getId().toNumber();
  		
  		Storage.setValue(type + OPTION + alertNum, sec + min * 60);
  		
  		// TODO Fix
  		WatchUi.popView(WatchUi.SLIDE_LEFT);
  		WatchUi.popView(WatchUi.SLIDE_LEFT);
  		WatchUi.popView(WatchUi.SLIDE_LEFT);
  		
  		return true;
    }

}