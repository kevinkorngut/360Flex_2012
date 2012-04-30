/**
 * Date: 4/27/12
 * Time: 10:46 AM
 */
package renderers {
    import flash.display.GradientType;
    import flash.geom.Matrix;

    import spark.components.IconItemRenderer;
    import spark.core.IGraphicElement;

    public class TransparentIconItemRenderer extends IconItemRenderer{

        protected const BAR_WIDTH:Number = 13;

        public function TransparentIconItemRenderer() {
            super();
            alpha = .5;
        }

        override protected function createIconDisplay():void
        {
            super.createIconDisplay();
            iconDisplay.smooth=true;
        }

        override protected function drawBackground(unscaledWidth:Number,
                                          unscaledHeight:Number):void
        {
            //copied from LabelItemRenderer
            //set alpha to .5 when drawing background and removed setting of opaqueBackground for transparency purposes

            // figure out backgroundColor
            var backgroundColor:*;
            var downColor:* = getStyle("downColor");
            var drawBackground:Boolean = true;

            if (down && downColor !== undefined)
            {
                backgroundColor = downColor;
            }
            else if (selected)
            {
                backgroundColor = getStyle("selectionColor");
            }
            else if (hovered)
            {
                backgroundColor = getStyle("rollOverColor");
            }
            else if (showsCaret)
            {
                backgroundColor = getStyle("selectionColor");
            }
            else
            {
                var alternatingColors:Array;
                var alternatingColorsStyle:Object = getStyle("alternatingItemColors");

                if (alternatingColorsStyle)
                    alternatingColors = (alternatingColorsStyle is Array) ? (alternatingColorsStyle as Array) : [alternatingColorsStyle];

                if (alternatingColors && alternatingColors.length > 0)
                {
                    // translate these colors into uints
                    styleManager.getColorNames(alternatingColors);

                    backgroundColor = alternatingColors[itemIndex % alternatingColors.length];
                }
                else
                {
                    // don't draw background if it is the contentBackgroundColor. The
                    // list skin handles the background drawing for us.
                    drawBackground = false;
                }

            }

            // draw backgroundColor
            // the reason why we draw it in the case of drawBackground == 0 is for
            // mouse hit testing purposes
            graphics.beginFill(backgroundColor,.0);
            graphics.lineStyle();
            graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
            graphics.endFill();

            // Selected and down states have a gradient overlay as well
            // as different separators colors/alphas
            if (selected || down)
            {
                var colors:Array = [0x000000, 0x000000 ];
                var alphas:Array = [.2,.1];
                var ratios:Array = [0, 255];
                var matrix:Matrix = new Matrix();

                // gradient overlay
                matrix.createGradientBox(unscaledWidth, unscaledHeight, Math.PI / 2, 0, 0 );
                graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
                graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
                graphics.endFill();
            }

            // Draw the separator for the item renderer
            drawBorder(unscaledWidth, unscaledHeight);

        }
    }
}
