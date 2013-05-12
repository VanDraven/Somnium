package lucyds.states
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import lucyds.Lucie;
	import lucyds.PlayState;

	public class GameOverState extends FlxState
	{
			override public function create():void
			{
				var title:FlxText;
				title = new FlxText(0, 16, FlxG.width, "Game Over");
				title.setFormat (null, 64, 0xFFFFFFFF, "center");
				add(title);
				
				var yourSeed : FlxText;
				yourSeed = new FlxText(0, FlxG.height / 2 - 128, FlxG.width, "Your Seed : " + FlxG.globalSeed.toString());
				yourSeed.setFormat (null, 32, 0xFFFFFFFF, "center");
				add(yourSeed);
				
				var score:FlxText;
				var scoreInt : int = (0);
				score = new FlxText(0, FlxG.height / 2 - 64, FlxG.width, "Score : " + scoreInt.toString());
				score.setFormat (null, 32, 0xFFFFFFFF, "center");
				add(score);
				
				var instructions:FlxText;
				instructions = new FlxText(0, FlxG.height - 32, FlxG.width, "Press Space To Try Again");
				instructions.setFormat (null, 8, 0xFFFFFFFF, "center");
				add(instructions);		
			}			
				
			override public function update():void
			{
				super.update();
					
				if (FlxG.keys.justPressed("SPACE"))
				{
					Lucie.sautCompte = 2;
					FlxG.flash(0xffffffff, 1.5);
					FlxG.fade(0xFF000000, 1, switchGo);
				}
			}
				
			private function switchGo () : void
				{
					FlxG.switchState(new PlayState);
				}
	}
}