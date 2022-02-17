import Toybox.WatchUi;

class ApneaView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        var myMenu=new WatchUi.Menu2({:title=>WatchUi.loadResource(Rez.Strings.title)});
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.test), "", TEST, {}));
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.co2), "", CO2, {}));
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.o2), "", O2, {}));	 	
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.manual), "", MANUAL, {}));
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.square), "", SQUARE, {}));
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.test_history), "", HISTORY, {}));
				
        WatchUi.pushView(myMenu, new ApneaMenuDelegate(), WatchUi.SLIDE_RIGHT);
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
    }

}