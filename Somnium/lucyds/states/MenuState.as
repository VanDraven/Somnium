package lucyds.states
{
	import lucyds.PlayState;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	public class MenuState extends FlxState
	{
		private var pointeur 		: int 		= 1;
		private var play			: FlxText;
		private var instructions	: FlxText;
		private var options			: FlxText;
		
		override public function create():void
		{
			var title:FlxText;
			title = new FlxText(0, 16, FlxG.width, "Somnium Demo");
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			add(title);
			
			play = new FlxText(0, FlxG.height / 2 - 192, FlxG.width, "Play");
			play.setFormat (null, 32, 0xFFFFFFFF, "center");
			add(play);
			
			instructions = new FlxText(0, FlxG.height / 2 - 128, FlxG.width, "How to play");
			instructions.setFormat (null, 32, 0xFFFFFFFF, "center");
			add(instructions);
			
			options = new FlxText(0, FlxG.height / 2 - 64, FlxG.width, "Options");
			options.setFormat (null, 32, 0xFFFFFFFF, "center");
			add(options);
			
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
			
			switch (pointeur)
			{
				case 1:
				play.color = 0xffff0000;
				instructions.color = 0xffffffff;
				options.color = 0xffffffff;
				break;

				case 2:
				play.color = 0xffffffff;
				instructions.color = 0xffff0000;
				options.color = 0xffffffff;
				break;
				
				case 3:
				play.color = 0xffffffff;
				instructions.color = 0xffffffff;
				options.color = 0xffff0000;
				break;
			}
				
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 1)
			{
				FlxG.flash(0xffffffff, 1.5);
				FlxG.fade(0xFF000000, 1, switchGo);
			}
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 2)
				FlxG.switchState(new InstrState());
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 3)
				FlxG.switchState(new OptionState());		
		}
		
		private function switchGo () : void
		{
			FlxG.switchState(new PlayState);
		}
	}
}