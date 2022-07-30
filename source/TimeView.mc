using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Timer;
using Toybox.Time.Gregorian;

// TODO cleanup and refactor
class TimeView extends WatchUi.View {

    private const PAGE_INDEX as Number = 2;

    // UI attributes
    static const CLOCK_HEIGHT = Graphics.getFontHeight(Graphics.FONT_NUMBER_HOT);
    static const TIMER_HEIGHT = Graphics.getFontHeight(Graphics.FONT_SMALL);

    private var yMiddle;
    private var xMiddle;

    private var timer;

    function initialize() {
        View.initialize();

        timer = new Timer.Timer();

        initUI();
    }

    private function initUI() {
        var deviceSettings = System.getDeviceSettings();
        var deviceHeight = deviceSettings.screenHeight;
        var deviceWidth = deviceSettings.screenWidth;

        var marginHeight = deviceHeight * (deviceSettings.screenShape == System.SCREEN_SHAPE_RECTANGLE ? 0.04 : 0.09);
		var marginWidth = deviceWidth * (deviceSettings.screenShape == System.SCREEN_SHAPE_RECTANGLE ? 0.04 : 0.09);

        var yTop = marginHeight;
        var yBottom = deviceHeight - marginHeight;

        yMiddle = Utils.mean(yBottom, yTop);
        xMiddle = deviceWidth / 2f;
    }

    function onShow() as Void {
        timer.start(method(:onTimer), 1000, true);
    }

    function onHide() as Void {
        timer.stop();
    }

    function onTimer() {
		WatchUi.requestUpdate();
	}

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        var pageIndicator = Application.getApp().getPageIndicator();
        pageIndicator.draw(dc, PAGE_INDEX);

        drawTime(dc);
        drawActivityTimer(dc);
    }

    function drawTime(dc) {
        var now = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		var timeLabel = Lang.format("$1$:$2$", [now.hour.format("%02d"), now.min.format("%02d")]);

		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(xMiddle, yMiddle - CLOCK_HEIGHT * 0.5, Graphics.FONT_NUMBER_HOT, timeLabel, Graphics.TEXT_JUSTIFY_CENTER);
	}

    function drawActivityTimer(dc) {
        var match = Application.getApp().getMatch();

        var duration = match.getActivityDuration();

        var time = duration.value();
		var seconds = time % 60;
		var minutes = (time / 60) % 60;
		var hours = time / 3600;
		var matchDuration = Lang.format("$1$:$2$:$3$", [hours.format("%02d"), minutes.format("%02d"), seconds.format("%02d")]);

        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
		dc.drawText(xMiddle, yMiddle + TIMER_HEIGHT, Graphics.FONT_SMALL, matchDuration, Graphics.TEXT_JUSTIFY_CENTER);
	}

    // Delegate callbacks
    function onBack() as Boolean {
        return true;
    }

    function onNextPage() as Boolean {
        return true;
    }

    function onPreviousPage() as Boolean {
        return true;
    }
}
