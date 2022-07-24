using Toybox.Graphics;
using Toybox.System;

module UIHelpers {
    function drawGameScoreText(dc, x, y, player, score) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, Graphics.FONT_NUMBER_MEDIUM, score.point.toString(), Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);

        var yAdvantage = 0;
        if (player == PLAYER_1) {
            yAdvantage = y + Graphics.getFontHeight(Graphics.FONT_SMALL);
        } 
        else if (player == PLAYER_2) {
            yAdvantage = y - Graphics.getFontHeight(Graphics.FONT_SMALL);
        }

        if (score.hasAdvantage) {
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
            dc.drawText(x, yAdvantage, Graphics.FONT_SMALL, "A", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }

    function drawSetScoreText(dc, x, y, player, score) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, Graphics.FONT_NUMBER_MEDIUM, score.toString(), Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}