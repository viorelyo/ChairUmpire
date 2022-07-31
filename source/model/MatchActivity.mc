using Toybox.Activity;
using Toybox.WatchUi;
using Toybox.Time;

class MatchActivity {
    const TOTAL_SCORE_PLAYER_1_FIELD_ID = 0;
	const TOTAL_SCORE_PLAYER_2_FIELD_ID = 1;


    private var isSessionStarted;
    private var session;
    private var sessionFieldScorePlayer1;
    private var sessionFieldScorePlayer2;

    function initialize() {
        session = ActivityRecording.createSession({:sport => ActivityRecording.SPORT_TENNIS, :subSport => ActivityRecording.SUB_SPORT_MATCH, :name => WatchUi.loadResource(Rez.Strings.fit_activity_name)});
        sessionFieldScorePlayer1 = session.createField("score_player_1", TOTAL_SCORE_PLAYER_1_FIELD_ID, FitContributor.DATA_TYPE_UINT8, {:mesgType => FitContributor.MESG_TYPE_SESSION, :units => WatchUi.loadResource(Rez.Strings.fit_score_unit_label)});
		sessionFieldScorePlayer2 = session.createField("score_player_2", TOTAL_SCORE_PLAYER_2_FIELD_ID, FitContributor.DATA_TYPE_UINT8, {:mesgType => FitContributor.MESG_TYPE_SESSION, :units => WatchUi.loadResource(Rez.Strings.fit_score_unit_label)});
        session.start();

        isSessionStarted = true;
    }

    function stop() {
        session.stop();

        isSessionStarted = false;
    }

    function save() {
        if (isSessionStarted) {
            stop();
        }
        session.save();
        session = null;
    }

    function discard() {
        if (isSessionStarted) {
            stop();
        }
        session.discard();
        session = null;
    }

    function setScore(player1Score, player2Score) {
        sessionFieldScorePlayer1.setData(player1Score);
        sessionFieldScorePlayer2.setData(player2Score);
    }

    function getDuration() {
		var time = Activity.getActivityInfo().elapsedTime;
		var seconds = time != null ? time / 1000 : 0;
		return new Time.Duration(seconds);
	}
}