package lucyds.states
{
	import flash.system.fscommand;
	import flash.system.System;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import lucyds.PlayState;
	import org.flixel.FlxPoint;
	import lucyds.GameState;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	
	public class MenuState extends FlxState
	{
		private var pointeur 	: int 		= 1;
		private var menu		: FlxSprite	= new FlxSprite(0,0);
		
		[Embed(source="/assets/sounds/DemoMenu.mp3")] 	
		public var Music:Class;
		
		[Embed(source="/assets/img/menu/Menu1.png")] 	
		public var continuer:Class;
		[Embed(source="/assets/img/menu/Menu3.png")] 	
		public var labyrinthe:Class;
		[Embed(source="/assets/img/menu/Menu2.png")] 	
		public var nouveau:Class;
		[Embed(source="/assets/img/menu/Menu6.png")] 	
		public var quitter:Class;
		[Embed(source="/assets/img/menu/Menu4.png")] 	
		public var parametres:Class;
		[Embed(source="/assets/img/menu/Menu5.png")] 	
		public var aide:Class;
		
		public static var musicExist : Boolean = false;
		
		override public function create():void
		{
			
			if(musicExist == false)
			{
				musicExist = true;
				FlxG.playMusic(Music);
			}
			
			FlxG.volume = 0.5;
			
		}
		
		override public function update():void
		{
			super.update();
			
			if(FlxG.keys.justPressed("DOWN") || FlxG.keys.justPressed("LEFT"))
				pointeur++;
			
			if(FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("RIGHT"))
				pointeur--;
			
			if(pointeur >= 6)
				pointeur = 6;
			if(pointeur <= 1)
				pointeur = 1;
			
			switch (pointeur)
			{
				case 1:
				menu.loadGraphic(continuer, false, false, 800, 600);
				break;

				case 2:
				menu.loadGraphic(nouveau, false, false, 800, 600);
				break;
				
				case 3:
				menu.loadGraphic(labyrinthe, false, false, 800, 600);
				break;
				
				case 4:
				menu.loadGraphic(parametres, false, false, 800, 600);
				break;
				
				case 5:
				menu.loadGraphic(aide, false, false, 800, 600);
				break;
				
				case 6:
				menu.loadGraphic(quitter, false, false, 800, 600);
				break;
			}
			
			add(menu);
				
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 1)
			{
				FlxG.flash(0xffffffff, 1.5);
				FlxG.fade(0xFF000000, 1, switchGo);
			}
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 2)
			{

				FlxG.flash(0xffffffff, 1.5);
				FlxG.fade(0xFF000000, 1, switchGo);
			}
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 3)
			{
				FlxG.flash(0xffffffff, 1.5);
				FlxG.fade(0xFF000000, 1, switchGo);
			}
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 5)
				FlxG.switchState(new InstrState());
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 4)
				FlxG.switchState(new OptionState());
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 6)
				fscommand("quit");
		}
		
		private function switchGo () : void
		{
			FlxG.music.fadeOut(1);
			var gameSave : FlxSave = new FlxSave();
			gameSave.bind("myStorySave");
			
			if(gameSave.data.notNew != true)
			{
				gameSave.data.roomChoosed = "ChambreRosa";
				gameSave.data.luX = gameSave.data.luY = 6;
			}
			
			if(pointeur == 1)
				FlxG.switchState(new GameState(gameSave.data.roomChoosed, new FlxPoint(gameSave.data.luX,gameSave.data.luY)));
			if(pointeur == 2)
			{
				gameSave.data.notNew = false;
				FlxG.switchState(new GameState("ChambreRosa", new FlxPoint(6,6)));
			}
			if(pointeur == 3)
				FlxG.switchState(new PlayState("StandAlone", new FlxPoint(5,4), "ChambreRosa"));
		}
	}
}