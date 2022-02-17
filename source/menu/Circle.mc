import Toybox.WatchUi;
import Toybox.Application.Storage;

class Circle extends WatchUi.Menu2InputDelegate {

	hidden var type;
	
    function initialize(t) {
        Menu2InputDelegate.initialize();
        type = t;
    }
    
    function onSelect(item) {
  		var num=item.getId().toNumber();

  		Storage.setValue(type + OPTION + CIRCLE, num);
  		
  		// TODO Fix
  		WatchUi.popView(WatchUi.SLIDE_LEFT);
  		WatchUi.popView(WatchUi.SLIDE_LEFT);
  		
  		return true;
    }

}