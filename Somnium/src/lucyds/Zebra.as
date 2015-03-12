package lucyds {
	import org.flixel.FlxSprite;

	/**
	 * @author DXPCorp
	 */
	public class Zebra extends FlxSprite 
	{
		[Embed(source="/assets/img/zebre.png")]
		private var zebraImg:Class;
		public function Zebra(X : Number = 0, Y : Number = 0) 
		{
			super(X, Y, zebraImg);
//			this.blend = "lighten";
		}
	}
}
