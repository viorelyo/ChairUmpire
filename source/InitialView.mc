import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;

class InitialView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
    }
}


class InitialDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    private function startMatch() {
        Application.getApp().createMatch();

        var view = new GameScoreView();
        WatchUi.pushView(view, new ChairUmpireDelegate(view), WatchUi.SLIDE_IMMEDIATE);
    }

    function onMenu() as Boolean {
        return true;
    }

    function onSelect() as Boolean {
        startMatch();
        return true;
    }

    /*
    * Handling separately the KEY_ENTER (Start/Stop button on some devices, e.g. venu)
    */
    function onKey(evt as KeyEvent) as Boolean {
        var key = evt.getKey();

        if (key == KEY_ENTER) {
            startMatch();
        }

        return true;
    }
}
