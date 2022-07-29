import Toybox.Lang;
import Toybox.WatchUi;

class ChairUmpireDelegate extends WatchUi.BehaviorDelegate {

    private var pageIndex as Number = 1;
    private var currentView;

    function initialize(view) {
        BehaviorDelegate.initialize();

        currentView = view;
    }

    function onMenu() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new ChairUmpireMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onSelect() {
        switchPage();
        // WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
    
    function onBack() as Boolean {
        return currentView.onBack();
    }


    function onNextPage() as Boolean {
        return currentView.onNextPage();
    }

    function onPreviousPage() as Boolean {
        return currentView.onPreviousPage();
    }

    private function switchPage() as Void {
        var nrOfPages = Application.getApp().getPagesNr();

        if (pageIndex == nrOfPages) {
            pageIndex = 1;
        } else {
            pageIndex++;
        }

        switchView();
    }

    private function switchView() as Void {
        if (pageIndex == 1) {
            currentView = new GameScoreView();
        } else {
            currentView = new SetScoreView();
        }
        // } else {
        //     newView = new UserProfileSectionThreeView();
        // }

        WatchUi.switchToView(currentView, self, WatchUi.SLIDE_IMMEDIATE);
    }
}