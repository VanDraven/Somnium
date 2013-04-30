package lucyds {
	import org.flixel.FlxSprite;

		[Embed(source="assets/img/obama.png")]
		private var Peluche : Class;
		
	/**
	 * @author DXPCorp
	 */
	public class Peluche extends FlxSprite 
	{
		public function Peluche() : void
		{
			super();
			loadGraphic(Peluche, true, true, 32, 32, true);
			
		}
	}
}
