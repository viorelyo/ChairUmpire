using Toybox.WatchUi;

class SaveConfirmationDelegate extends WatchUi.ConfirmationDelegate {

	function initialize() {
		ConfirmationDelegate.initialize();
	}

	function onResponse(value) {
		var match = Application.getApp().getMatch();

		if(value == CONFIRM_YES) {
			match.saveActivity();
		}
		else {
			match.discardActivity();
		}

		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
		return true;
	}
}