package lucyds {
	import lucyds.states.GameOverState;
	/**
	 * @author DXPCorp
	 */
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import flash.display.MovieClip;
	import flash.media.SoundMixer;
	import flash.events.Event;
	public class CutSceneGO extends FlxState
	{
		//Embed the cutscene swf relative to the root of the Flixel project here
		[Embed(source = 'assets/gameOver.swf')] private var SwfClass:Class;	 
		//This is the MovieClip container for your cutscene
		private var movie:MovieClip;
		//This is the length of the cutscene in frames
		private var longueur:Number;
		
		override public function create():void
		{
			movie = new SwfClass();
			//Set your zoom factor of the FlxGame here (default is 2)
			var zoomFactor:Number = 1.6;
			movie.scaleX = 1.0/zoomFactor;
			movie.scaleY = 1.33 / zoomFactor;
			//Add the MovieClip container to the FlxState
			FlxG.stage.addChild(movie);
			//Set the length of the cutscene here (frames)
			longueur = 77;
			//Adds a listener to the cutscene to call next() after each frame.
			movie.addEventListener(Event.EXIT_FRAME, next);
		}
		private function next(e:Event):void
		{
			//After each frame, length decreases by one
			longueur--;
			//Length is 0 at the end of the movie
			if (longueur <= 0)
			{
				//Removes the listener
				movie.removeEventListener(Event.EXIT_FRAME, next);				
				//Stops all overlaying sounds before state switch
				SoundMixer.stopAll();
				FlxG.stage.removeChild(movie);
				//Enter the next FlxState to switch to
				FlxG.switchState(new GameOverState());
			}			
		}
	} 
}
