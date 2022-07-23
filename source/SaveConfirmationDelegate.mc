using Toybox.WatchUi;

class SaveConfirmationDelegate extends WatchUi.ConfirmationDelegate {

	function initialize() {
		ConfirmationDelegate.initialize();
	}

	function onResponse(value) {
		if(value == CONFIRM_YES) {
		}
		else {
		}

		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
		return true;
	}
}