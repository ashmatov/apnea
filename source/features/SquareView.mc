import Toybox.WatchUi;
import Toybox.Application.Storage;
import Toybox.Time.Gregorian;
import Toybox.Timer;

class SquareView extends WatchUi.View {

	const ATTENTION1 = 10;
	const ATTENTION2 = 5;
	const SEC1 = 1000;
	
	hidden var steps;
	hidden var stepsKindNum;
	hidden var currentStep = 0;
	hidden var stepLabel = [WatchUi.loadResource(Rez.Strings.inhale), WatchUi.loadResource(Rez.Strings.hold), WatchUi.loadResource(Rez.Strings.exhale), WatchUi.loadResource(Rez.Strings.hold)];
	hidden var currentLevel = 0;
	    
    hidden var periodTimeDeffault = 0;
    hidden var periodTime = periodTimeDeffault;
    hidden var lapTime = periodTimeDeffault;

    hidden var running = false;

    hidden var timer = null;
    
    hidden var session = null;
    
    hidden var heartRate = 0;
    hidden var oxygenSaturation = 0;
    
    hidden var type = SQUARE;
    
    hidden var isSound;
	hidden var isVibration;
    
    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.Square(dc));
        Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE, Sensor.SENSOR_PULSE_OXIMETRY, Sensor.SENSOR_ONBOARD_HEARTRATE, Sensor.SENSOR_ONBOARD_PULSE_OXIMETRY]);
        Sensor.enableSensorEvents(method(:sensorAction));
                
        setStartPeriodTime();
    }

    function onShow() as Void {
		setStartPeriodTime();
  		
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
        
        stepsKindNum = [];
        if (inhale != 0) {
	    	stepsKindNum.add(0);
        }
        
        if (holdF != 0) {
	    	stepsKindNum.add(1);
        }
        
        if (exhale != 0) {
	    	stepsKindNum.add(2);
        }
        
        if (holdS != 0) {
	    	stepsKindNum.add(3);
        }
        
        steps = [];
  		for( var i = 0; i < circle; i++ ) {

	        if (inhale != 0) {
	        	steps.add(inhale);
	        }
	        
	        if (holdF != 0) {
				steps.add(holdF);
	        }
	        
	        if (exhale != 0) {
				steps.add(exhale);
	        }
	        
	        if (holdS != 0) {
				steps.add(holdS);
	        }

		}
		
  		for( var i = 0; i < steps.size(); i++ ) {
			periodTime = periodTime + steps[i];
		}
    }

    function onUpdate(dc as Dc) as Void {
        var view;

        view = View.findDrawableById(TextLabel);
        var id = 0;
        if (stepsKindNum.size() > 0) {
        	id = stepsKindNum[currentLevel];
        }
        Draw.drawMainTextLabel(view, stepLabel[id]);

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
		currentLevel = 0;
		currentStep = 0;
		periodTime = periodTimeDeffault;
		lapTime = periodTimeDeffault;
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
				
            if (steps.size() > 0 && lapTime == steps[currentStep] - ATTENTION1) {
				Alert.minus15(isSound, isVibration);
            }
            
            if (steps.size() > 0 && lapTime == steps[currentStep] - ATTENTION2) {
				Alert.minus5(isSound, isVibration);
            }
            
            if (steps.size() > 0 && lapTime >= steps[currentStep]) {
				Alert.next(isSound, isVibration);

				if (currentLevel < stepsKindNum.size() - 1) {
					currentLevel++;
				} else {
					currentLevel = 0;
				}
	            	
	            if (currentStep < steps.size() - 1) {
					lapTime = periodTimeDeffault;
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
    	if (steps.size() < 1) {
    		return;
    	}

		isSound = Storage.getValue(type + OPTION + SOUND);
		isVibration = Storage.getValue(type + OPTION + VIBE);

		if (Toybox has :ActivityRecording) {                          // check device for activity recording
			if (session == null) {
				session = ActivityRecording.createSession({          // set up recording session
					:name=>WatchUi.loadResource(Rez.Strings.square),                              // set session name
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