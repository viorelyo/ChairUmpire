import Toybox.Graphics;
import Toybox.WatchUi;

class SetScoreView extends WatchUi.View {

    private const PAGE_INDEX as Number = 1;

    // UI attributes
    private var deviceHeight;
    private var deviceWidth;

    private var yTop;
    private var yBottom;
    private var yMiddle;

    private var xScore;
    private var yScore1;
    private var yScore2;

    function initialize() {
        View.initialize();

        initUI();
    }

    private function initUI() {
        var deviceSettings = System.getDeviceSettings();
        deviceHeight = deviceSettings.screenHeight;
        deviceWidth = deviceSettings.screenWidth;

        var marginHeight = deviceHeight * (deviceSettings.screenShape == System.SCREEN_SHAPE_RECTANGLE ? 0.04 : 0.09);
		var marginWidth = deviceWidth * (deviceSettings.screenShape == System.SCREEN_SHAPE_RECTANGLE ? 0.04 : 0.09);

        yTop = marginHeight;
        yBottom = deviceHeight - marginHeight;
        yMiddle = Utils.mean(yBottom, yTop);

        xScore = deviceWidth / 2f;

        yScore1 = Utils.mean(yBottom, yMiddle);
        yScore2 = Utils.mean(yMiddle, yTop);
    }

    function onShow() as Void {
    }

    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        var pageIndicator = Application.getApp().getPageIndicator();
        pageIndicator.draw(dc, PAGE_INDEX);

        drawGameScore(dc);
    }

    function onHide() as Void {
    }

        
    function drawGameScore(dc) as Void {
        var match = Application.getApp().getMatch();

        // TODO refactor the line
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(0, yMiddle, deviceWidth, yMiddle);

        var crtScore = match.getMatchScore();
        var player1Score = crtScore[0];
        var player2Score = crtScore[1];

        UIHelpers.drawSetScoreText(dc, xScore, yScore1, PLAYER_1, player1Score);
        UIHelpers.drawSetScoreText(dc, xScore, yScore2, PLAYER_2, player2Score);
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
