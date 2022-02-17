import Toybox.WatchUi;
import Toybox.Application.Storage;

class MenuAlert extends WatchUi.Menu2InputDelegate {

	const CIRCLEMAX = 99;
	const SECMAX = 59;
	
	hidden var view;
	hidden var type;
	
    function initialize(v, t) {
        Menu2InputDelegate.initialize();
        view = v;
        type = t;
    }
    
    function onSelect(item) {
        var id=item.getId();
        
  		if (id.equals(SOUND)) {
  			Storage.setValue(type + OPTION + SOUND, item.isEnabled());
  			return true;
  		}
        
		if (id.equals(VIBE)) {
  			Storage.setValue(type + OPTION + VIBE, item.isEnabled());
  			return true;
  		}
  		
  		if (id.equals(CIRCLE)) {
  			var myMenu=new WatchUi.Menu2({:title=>WatchUi.loadResource(Rez.Strings.set_circle)});
			var counter = 0;
			while (counter <= CIRCLEMAX) {
				myMenu.addItem(new WatchUi.MenuItem(counter.format("%02d"), "", counter.format("%02d"), {}));
    			counter++;
			}		
	 		WatchUi.pushView(myMenu, new Circle(type), WatchUi.SLIDE_RIGHT);

  			return true;
  		}
  		
  		if (id.equals(FIRST) || id.equals(SECOND) || id.equals(THIRD) || id.equals(INHALE) || id.equals(HOLDFIRST) || id.equals(EXHALE) || id.equals(HOLDSECOND)) {
  		    var myMenu=new WatchUi.Menu2({:title=>WatchUi.loadResource(Rez.Strings.set_min)});
			var counter = 0;
			while (counter <= SECMAX) {
				myMenu.addItem(new WatchUi.MenuItem(counter.format("%02d"), "", counter.format("%02d"), {}));
    			counter++;
			}		
	 		WatchUi.pushView(myMenu, new Min(type, id), WatchUi.SLIDE_RIGHT);

  			return true;
  		}
  		
  		return true;
    }
    
}