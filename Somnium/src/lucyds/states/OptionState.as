package lucyds.states
{
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import flash.display.StageDisplayState;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class OptionState extends FlxState
	{
		private var pointeur 		: int 		= 1;
		private var controls		: FlxText;
		private var difficulty		: FlxText;
		private var back			: FlxText;
		private var screenMode		: FlxText;
		
		override public function create():void
		{
			var title:FlxText;
			title = new FlxText(0, 16, FlxG.width, "Somnium");
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			add(title);
			
			controls = new FlxText(0, FlxG.height / 2 - 192, FlxG.width, "Contrôles");
			controls.setFormat (null, 32, 0xFFFFFFFF, "center");
			add(controls);
			
			difficulty = new FlxText(0, FlxG.height / 2 - 128, FlxG.width, "Difficulté");
			difficulty.setFormat (null, 32, 0xFFFFFFFF, "center");
			add(difficulty);
			
			screenMode = new FlxText(0, FlxG.height / 2 - 64, FlxG.width, "Mode plein écran / BETA");
			screenMode.setFormat (null, 32, 0xFFFFFFFF, "center");
			add(screenMode);
			
			back = new FlxText(0, FlxG.height / 2, FlxG.width, "Retour");
			back.setFormat (null, 32, 0xFFFFFFFF, "center");
			add(back);
		}
		
		override public function update():void
		{
			super.update();
			trace(pointeur);
			
			if(FlxG.keys.justPressed("DOWN") || FlxG.keys.justPressed("LEFT"))
				pointeur++;
			
			if(FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("RIGHT"))
				pointeur--;
			
			if(pointeur >= 4)
				pointeur = 4;
			if(pointeur <= 1)
				pointeur = 1;
			
			if(pointeur == 1)
			{
				controls.color = 0xffff0000;
				difficulty.color = 0xffffffff;
				screenMode.color = 0xffffffff;
				back.color = 0xffffffff;
			}
			
			if(pointeur == 2)
			{
				controls.color = 0xffffffff;
				difficulty.color = 0xffff0000;
				screenMode.color = 0xffffffff;
				back.color = 0xffffffff;
			}
			
			if(pointeur == 3)
			{
				controls.color = 0xffffffff;
				difficulty.color = 0xffffffff;
				screenMode.color = 0xffff0000; 
				back.color = 0xffffffff;
			}
			
			if(pointeur == 4)
			{
				controls.color = 0xffffffff;
				difficulty.color = 0xffffffff;
				screenMode.color = 0xffffffff;
				back.color = 0xffff0000;
			}
			
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 1)
				FlxG.switchState(new ControlState());
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 2)
				FlxG.switchState(new DifficultyState());
				
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 3)
			{
				if(FlxG.stage.displayState == StageDisplayState.NORMAL)
					FlxG.stage.displayState = StageDisplayState.FULL_SCREEN;
				else
					FlxG.stage.displayState == StageDisplayState.NORMAL;
				
				FlxG.width = FlxG.stage.stageWidth / FlxCamera.defaultZoom;
            	FlxG.height = FlxG.stage.stageHeight / FlxCamera.defaultZoom;
				FlxG.resetCameras(new FlxCamera(0, 0, FlxG.width, FlxG.height));
			}
				
			if ((FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) && pointeur == 4)
				FlxG.switchState(new MenuState());
		}
	}
}