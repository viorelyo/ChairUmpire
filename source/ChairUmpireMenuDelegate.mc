import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class ChairUmpireMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if(item == :menu_stop_game) {
			WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
			var save_confirmation = new WatchUi.Confirmation(WatchUi.loadResource(Rez.Strings.save_confirmation));
			WatchUi.pushView(save_confirmation, new SaveConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);
		}
		else if(item == :menu_reset_game) {
		}
    }

}