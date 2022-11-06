
enum Player {
    PLAYER_1 = 1,
    PLAYER_2 = 2
}

class GameScore {
    public var point;
    public var hasAdvantage;

    public function initialize(_point, _hasAdvantage) {
        point = _point;
        hasAdvantage = _hasAdvantage;
    }
}

class InternalGameScore {
    var player1ScoreIndex;
    var hasPlayer1Advantage;

    var player2ScoreIndex;
    var hasPlayer2Advantage;

    function initialize() {
        player1ScoreIndex = 0;
        hasPlayer1Advantage = false;

        player2ScoreIndex = 0;
        hasPlayer2Advantage = false;
    }
}

class Game {
    static const AVAILABLE_POINTS = [0, 15, 30, 40];

    private var score as InternalGameScore;

    function initialize() {
        reset();
    }

    function reset() {
        score = new InternalGameScore();
    }

    function getScore() {
        var score1 = new GameScore(AVAILABLE_POINTS[score.player1ScoreIndex], score.hasPlayer1Advantage);
        var score2 = new GameScore(AVAILABLE_POINTS[score.player2ScoreIndex], score.hasPlayer2Advantage);

        return [ score1, score2 ];
    }

    function getScoreSnapshot() {
        var copy = new InternalGameScore();
        copy.player1ScoreIndex = score.player1ScoreIndex;
        copy.hasPlayer1Advantage = score.hasPlayer1Advantage;
        copy.player2ScoreIndex = score.player2ScoreIndex;
        copy.hasPlayer2Advantage = score.hasPlayer2Advantage;

        return copy;
    }

    function setScoreFromSnapshot(scoreSnapshot as InternalGameScore) {
        score.player1ScoreIndex = scoreSnapshot.player1ScoreIndex;
        score.hasPlayer1Advantage = scoreSnapshot.hasPlayer1Advantage;
        score.player2ScoreIndex = scoreSnapshot.player2ScoreIndex;
        score.hasPlayer2Advantage = scoreSnapshot.hasPlayer2Advantage;
    }

    function isEnded() {
        if (isDeuce()) {
            return false;
        }

        return (score.player1ScoreIndex > 3) || (score.player2ScoreIndex > 3);
    }

    function isNew() {
        return (score.player1ScoreIndex == 0) && (score.player2ScoreIndex == 0);
    }

    function isDeuce() {
        return (score.player1ScoreIndex == 3) && (score.player2ScoreIndex == 3);
    }

    function markScore(player) {
        if (player == PLAYER_1) {
            if (isDeuce()) {
                if (score.hasPlayer1Advantage) {
                    score.player1ScoreIndex++;
                }
                else if (score.hasPlayer2Advantage) {
                    score.hasPlayer2Advantage = false;
                }
                else {
                    score.hasPlayer1Advantage = true;
                }

                return;
            }

            score.player1ScoreIndex++;
        }
        else if (player == PLAYER_2) {
            if (isDeuce()) {
                if (score.hasPlayer2Advantage) {
                    score.player2ScoreIndex++;
                }
                else if (score.hasPlayer1Advantage) {
                    score.hasPlayer1Advantage = false;
                }
                else {
                    score.hasPlayer2Advantage = true;
                }
                return;
            }

            score.player2ScoreIndex++;
        }
    }
}

class InternalMatchScoreSnapshot {
    var player1Score as Number;
    var player2Score as Number;

    var gameScore as InternalGameScore;

    function initialize(_player1Score, _player2Score, _gameScore) {
        player1Score = _player1Score;
        player2Score = _player2Score;
        gameScore = _gameScore;
    }
}

class Match {

    private var isStarted;

    private var player1Score;
    private var player2Score;

    private var history;

    private var game;

    private var matchActivity;

    function initialize() {
        matchActivity = new MatchActivity();

        reset();
    }

    function reset() {
        history = new DoublyLinkedList();

        game = new Game();

        player1Score = 0;
        player2Score = 0;
    }

    function getGameScore() {
        return game.getScore();
    }

    function getMatchScore() {
        return [ player1Score, player2Score ];
    }

    function score(player) {
        recordHistory();
        
        game.markScore(player);

        if (!game.isEnded()) {
            return;
        }

        game.reset();

        if (player == PLAYER_1) {
            player1Score++;
        }
        else if (player == PLAYER_2) {
            player2Score++;
        }
    }

    function recordHistory() {
        // Limited history size
        if (history.getSize() == 10) {
            history.popFront();
        }

        var snapshot = new InternalMatchScoreSnapshot(player1Score, player2Score, game.getScoreSnapshot());
        history.pushBack(snapshot);
    }

    function undo() {
        if (history.getSize() == 0) {
            return;
        }

        var prevSnapshot as InternalMatchScoreSnapshot = history.popBack();

        player1Score = prevSnapshot.player1Score;
        player2Score = prevSnapshot.player2Score;
        game.setScoreFromSnapshot(prevSnapshot.gameScore);
    }

    function stop() {
        matchActivity.setScore(player1Score, player2Score);
        matchActivity.stop();
    }

    function saveActivity() {
        matchActivity.save();
    }

    function discardActivity() {
        matchActivity.discard();
    }

    function getActivityDuration() {
        return matchActivity.getDuration();
    }
}