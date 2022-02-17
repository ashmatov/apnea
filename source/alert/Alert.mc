const ALERT_FREQUENCY100 = 100;
const ALERT_FREQUENCY150 = 150;
const ALERT_FREQUENCY200 = 200;
const ALERT_FREQUENCY300 = 300;

const ALERT_DURATION250 = 250;
const ALERT_DURATION500 = 500;
	
class Alert {

	function first(isSound, isVibration) {
		if (isSound) {
			AlertProc.alertSound(Attention.TONE_LOW_BATTERY);
		}
	
		if (isVibration) {
			AlertProc.alertVibeTwo(ALERT_FREQUENCY300, ALERT_DURATION500);
		}
	}	
	
	function second(isSound, isVibration) {
		if (isSound) {
			AlertProc.alertSound(Attention.TONE_ALARM);
		}
			        
		if (isVibration) {
			AlertProc.alertVibeTwo(ALERT_FREQUENCY150, ALERT_DURATION500);
		}
	}
		
	function third(isSound, isVibration) {
		if (isSound) {
			AlertProc.alertSound(Attention.TONE_DISTANCE_ALERT);
		}
			        
		if (isVibration) {
			AlertProc.alertVibeTwo(ALERT_FREQUENCY100, ALERT_DURATION500);
		}
	}
	
	function minus15(isSound, isVibration) {
		if (isSound) {
			AlertProc.alertSound(Attention.TONE_LOUD_BEEP);
		}

		if (isVibration) {
			AlertProc.alertVibeOne(ALERT_FREQUENCY300, ALERT_DURATION250);
		}
	}
	
	function minus5(isSound, isVibration) {
		if (isSound) {
			AlertProc.alertSound(Attention.TONE_MSG);
		}
		        
		if (isVibration) {
			AlertProc.alertVibeTwo(ALERT_FREQUENCY200, ALERT_DURATION250);
		}
	}
	
	function next(isSound, isVibration) {
  		if (isSound) {
			AlertProc.alertSound(Attention.TONE_LAP);
		}
		        
		if (isVibration) {
			AlertProc.alertVibeThree(ALERT_FREQUENCY100, ALERT_DURATION500);
		}
	}
	
	function end(isSound, isVibration) {
		if (isSound) {
			AlertProc.alertSound(Attention.TONE_SUCCESS);
		}

		if (isVibration) {
			AlertProc.alertVibeThree(ALERT_FREQUENCY100, ALERT_DURATION500);
		}
	}
	
}
