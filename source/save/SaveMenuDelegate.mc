import Toybox.WatchUi;

class SaveMenuDelegate extends WatchUi.Menu2InputDelegate {

	var view;
	
    function initialize(v) {
        Menu2InputDelegate.initialize();
        view = v;
    }

    function onMenuItem(item as Symbol) as Void {
		return true;
    }
    
    function onSelect(item) {
        var id=item.getId();
  		if (id.equals(YES)) {
  			view.save();		
  		}
 
 		// TODO Fix
  		WatchUi.popView(WatchUi.SLIDE_LEFT);
  		WatchUi.popView(WatchUi.SLIDE_LEFT);
  		
  		return true;
    }
    
}