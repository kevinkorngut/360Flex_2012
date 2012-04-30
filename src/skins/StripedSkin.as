package skins
{
    import flash.display.GradientType;

    import spark.skins.mobile.SkinnableContainerSkin;

    public class StripedSkin extends SkinnableContainerSkin
    {

        protected const BAR_WIDTH:Number = 13;

        public function StripedSkin()
        {
            super();
        }

        override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.drawBackground(unscaledWidth, unscaledHeight);

            graphics.clear();

            var numRect:Number = unscaledWidth / BAR_WIDTH;

            graphics.beginFill(0xd4cdba, 1);				//dark	d4cdba		//light dbd5c5
            graphics.drawRect( 0, 0, unscaledWidth, unscaledHeight);

            graphics.beginFill(0xdbd5c5, 1);				//dark	d4cdba		//light dbd5c5
            for (var index:int=0; index < numRect; index++)
            {
                graphics.drawRect( (index+1)*BAR_WIDTH, 0, BAR_WIDTH, unscaledHeight);
                index++;
            }

            graphics.beginGradientFill(GradientType.LINEAR, [0xffffff], [.6], [128]);
            graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
            graphics.endFill()
        }
    }
}