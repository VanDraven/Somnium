package lucyds.states
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class OptionState extends FlxState
	{
		private var pointeur 		: int 		= 1;
		private var controls		: FlxText;
		private var difficulty		: FlxText;
		private var back			: FlxText;
		
		override public function create():void
		{
			var title:FlxText;
			title = new FlxText(0, 16, FlxG.width, "Somnium Demo");
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			add(title);
			
			controls = new FlxText(0, FlxG.height / 2 - 192, FlxG.width, "Controls");
			controls.setFormat (null, 32, 0xFFFFFFFF, "center");
			add(controls);
			
			difficulty = new FlxText(0, FlxG.height / 2 - 128, FlxG.width, "Difficulty");
			difficulty.setFormat (null, 32, 0xFFFFFFFF, "center");
			add(difficulty);
			
			back = new FlxText(0, FlxG.height / 2 - 64, FlxG.width, "Back");
			back.setFormat (null, 32, 0xFFFFFFFF, "center");
			add(back);
		}
		
		override public function update():void
		{
			super.update();
			
			if(FlxG.keys.justPressed("DOWN") || FlxG.keys.justPressed("LEFT"))
				pointeur++;
			
			if(FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("RIGHT"))
				pointeur--;
			
			if(pointeur >= 3)
				pointeur = 3;
			if(pointeur <= 1)
				pointeur = 1;
			
			if(pointeur == 1)
			{
				controls.color = 0xffff0000;
				difficulty.color = 0xffffffff;
				back.color = 0xffffffff;
			}
			
			if(pointeur == 2)
			{
				controls.color = 0xffffffff;
				difficulty.color = 0xffff0000;
				back.color = 0xffffffff;
			}
			
			if(pointeur == 3)
			{
				controls.color = 0xffffffff;
				difficulty.color = 0xffffffff;
				back.color = 0xffff0000;
			}
			
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 1)
				FlxG.switchState(new ControlState());
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 2)
				FlxG.switchState(new DifficultyState());
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 3)
				FlxG.switchState(new MenuState());
		}
	}
}