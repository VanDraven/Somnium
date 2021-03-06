package lucyds
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Lucie extends FlxSprite
	{		
		[Embed(source="assets/img/Rosa.png")]
		private var lucie : Class;
		
		private static const VELOCITY : uint = 250;
		
		private static const VELOCITY_X : Vector.<Vector.<int>> = new <Vector.<int>>[
			new <int>[-VELOCITY / 1.35,		0,		VELOCITY / 1.35],
			new <int>[-VELOCITY,			0,		VELOCITY],
			new <int>[-VELOCITY / 1.35,		0,		VELOCITY / 1.35],
		];
		
		private static const VELOCITY_Y : Vector.<Vector.<int>> = new <Vector.<int>>[
			new <int>[-VELOCITY / 1.35,	-VELOCITY,	-VELOCITY / 1.35],
			new <int>[0,				0,			0],
			new <int>[VELOCITY / 1.35,	VELOCITY,	VELOCITY / 1.35],
		];
		
		private static const ANIMATIONS_WALK : Vector.<Vector.<String>> = new <Vector.<String>>[
			new <String>['Walk Up',		'Walk Up',		'Walk Up'],
			new <String>['Walk Left',	null,			'Walk Right'],
			new <String>['Walk Down',	'Walk Down',	'Walk Down'],
		];
		
		private static const ANIMATIONS_IDLE : Vector.<Vector.<String>> = new <Vector.<String>>[
			new <String>['Idle Up',		'Idle Up',		'Idle Up'],
			new <String>['Idle Left',	null,			'Idle Right'],
			new <String>['Idle Down',	'Idle Down',	'Idle Down'],
		];
		
		private var lastFieldX 			: uint;
		private var lastFieldY 			: uint;
		
		public function Lucie(startX : int, startY : int):void
		{
			super(32*startX, 32*startY);
			loadGraphic(lucie, true, true, 24, 39, true);
			
			this.width = 14;
			this.height = 16;
			this.offset.x = 5;
			this.offset.y = 25;
			
			addAnimation("Walk Left", [4,5,6,7], 7, true);
			addAnimation("Idle Left", [4], 0, false);
			addAnimation("Walk Right", [8,9,10,11], 7, true);
			addAnimation("Idle Right", [8], 0, false);
			addAnimation("Walk Up", [12,13,14,15], 7, true);
			addAnimation("Idle Up", [12], 0, false);
			addAnimation("Walk Down", [0,1,2,3], 7, true);
			addAnimation("Idle Down", [0], 0, true);
			
			play("Idle Right");
		}
		
		/**
		 * Met a jour le sprite du joueur en function des entrees clavier
		 */		
		override public function update():void
		{			
			// Retrouve la case de tableau a laquelle on veut acceder.
			var fieldX : uint = 1 - (uint(FlxG.keys.LEFT) || uint(FlxG.keys.Q)) + (uint(FlxG.keys.RIGHT) || uint(FlxG.keys.D));
			var fieldY : uint = 1 - (uint(FlxG.keys.UP) || uint(FlxG.keys.Z)) + (uint(FlxG.keys.DOWN) || uint(FlxG.keys.S));
			
			// Change la vitesse
			velocity.x = VELOCITY_X[fieldY][fieldX];
			velocity.y = VELOCITY_Y[fieldY][fieldX];
			
			// Declenche l'animation voulue.
			if (velocity.x == 0 && velocity.y == 0)
				play(ANIMATIONS_IDLE[lastFieldY][lastFieldX]);
			else
			{
				play(ANIMATIONS_WALK[fieldY][fieldX]);
				lastFieldX = fieldX;
				lastFieldY = fieldY;
			}
			
			super.update();
		}
	}
}
