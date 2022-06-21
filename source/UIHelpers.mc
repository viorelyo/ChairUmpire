using Toybox.Graphics;

module UIHelpers {
    function drawScoreText(dc, x, y, text, padding) {
        // var radius = 5;
        // var dimensions = dc.getTextDimensions(text, font);

        // dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_GREEN);
        // dc.fillRoundedRectangle(x - dimensions[0] / 2 - padding, y - dimensions[1] / 2, dimensions[0] + 2 * padding, dimensions[1], radius);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        // TODO show with FONT_NUMBER_MEDIUM - needs application score remaster
        // dc.drawText(x, y, Graphics.FONT_NUMBER_MEDIUM, text, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(x, y, Graphics.FONT_SYSTEM_LARGE, text, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}