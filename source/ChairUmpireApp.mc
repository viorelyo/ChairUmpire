import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class ChairUmpireApp extends Application.AppBase {

    private var match;

    private const NR_PAGES as Number = 3;
    private var pageIndicator;

    function initialize() {
        AppBase.initialize();

        pageIndicator = new PageIndicator(NR_PAGES, Graphics.COLOR_LT_GRAY, Graphics.COLOR_DK_GRAY, ALIGN_BOTTOM_CENTER, 3);
    }

    function getPageIndicator() as PageIndicator {
        return pageIndicator;
    }

    function getPagesNr() as Number {
        return NR_PAGES;
    }

    function createMatch() {
        match = new Match();
    }

    function getMatch() as Match {
        return match;
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new InitialView(), new InitialDelegate() ] as Array<Views or InputDelegates>;
    }

}

function getApp() as ChairUmpireApp {
    return Application.getApp() as ChairUmpireApp;
}