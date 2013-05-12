package lucyds.states
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class InstrState extends FlxState
	{
		override public function create():void
		{
			var instructions:FlxText;
			instructions = new FlxText(FlxG.width/4, 250, FlxG.width/2,
				"Go to the red tile. \n" + 
				"Always follows the darkest path to get there. \n" +
				"The ghosts are following your light. Turn it off with shift. \n" +
				"At the top right corner of the screen is your stamina bar, \nwhen it is full you would be able to jump 5 times using the space bar.");
			instructions.setFormat (null, 12, 0xFFFFFFFF, "center");
			add(instructions);
			
			var instructions2:FlxText;
			instructions2 = new FlxText(0, FlxG.height - 32, FlxG.width, "Press start to go back");
			instructions2.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(instructions2);
		}
		
		override public function update():void
		{
			super.update();
			
			if(FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE"))
				FlxG.switchState(new MenuState());
		}
	}
}