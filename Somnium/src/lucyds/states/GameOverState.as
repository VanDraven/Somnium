package lucyds.states
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import lucyds.PlayState;

	public class GameOverState extends FlxState
	{
			override public function create():void
			{
				var title:FlxText;
				title = new FlxText(0, 16, FlxG.width, "Vous avez perdu !");
				title.setFormat (null, 64, 0xFFFFFFFF, "center");
				add(title);
				
//				var yourSeed : FlxText;
//				yourSeed = new FlxText(0, FlxG.height / 2 - 128, FlxG.width, "Your Seed : " + FlxG.globalSeed.toString());
//				yourSeed.setFormat (null, 32, 0xFFFFFFFF, "center");
//				add(yourSeed);
				
				var best:FlxText;				
				best = new FlxText(0, FlxG.height / 2 - 64, FlxG.width, "Meilleur score : " + PlayState.best.toString());
				best.setFormat (null, 32, 0xFFFFFFFF, "center");
				add(best);
				
				var instructions:FlxText;
				instructions = new FlxText(0, FlxG.height - 32, FlxG.width, "Appuyez sur espace pour recommencer			Appuyez sur esc pour revenir au menu principal");
				instructions.setFormat (null, 8, 0xFFFFFFFF, "center");
				add(instructions);		
			}			
				
			override public function update():void
			{
				super.update();
					
				if (FlxG.keys.justPressed("SPACE"))
				{
					PlayState.sautCompte = 2;
					PlayState.zebraPwnd = false;
					FlxG.flash(0xffffffff, 1.5);
					FlxG.fade(0xFF000000, 1, switchGo);
				}
				if (FlxG.keys.justPressed("ESCAPE"))
				{
					PlayState.sautCompte = 2;
					PlayState.zebraPwnd = false;
					FlxG.flash(0xffffffff, 1.5);
					FlxG.fade(0xFF000000, 1, switchGoMenu);
				}
			}
				
			private function switchGo () : void
				{
					FlxG.switchState(new PlayState("StandAlone", new FlxPoint(5,4), "ChambreRosa"));
				}
				
			private function switchGoMenu () : void
				{
					MenuState.musicExist = false;
					FlxG.switchState(new MenuState);
				}
	}
}