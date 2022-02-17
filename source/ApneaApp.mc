import Toybox.Application;
import Toybox.System;
import Toybox.Lang;
import Toybox.Application.Storage;
import Toybox.Application.Properties;

const TEST = "test";
const CO2 = "co2";
const O2 = "o2";
const MANUAL = "manual";
const SQUARE = "square";
const HISTORY = "test_history";

const TextLabel = "TextLabel";
const HeartrateLabel = "HeartrateLabel";
const OxygenSaturationLabel = "OxygenSaturationLabel";
const TotalTimeLabel = "TotalTimeLabel";
const GoalTimeLabel = "GoalTimeLabel";
const CurrentLapLabel = "CurrentLapLabel";

const OPTION = "o";
const SOUND = "s";
const VIBE = "v";
const FIRST = "1";
const SECOND = "2";
const THIRD = "3";
const INHALE = "inhale";
const EXHALE = "exhale";
const HOLD = "hold";
const HOLDFIRST = "holdF";
const HOLDSECOND = "holdS";

const HISTORY_FIRST_RECORD = "d01";
const HISTORY_CURSOR = "hist_cur";
const TIME = "t";
const DURATION = "d";
const HEARTRATE = "hr";
const OXYGEN = "o2";

const YES = "y";
const NO = "n";

const CLEAR_ALL_ROWS = "clear_rows";
const DELETE_ROW = "delete_row";

const CIRCLE = "circle";

class ApneaApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new ApneaView(), new ApneaDelegate() ] as Array<Views or InputDelegates>;
    }

}

function getApp() as ApneaApp {
    return Application.getApp() as ApneaApp;
}