package lucyds
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Light extends FlxSprite 
	{
		[Embed(source="/assets/img/light2.png")]
		private var LightImageClass:Class;
		
		private var darkness : FlxSprite;
		private var timer : Number = 0;
		
		public function Light(x:Number, y:Number, darkness:FlxSprite) : void 
		{
			this.darkness = darkness;
				
			super(x, y, LightImageClass);
			this.blend = "add";
		}
		
		override public function update() : void
		{
			timer += FlxG.elapsed;
			if(timer >= 0.075)
			{
				var tmp : Number =  FlxG.random();
				if(tmp > 0.5 && this.scale.x < 1.5)
					this.scale.x = this.scale.y += 0.015;
				if(tmp <= 0.5 && this.scale.x > 0.5)
					this.scale.x = this.scale.y -= 0.015;
				timer = 0;
			}
		}
		
		override public function draw():void 
		{
   			var screenXY:FlxPoint = GameState.lucie.getScreenXY();
				
     		 darkness.stamp(this,
                    screenXY.x - this.width/2,
                    screenXY.y - this.height/2);
		}
	}
}