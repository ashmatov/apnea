import Toybox.WatchUi;
import Toybox.Application.Storage;

class TestHistoryView extends WatchUi.View {

	const ROWSMAX = 4;
	const ROWSFIRST = 1;
	const ROWSOTHER = 3;
	const PIXMAXXDESCENT2 = 180;
	const PIXMAXYDESCENT2 = 180;
	
	hidden var myTextArea;
	hidden var running = false;
	hidden var first = 1;
	hidden var lastCounter = 0;
	
    function initialize() {
        View.initialize();
    }
    
    function onShow() as Void {
        var data = "";
        
        var counter = Storage.getValue(HISTORY_CURSOR);
        
        if(counter == null) {
			data = "no data";
  		} else {
  		  	lastCounter = counter;
  		  	if (counter > ROWSMAX) {
  		  		if (first + ROWSOTHER > counter) {
					first = counter - ROWSOTHER;	
  		  		}
  				lastCounter = first + ROWSOTHER;
  			} else {
  				first = ROWSFIRST;
  			}

			counter = first;
			while (counter <= lastCounter) {
   			 	var duration = Storage.getValue(DURATION + counter.format("%02d"));
   			 	var date = Storage.getValue(TIME + counter.format("%02d"));
   			 	var heart = Storage.getValue(HEARTRATE + counter.format("%02d"));
   			 	if (heart == null) {
   			 		heart = "--";
   			 	}
   			 	var o2 = Storage.getValue(OXYGEN + counter.format("%02d"));
   			 	if (o2 == null) {
   			 		o2 = "--";
   			 	}

   			 	data = data + counter.format("%02d") + " " + date + "\n" + "- t: " + TimeFormat.toShort(duration) + " hr: " + heart + " O2: " + o2 + "%\n";
    			counter++;
			}
  		}
        
        myTextArea = new WatchUi.TextArea({
            :text=>data,
            :color=>Graphics.COLOR_WHITE,
            :font=>[Graphics.FONT_XTINY],
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER,
            :width=>PIXMAXXDESCENT2,
            :height=>PIXMAXYDESCENT2
        });

    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        myTextArea.draw(dc);
    }
    
    function isRunning() {
        return running;
    }
     
    function down() {
        first++;
        onShow();
        WatchUi.requestUpdate();
    } 
         
    function up() {
    	if (first == ROWSFIRST) {
    		return;
    	}
    	
        first--;
        onShow();
        WatchUi.requestUpdate();
    }

}