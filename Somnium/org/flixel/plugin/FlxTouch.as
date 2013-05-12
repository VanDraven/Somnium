package org.flixel.plugin {
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;

	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author Adam Biles
	 */
	public class FlxTouch extends FlxSprite 
	{
		public function FlxTouch(state:FlxState) 
		{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			var s : FlxSprite = new FlxSprite(FlxG.width - 100, FlxG.height - 100);
			
			s.addEventListener(TouchEvent.TOUCH_BEGIN, onBegin);
			s.addEventListener(TouchEvent.TOUCH_END, onRelease);
			s.
			
			state.add(s);
		}
		
		private function onRelease(e:TouchEvent):void 
		{
		}
		
		private function onBegin(e:TouchEvent):void 
		{
		}
	}
}
