import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class ChairUmpireApp extends Application.AppBase {

    private var match;

    function initialize() {
        AppBase.initialize();

        match = new Match();
    }

    function getMatch() {
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
        var view = new ChairUmpireView();
        return [ view, new ChairUmpireDelegate(view) ] as Array<Views or InputDelegates>;
    }

}

function getApp() as ChairUmpireApp {
    return Application.getApp() as ChairUmpireApp;
}