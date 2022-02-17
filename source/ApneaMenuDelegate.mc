import Toybox.WatchUi;
import Toybox.System;

class ApneaMenuDelegate extends WatchUi.Menu2InputDelegate {

	hidden var view;
	hidden var behaviorDelegate;
	
    function initialize() {
        Menu2InputDelegate.initialize();
    }

	function onBack() {
		System.exit();
	}
	
    function onSelect(item as Symbol) as Void {
  		var id=item.getId();
  		
  		if(id.equals(TEST)) {
  			view = new TestView();
       		behaviorDelegate = new Menu(id);
  		}
  		
  		if(id.equals(CO2)) {
  			view = new CO2View();
       		behaviorDelegate = new Menu(id);
  		}
  		
  		if(id.equals(O2)) {
  			view = new O2View();
       		behaviorDelegate = new Menu(id);
  		}
  		
  		if(id.equals(MANUAL)) {
  			view = new ManualView();
       		behaviorDelegate = new Menu(id);
  		}
  		
  		if(id.equals(SQUARE)) {
  			view = new SquareView();
       		behaviorDelegate = new SquareBehaviorDelegate(id);
  		}
  		
  		if(id.equals(HISTORY)) {
  			view = new TestHistoryView();
       		behaviorDelegate = new TestHistoryBehaviorDelegate();
  		} 
  		
  		behaviorDelegate.setView(view);
  		WatchUi.pushView(view, behaviorDelegate, WatchUi.SLIDE_RIGHT);
    }

}