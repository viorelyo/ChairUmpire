
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

class Game {
    static const AVAILABLE_POINTS = [0, 15, 30, 40];

    private var player1ScoreIndex;
    private var hasPlayer1Advantage;

    private var player2ScoreIndex;
    private var hasPlayer2Advantage;

    function initialize() {
        reset();
    }

    function reset() {
        player1ScoreIndex = 0;
        hasPlayer1Advantage = false;

        player2ScoreIndex = 0;
        hasPlayer2Advantage = false;
    }

    function getScore() {
        var score1 = new GameScore(AVAILABLE_POINTS[player1ScoreIndex], hasPlayer1Advantage);
        var score2 = new GameScore(AVAILABLE_POINTS[player2ScoreIndex], hasPlayer2Advantage);

        return [ score1, score2 ];
    }

    function isEnded() {
        if (isDeuce()) {
            return false;
        }

        return (player1ScoreIndex > 3) || (player2ScoreIndex > 3);
    }

    function isNew() {
        return (player1ScoreIndex == 0) && (player2ScoreIndex == 0);
    }

    function isDeuce() {
        return (player1ScoreIndex == 3) && (player2ScoreIndex == 3);
    }

    function score(player) {
        if (player == PLAYER_1) {
            if (isDeuce()) {
                if (hasPlayer1Advantage) {
                    player1ScoreIndex++;
                }
                else if (hasPlayer2Advantage) {
                    hasPlayer2Advantage = false;
                }
                else {
                    hasPlayer1Advantage = true;
                }

                return;
            }

            player1ScoreIndex++;
        }
        else if (player == PLAYER_2) {
            if (isDeuce()) {
                if (hasPlayer2Advantage) {
                    player2ScoreIndex++;
                }
                else if (hasPlayer1Advantage) {
                    hasPlayer1Advantage = false;
                }
                else {
                    hasPlayer2Advantage = true;
                }
                return;
            }

            player2ScoreIndex++;
        }
    }

    function undo(player) {
        // TODO handle deuce
        if (player == PLAYER_1) {
            if (isDeuce()) {
                if (hasPlayer1Advantage) {
                    hasPlayer1Advantage = false;
                }
                else if (hasPlayer2Advantage) {
                    hasPlayer2Advantage = false;
                }
                else {
                    player1ScoreIndex--;
                }

                return;
            }

            player1ScoreIndex--;
        }
        else if (player == PLAYER_2) {
            if (isDeuce()) {
                if (hasPlayer2Advantage) {
                    hasPlayer2Advantage = false;
                }
                else if (hasPlayer1Advantage) {
                    hasPlayer1Advantage = false;
                }
                else {
                    player2ScoreIndex--;
                }

                return;
            }

            player2ScoreIndex--;
        }
    }
}

class Match {
    private var player1Score;
    private var player2Score;

    private var history;

    private var game;

    function initialize() {
        reset();
    }

    function reset() {
        history = new List();

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
        history.push(player);    
        game.score(player);

        if (!game.isEnded()) {
            return;
        }

        game.reset();
        history.clear();

        if (player == PLAYER_1) {
            player1Score++;
        }
        else if (player == PLAYER_2) {
            player2Score++;
        }
    }

    function undo() {
        if (history.isEmpty()) {
            return;
        }

        var prevActionPlayer = history.pop();

        if (game.isNew()) {
            // TODO
            history.clear();
        }
        else {
            game.undo(prevActionPlayer);
        }
    }
}