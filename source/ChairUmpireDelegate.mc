import Toybox.Lang;
import Toybox.WatchUi;

class ChairUmpireDelegate extends WatchUi.BehaviorDelegate {

    private var relatedView;

    function initialize(view) {
        BehaviorDelegate.initialize();

        relatedView = view;
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new ChairUmpireMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onBack() {
        System.println("Back");
        relatedView.undo();
        // WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    function onSelect() {
        System.println("Select");
        return true;
    }

    function onNextPage() {
        System.println("Next");
        relatedView.score(PLAYER_1);
        return true;
    }

    function onPreviousPage() {
        System.println("Prev");
        relatedView.score(PLAYER_2);
        return true;
    }
}