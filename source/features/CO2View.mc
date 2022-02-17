import Toybox.WatchUi;
import Toybox.Application.Storage;
import Toybox.Time.Gregorian;
import Toybox.Timer;

class CO2View extends WatchUi.View {

	const PERIODTIMEDEFAULT = 0;
	const DURATIONDEFAULT = 60;
	const DURATIONMIN = 10;
	const DURATIONSTEP = 15;
	const MAXPERCENT = 0.7;
	const ATTENTION1 = 15;
	const ATTENTION2 = 5;
	const SEC1 = 1000;
	
	hidden var steps;
	hidden var currentStep = 0;
	hidden var stepLabel = [WatchUi.loadResource(Rez.Strings.breath), WatchUi.loadResource(Rez.Strings.hold)];
	hidden var currentLevel = 0;
	    
    hidden var periodTime = PERIODTIMEDEFAULT;
    hidden var lapTime = PERIODTIMEDEFAULT;
    
    hidden var running = false;
    hidden var timer = null;
    
    hidden var session = null;
    
    hidden var heartRate = 0;
    hidden var oxygenSaturation = 0;
    
    hidden var isSound = true;
    hidden var isVibration = true;
    hidden var alert1 = 0;
	hidden var alert2 = 0;
	hidden var alert3 = 0;
    
    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.CO2(dc));

        Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE, Sensor.SENSOR_PULSE_OXIMETRY, Sensor.SENSOR_ONBOARD_HEARTRATE, Sensor.SENSOR_ONBOARD_PULSE_OXIMETRY]);
        Sensor.enableSensorEvents(method(:sensorAction));
		
   		var durationMax = Storage.getValue(HISTORY_FIRST_RECORD);
  		
  		if (durationMax == null || durationMax < DURATIONDEFAULT) {
  			durationMax = DURATIONDEFAULT;
  		}
  		
  		durationMax = durationMax * MAXPERCENT;
  		durationMax = durationMax.toNumber();
  		
  		var breath = durationMax;

        setStartPeriodTime();
        
        steps = [];
        while (breath > DURATIONMIN) {
        	steps.add(breath);
			steps.add(durationMax);
			breath = breath - DURATIONSTEP;
		}
        
        steps.add(DURATIONMIN);
		steps.add(durationMax);
		
  		for (var i = 0; i < steps.size(); i++) {
			periodTime = periodTime + steps[i];
		}
    }

    function onUpdate(dc as Dc) as Void {
        var view;

        view = View.findDrawableById(TextLabel);
        Draw.drawMainTextLabel(view, stepLabel[currentLevel % 2]);

        view = View.findDrawableById(HeartrateLabel);
        Draw.drawHeartrateLabel(view);
        
        view = View.findDrawableById(OxygenSaturationLabel);
        Draw.drawOxygenSaturationLabel(view);
        
        view = View.findDrawableById(GoalTimeLabel);
        Draw.drawGoalLabel(view);
        
        view = View.findDrawableById(CurrentLapLabel);
        Draw.drawLapLabel(view);
                
        view = View.findDrawableById(TotalTimeLabel);
        Draw.drawTimerLabel(view);
        
        View.onUpdate(dc);
    }
    
    function isRunning() {
        return running;
    }
    
    function setStartPeriodTime() {
        lapTime = PERIODTIMEDEFAULT;
        periodTime = periodTime;
    }
    
    function sensorAction(info) {
        if (info != null) {

            heartRate = (info.heartRate == null) ? 0 : info.heartRate;
            oxygenSaturation = (info.oxygenSaturation == null) ? 0 : info.oxygenSaturation;

            WatchUi.requestUpdate();
        }
    }
    
    function timerAction() {
        if (running) {
            if (periodTime > 0) {
				periodTime--;
            }

            lapTime++;
  
            if (currentLevel % 2 == 1) {
	            if (alert1 != 0 && alert1 == lapTime) {
					Alert.first(isSound, isVibration);
	            }

	            if (alert2 != 0 && alert2 == lapTime) {
					Alert.second(isSound, isVibration);	
	            }

	            if (alert3 != 0 && alert3 == lapTime) {
					Alert.third(isSound, isVibration);
				}	
            }
				
            if (steps.size() > 0 && lapTime == steps[currentStep] - ATTENTION1) {
				Alert.minus15(isSound, isVibration);
            }
            
            if (steps.size() > 0 && lapTime == steps[currentStep] - ATTENTION2) {
				Alert.minus5(isSound, isVibration);
            }
            
            if (steps.size() > 0 && lapTime >= steps[currentStep]) {
				Alert.next(isSound, isVibration);
	            currentLevel++;
	            if (currentStep < steps.size() - 1) {
	            	lapTime = PERIODTIMEDEFAULT;
	               	currentStep++;
	               	nextLap();
	            } else {
	            	stopActivity();
					Alert.end(isSound, isVibration);
	            }
			}
        }

        WatchUi.requestUpdate();
    }
   
    function startActivity(type) {
		isSound = Storage.getValue(type + OPTION + SOUND);
		isVibration = Storage.getValue(type + OPTION + VIBE);
		
		alert1 = Storage.getValue(type + OPTION + FIRST);
		alert2 = Storage.getValue(type + OPTION + SECOND);
		alert3 = Storage.getValue(type + OPTION + THIRD);

		if (Toybox has :ActivityRecording) {                          // check device for activity recording
			if (session == null) {
				session = ActivityRecording.createSession({          // set up recording session
					:name=>WatchUi.loadResource(Rez.Strings.co2),                              // set session name
					:sport=>ActivityRecording.SPORT_GENERIC,       // set sport type
					:subSport=>ActivityRecording.SUB_SPORT_GENERIC // set sub sport type
				});

			}
			if (!session.isRecording()) {
				session.start();                                     // call start session
			}
		}

        running = true;

        timer = new Timer.Timer();
        timer.start(method(:timerAction), SEC1, true);

        WatchUi.requestUpdate();
    }
    
    function stopActivity() {
        timer.stop();
        running = false;

		if (Toybox has :ActivityRecording) {
			if ((session != null) && session.isRecording()) {
				session.stop();                                      // stop the session
			}
		}
		
        WatchUi.requestUpdate();
    }
         
	function nextLap() {
        session.addLap();
    }
    
	function saveOnExit() {
		if (Toybox has :ActivityRecording) {
			if ((session != null) && !session.isRecording()) {
	    		session.save();                                      // save the session
				session = null;                                      // set session control variable to null
			}
		}
	}
    
}
