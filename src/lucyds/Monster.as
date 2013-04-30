package lucyds {
	import org.flixel.FlxG;
	import org.flixel.FlxPath;
	import org.flixel.FlxSprite;

	public class Monster extends FlxSprite
	{
		[Embed(source="/assets/img/Monstre.png")]
		private var MonsterGraph	: Class;
		private var chemin 			: FlxPath;
		private var timer : Number = 0;
		
		public function Monster(x : int, y : int) : void
		{
			super(x, y, MonsterGraph);
			loadGraphic(MonsterGraph, false, false);
			
			this.width = this.height = 14;
			this.offset.x = this.offset.y = 249;
			this.blend = "add";
		}
		
		override public function update() : void
		{
			chemin = new FlxPath;
			chemin.addPoint(PlayState.lucie.getMidpoint(null), false);
			this.followPath(chemin, 0);
			
			var XX			: Number 	= PlayState.lucie.x - this.x;
			var YY			: Number 	= PlayState.lucie.y - this.y;
			var distance 	: Number	= Math.sqrt( XX * XX + YY * YY );
			var attack		: Number	= 600;										 // Distance de réaction
			var flicker		: Number	= 150;
			
			if(distance <= flicker)
				PlayState.darkness.flicker(-1);
			else
				PlayState.darkness.flicker(0.01);
			
			if(distance <= attack)
				this.pathSpeed = 150 * PlayState.dByMonster;

			if(PlayState.lightLucie.alive == false)
				this.velocity.x = this.velocity.y = 0;
				
			timer += FlxG.elapsed;
			if(timer >= 0.075)
			{
				var tmp : Number =  FlxG.random();
				if(tmp > 0.5 && this.scale.x < 1.5)
					this.scale.x = this.scale.y += 0.1;
				if(tmp <= 0.5 && this.scale.x > 0.5)
					this.scale.x = this.scale.y -= 0.1;
				timer = 0;
			}
		}
	}
}