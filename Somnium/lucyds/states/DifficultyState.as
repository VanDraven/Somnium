package lucyds.states {
	
	import org.flixel.FlxG;
	import org.flixel.FlxSave;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class DifficultyState extends FlxState
	{
		private var pointeur 	: int 		= 1;
		private var no 			: FlxText;
		private var yes			: FlxText;
		
		override public function create():void
		{
			var resetTxt : FlxText= new FlxText(0, FlxG.height / 2 - 192, FlxG.width, "Reset the difficulty level to default?");
			resetTxt.setFormat (null, 32, 0xFFFFFFFF, "center");
			add(resetTxt);
			
			no = new FlxText(0, FlxG.height / 2 - 128, FlxG.width, "No");
			no.setFormat (null, 32, 0xFFFFFFFF, "center");
			add(no);			
			
			yes = new FlxText(0, FlxG.height / 2 - 64, FlxG.width, "Yes");
			yes.setFormat (null, 32, 0xFFFFFFFF, "center");
			add(yes);
		}
		
		override public function update():void
		{
			super.update();
			
			if(FlxG.keys.justPressed("DOWN") || FlxG.keys.justPressed("LEFT"))
				pointeur++;
			
			if(FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("RIGHT"))
				pointeur--;
			
			if(pointeur >= 2)
				pointeur = 2;
			if(pointeur <= 1)
				pointeur = 1;
				
			switch (pointeur)
			{
				case 1:
				no.color = 0xffff0000;
				yes.color = 0xffffffff;
				break;

				case 2:
				no.color = 0xffffffff;
				yes.color = 0xffff0000;
				break;
			}
			
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 2)
			{
				var gameSave : FlxSave = new FlxSave;
				gameSave.bind("mySave");
				gameSave.data.levelPlayed = false;
				
				FlxG.flash(0xffffffff, 1.5);
				FlxG.fade(0xFF000000, 1, switchGo);
			}
			
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 1)
				FlxG.switchState(new MenuState());
		}
		
		private function switchGo () : void
		{
			FlxG.switchState(new MenuState());
		}
	}
}