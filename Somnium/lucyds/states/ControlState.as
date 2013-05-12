package lucyds.states
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	
	public class ControlState extends FlxState
	{
		override public function create():void
		{

		}
		
		override public function update():void
		{
			super.update();
			
			if(FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE"))
				FlxG.switchState(new MenuState());
		}
	}
}