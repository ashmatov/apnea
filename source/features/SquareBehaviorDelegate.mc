import Toybox.WatchUi;
import Toybox.Application.Storage;

class SquareBehaviorDelegate extends WatchUi.BehaviorDelegate {
    
    hidden var view = null;
    hidden var type = SQUARE;
    
    function initialize(t) {
        BehaviorDelegate.initialize();
        type = t;
    }

    function onMenu() {
    	if (view == null) {
            return false;
        }
        
        if (view.isRunning()) {
            return true;
        }

        var isSound = Storage.getValue(type + OPTION + SOUND);
        if (isSound == null ) {
        	isSound = true;
        	Storage.setValue(type + OPTION + SOUND, isSound);
        }
        
        var isVibration = Storage.getValue(type + OPTION + VIBE);
        if (isVibration == null) {
        	isVibration = true;
        	Storage.setValue(type + OPTION + VIBE, isVibration);
        }

  		var circle = Storage.getValue(type + OPTION + CIRCLE);
        if (circle == null) {
        	circle = 1;
        	Storage.setValue(type + OPTION + CIRCLE, circle);
        }
  		
        var inhale = Storage.getValue(type + OPTION + INHALE);
        if (inhale == null) {
        	inhale = 0;
        	Storage.setValue(type + OPTION + INHALE, inhale);
        }
        
        var holdF = Storage.getValue(type + OPTION + HOLDFIRST);
        if (holdF == null) {
        	holdF = 0;
        	Storage.setValue(type + OPTION + HOLDFIRST, holdF);
        }
        
        var exhale = Storage.getValue(type + OPTION + EXHALE);
        if (exhale == null) {
        	exhale = 0;
        	Storage.setValue(type + OPTION + EXHALE, exhale);
        }
        
        var holdS = Storage.getValue(type + OPTION + HOLDSECOND);
        if (holdS == null) {
        	holdS = 0;
        	Storage.setValue(type + OPTION + HOLDSECOND, holdS);
        }
        
       	var myMenu = new WatchUi.Menu2({:title=>WatchUi.loadResource(Rez.Strings.options)});
		myMenu.addItem(new WatchUi.ToggleMenuItem(WatchUi.loadResource(Rez.Strings.sound), "", SOUND, isSound, {}));
		myMenu.addItem(new WatchUi.ToggleMenuItem(WatchUi.loadResource(Rez.Strings.vibration), "", VIBE, isVibration, {}));	
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.circle), circle.format("%02d"), CIRCLE, {}));
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.inhale), TimeFormat.toShort(inhale), INHALE, {}));
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.holdF), TimeFormat.toShort(holdF), HOLDFIRST, {})); 		
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.exhale), TimeFormat.toShort(exhale), EXHALE, {})); 	
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.holdS), TimeFormat.toShort(holdS), HOLDSECOND, {})); 	
	 	WatchUi.pushView(myMenu, new MenuAlert(view, type), WatchUi.SLIDE_RIGHT);
	 	
        return true;
    }

    function onKey(key) {

        if (key.getKey() == WatchUi.KEY_ENTER) {
           if (view.isRunning()) {
                view.stopActivity();
           } else {
                view.startActivity(type);
           }
           return true;
        } else if (key.getKey() == WatchUi.KEY_DOWN && !view.isRunning()) {
        	return true;
        } else if (key.getKey() == WatchUi.KEY_ESC && view.isRunning()) {
			return true;
        }

        return false;
    }

    function setView(v) {
        view = v;
    }

}
