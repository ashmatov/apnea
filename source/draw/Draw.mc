const PERIODTIMEDEFAULT = 0;
	
class Draw {
    
    function drawMainTextLabel(view, text) {
        view.setText(text);
    }
     
    function drawHeartrateLabel(view) {
        if (heartRate > 0) {
            view.setText(Lang.format("$1$", [heartRate.format("%d")]));
            return true;
        } 
        
        view.setText(WatchUi.loadResource(Rez.Strings.no_value));
        return true;
    }
    
    function drawOxygenSaturationLabel(view) {
        if (oxygenSaturation > 0) {
            view.setText(Lang.format("$1$", [oxygenSaturation.format("%d")]));
            return true;
        }
            
        view.setText(WatchUi.loadResource(Rez.Strings.no_value));
        return true;
    }

        
    function drawGoalLabel(view) {
    	if (steps.size() > 0) {
        	view.setText(TimeFormat.toShort(steps[currentStep]));
		}
    }
    
    function drawLapLabel(view) {
        if (running || lapTime != PERIODTIMEDEFAULT) {
            view.setText(TimeFormat.toShort(lapTime));
            return true;
        }
        
        view.setText(WatchUi.loadResource(Rez.Strings.lap_zero_time));
        return true;
    }
      
    function drawTimerLabel(view) {
        if (running || periodTime != PERIODTIMEDEFAULT) {
            view.setText(TimeFormat.toFull(periodTime));
            return true;
        }

        view.setText(WatchUi.loadResource(Rez.Strings.total_zero_time));
        return true;
    }
    
}