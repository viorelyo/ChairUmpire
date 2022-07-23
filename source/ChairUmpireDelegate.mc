import Toybox.Lang;
import Toybox.WatchUi;

class ChairUmpireDelegate extends WatchUi.BehaviorDelegate {

    private var relatedView;

    function initialize(view) {
        BehaviorDelegate.initialize();

        relatedView = view;
    }

    function onMenu() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new ChairUmpireMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onBack() {
        relatedView.undo();
        return true;
    }

    function onSelect() {
        // TODO
        // WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    function onNextPage() {
        relatedView.score(PLAYER_1);
        return true;
    }

    function onPreviousPage() {
        relatedView.score(PLAYER_2);
        return true;
    }
}