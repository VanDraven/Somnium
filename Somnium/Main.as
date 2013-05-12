package {
	import lucyds.states.MenuState;

	import org.flixel.FlxGame;
	
	[SWF (width="800", height="600", frameRate="60")]
	
	public class Main extends FlxGame
	{
		public function Main():void
		{
			super(800, 600, MenuState, 1);
		}
	}
}