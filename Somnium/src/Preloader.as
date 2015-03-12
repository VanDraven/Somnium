package {
	 import flash.display.Shape;
	 import org.flixel.FlxG;
	 import flash.geom.Rectangle;
	 import flash.display.Sprite;
	 import org.flixel.system.*;
	 import flash.display.Bitmap;
	/**
	 * @author DXPCorp
	 */
	public class Preloader extends FlxPreloader
	{
		[Embed(source="assets/img/dxp.png")]
		private var dxpLogo : Class;
		
		public static var BG:Bitmap;
		public var rect:Rectangle;
		public var shape:Shape;
		
		public function Preloader():void
		{
			minDisplayTime = 10;
			className = "Main";
			super();
		}
		override protected function create():void {
			_buffer = new Sprite();
			addChild(_buffer);
			_buffer.width = stage.stageWidth;
			_buffer.height = stage.stageHeight;
			//ImgLogo = dxpLogo;
			BG = new dxpLogo();
			BG.x = 0;
			BG.y = 0;
			_buffer.addChild(BG);

			
			shape = new Shape();
			_buffer.addChild(shape);
			//_buffer.addChild(dxpLogo);
			rect = new Rectangle((FlxG.width / 2) - 50, FlxG.height / 2, 0, 10);
		}
		override protected function update(percent:Number):void {
			rect.width = percent;
			
			shape.graphics.beginFill(0xFFFFFF);
			shape.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			shape.graphics.endFill();
						trace("hello");
		}
	}
}