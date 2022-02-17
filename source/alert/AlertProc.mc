import Toybox.Attention;

const ALERT_PROC_FREQUENCY0 = 0;
const ALERT_PROC_DURATION250 = 250;
	
class AlertProc {

	function alertSound(tone) {
		if (Attention has :playTone) {
			Attention.playTone(tone);
		}
	}
		
	function alertVibeOne(frequency, duration) {
		if (Attention has :vibrate) {
			var vibeData =
			[
				new Attention.VibeProfile(frequency, duration),
			];
			Attention.vibrate(vibeData);
		}	
	}	
		
	function alertVibeTwo(frequency, duration) {
		if (Attention has :vibrate) {
			var vibeData =
			[
				new Attention.VibeProfile(frequency, duration),				
				new Attention.VibeProfile(ALERT_PROC_FREQUENCY0, ALERT_PROC_DURATION250),
				new Attention.VibeProfile(frequency, duration),
			];
			Attention.vibrate(vibeData);
		}
	}
			
	function alertVibeThree(frequency, duration) {
		if (Attention has :vibrate) {
			var vibeData =
			[
				new Attention.VibeProfile(frequency, duration),
				new Attention.VibeProfile(ALERT_PROC_FREQUENCY0, ALERT_PROC_DURATION250),
				new Attention.VibeProfile(frequency, duration),
				new Attention.VibeProfile(ALERT_PROC_FREQUENCY0, ALERT_PROC_DURATION250),
				new Attention.VibeProfile(frequency, duration),
			];
			Attention.vibrate(vibeData);
		}
	}
    
}