import Toybox.Graphics;
import Toybox.WatchUi;

class ChairUmpireView extends WatchUi.View {

    // UI attributes
    private var deviceHeight;
    private var deviceWidth;

    private var yTop;
    private var yBottom;
    private var yMiddle;

    private var xScore;
    private var yScore1;
    private var yScore2;

    // Game attributes
    private var match;

    function initialize() {
        View.initialize();

        initUI();

        match = new Match();
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

    // Load your resources here
    // function onLayout(dc as Dc) as Void {
    //     setLayout(Rez.Layouts.MainLayout(dc));
    // }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        drawGameScore(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

        
    function drawGameScore(dc) as Void {
        // TODO refactor the line
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(0, yMiddle, deviceWidth, yMiddle);

        // TODO
        // System.println(match.getMatchScore()[0]);
        // System.println(match.getMatchScore()[1]);

        var crtScore = match.getGameScore();
        var player1Score = crtScore[0];
        var player2Score = crtScore[1];

        UIHelpers.drawScoreText(dc, xScore, yScore1, player1Score, 10);
        UIHelpers.drawScoreText(dc, xScore, yScore2, player2Score, 10);
    }


    // Game methods
    function score(player) as Void {
        match.score(player);

        WatchUi.requestUpdate();
    }

    function undo() as Void {
        match.undo();

        WatchUi.requestUpdate();
    }
}
