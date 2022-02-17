import Toybox.WatchUi;
import Toybox.Application.Storage;

class Menu extends WatchUi.BehaviorDelegate {
    
    hidden var view = null;
    hidden var type = null;
    
    function initialize(t) {
        BehaviorDelegate.initialize();
        type = t;
    }

    function onMenu() {
    	if (view == null) {
            return false;
        }

        var isSound = Storage.getValue(type + OPTION + SOUND);
        if (isSound == null) {
        	isSound = true;
        	Storage.setValue(type + OPTION + SOUND, isSound);
        }
        
        var isVibration = Storage.getValue(type + OPTION + VIBE);
        if (isVibration == null) {
        	isVibration = true;
        	Storage.setValue(type + OPTION + VIBE, isVibration);
        }
        
        var first = Storage.getValue(type + OPTION + FIRST);
        if (first == null) {
        	first = 0;
        	Storage.setValue(type + OPTION + FIRST, first);
        }
        
        var second = Storage.getValue(type + OPTION + SECOND);
        if (second == null) {
        	second = 0;
        	Storage.setValue(type + OPTION + SECOND, second);
        }
        
        var third = Storage.getValue(type + OPTION + THIRD);
        if (third == null) {
        	third = 0;
        	Storage.setValue(type + OPTION + THIRD, third);
        }
        
       	var myMenu = new WatchUi.Menu2({:title=>WatchUi.loadResource(Rez.Strings.options)});
		myMenu.addItem(new WatchUi.ToggleMenuItem(WatchUi.loadResource(Rez.Strings.sound), "", SOUND, isSound, {}));
		myMenu.addItem(new WatchUi.ToggleMenuItem(WatchUi.loadResource(Rez.Strings.vibration), "", VIBE, isVibration, {}));	
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.alertF), TimeFormat.toShort(first), FIRST, {}));
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.alertS), TimeFormat.toShort(second), SECOND, {}));
		myMenu.addItem(new WatchUi.MenuItem(WatchUi.loadResource(Rez.Strings.alertT), TimeFormat.toShort(third), THIRD, {})); 		
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

        } else if (key.getKey() == WatchUi.KEY_ESC && !view.isRunning()) {
        	view.saveOnExit();
        } else if (key.getKey() == WatchUi.KEY_ESC && view.isRunning()) {
        	view.nextLap();
			return true;
        }

        return false;
    }

    function setView(v) {
        view = v;
    }

}