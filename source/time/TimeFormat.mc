const SECMAX = 86400;
    
class TimeFormat {

    function toShort(number) {
        var string = "00:00";
        
        if (number > 3600 || number == 0) {
        	return string;
        }
        
        var minutes = number / 60;
        var seconds = number % 60;

        return Lang.format(
		    "$1$:$2$",
		    [minutes.format("%02d"), seconds.format("%02d")]
		);
    }
       
    function toFull(number) {
        var string = "00:00:00";
        
        if (number > SECMAX || number == 0) {
        	return string;
        }
        
        var hours = number / 3600;
        number = number % 3600;
        var minutes = number / 60;
        var seconds = number % 60;
        
        return Lang.format(
		    "$1$:$2$:$3$",
		    [hours.format("%02d"), minutes.format("%02d"), seconds.format("%02d")]
		);
    }
    
}
