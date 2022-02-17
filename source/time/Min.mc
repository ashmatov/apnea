import Toybox.WatchUi;

class Min extends WatchUi.Menu2InputDelegate {

	const SECMAX = 59;
	
	hidden var view;
	hidden var type;
	hidden var alertNum;
	
    function initialize(t, anum) {
        Menu2InputDelegate.initialize();
        type = t;
        alertNum = anum;
    }

    function onSelect(item) {
  		var min=item.getId().toNumber();
  		
  		var myMenu=new WatchUi.Menu2({:title=>WatchUi.loadResource(Rez.Strings.set_sec)});
		var counter = 0;
		while (counter <= SECMAX) {
			myMenu.addItem(new WatchUi.MenuItem(counter.format("%02d"), "", counter.format("%02d"), {}));
			counter++;
		}		
 		WatchUi.pushView(myMenu, new Sec(type, alertNum, min), WatchUi.SLIDE_RIGHT);
  		
  		return true;
    }
    
}