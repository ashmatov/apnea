import Toybox.WatchUi;

class TestHistoryBehaviorDelegate extends WatchUi.BehaviorDelegate {
    
    hidden var view = null;
    
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
       	var myMenu=new WatchUi.Menu2({:title=>WatchUi.loadResource(Rez.Strings.edit_rows)});
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.clear_all), "", CLEAR_ALL_ROWS, {}));
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.delete_row), "", DELETE_ROW, {})); 		
	 	WatchUi.pushView(myMenu, new TestHistoryMenuDelegate(), WatchUi.SLIDE_RIGHT);
	 	
        return true;
    }

    function onKey(key) {
		if (key.getKey() == WatchUi.KEY_DOWN) {
			view.down();
			return true;
		}
		
		if (key.getKey() == WatchUi.KEY_UP) {
			view.up();
			return true;
		}
		
        return false;
    }

    function setView(v) {
        view = v;
    }

}