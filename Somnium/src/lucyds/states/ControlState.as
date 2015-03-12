package lucyds.states
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class ControlState extends FlxState
	{
		override public function create():void
		{
			var instructions:FlxText;
			instructions = new FlxText(FlxG.width/4, 250, FlxG.width/2,
				"z q s d ou haut bas gauche droite pour se déplacer\n" + 
				"Shift pour allumer et éteindre la lanterne de Rosa \n" +
				"Espace pour executer une action (ouvrir une porte ou un coffre par exemple) ou sauter pendant une phase de labyrinthe. \n");
			instructions.setFormat (null, 12, 0xFFFFFFFF, "center");
			add(instructions);
			
			var instructions2:FlxText;
			instructions2 = new FlxText(0, FlxG.height - 32, FlxG.width, "Appuyer sur espace pour revenir");
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