package lucyds
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Light extends FlxSprite 
	{
		[Embed(source="/assets/img/LightLucie.png")]
		private var LightImageClass:Class;
		private var timer : Number = 0;
		
		public function Light(x:Number, y:Number) : void 
		{
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
	}
}