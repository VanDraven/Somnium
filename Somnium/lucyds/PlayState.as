package lucyds {

	import lucyds.states.GameOverState;
	import lucyds.states.WinState;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	public class PlayState extends FlxState
	{	
		// Var d'adaptation
		
		public static var dByTime			: Number = 1;
		public static var dByFloor			: Number = 0.9;
		public static var dByMonster		: Number = 1 ;
		public static var mazeMin			: int = 0;
		public static var mazeMax			: int = 0;
		public static var tempsScore		: Number = 0;
		public static var nbWin				: int;
		public static var nbDbT				: int;
		public static var nbDbF				: int;
		public static var nbDbM				: int;
		
		//Save
		
		public static var gameSave			: FlxSave;
		
		// Const
			
		public static const TEMPSDEPART		: int				= 30;
		
		// Var
		
		public static var lucie 			: Lucie;
		public static var lightLucie 		: Light;
		public static var groundMap 		: Maze;
		public static var darkness 			: FlxSprite;
		private static var emitters			: FlxGroup;
		
		public var tempsDepart				: Number			= TEMPSDEPART / dByTime;
		public var tempsMax					: Number			= TEMPSDEPART / dByTime;
		private var monsters				: FlxGroup;
		private var pause 					: FlxGroup;
		private var parallax 				: FlxSprite 		= new FlxSprite;
		private var counter					: Number			= 0;
		private var temps 					: Number			= 0;
		private var monsterX 				: int;
		private var monsterY 				: int;
		private	var barTemps				: FlxSprite 		= new FlxSprite(11,11);
		private	var barSaut					: FlxSprite 		= new FlxSprite(691,11);
		private var dead					: Boolean			= false; 						// On ne meurt qu'une fois !
	
		[Embed(source = "assets/img/largeparallax2.png")]
		public var parallax1 : Class;
		
		override public function create() : void
		{	
			// sauvegarde
			
			gameSave = new FlxSave;
			gameSave.bind("mySave");
			trace(gameSave.data.levelPlayed);
			
			if(gameSave.data.levelPlayed == true)
			{
				dByFloor 					= gameSave.data.dByFloor; 
				dByMonster 					= gameSave.data.dByMonster; 
				dByTime 					= gameSave.data.dByTime; 
				mazeMin 					= gameSave.data.mazeMin; 
				mazeMax 					= gameSave.data.mazeMax;
				nbWin 						= gameSave.data.nbWin;
				nbDbT 						= gameSave.data.nbDbT;
				nbDbF 						= gameSave.data.nbDbF;
				nbDbM 						= gameSave.data.nbDbM;
			}
			
			else 										//si c'est la première partie jouée
			{
				dByFloor 					= 0.5; 
				dByMonster 					= 1; 
				dByTime 					= 1; 
				mazeMin 					= 0; 
				mazeMax 					= 0;
				nbWin 						= 10;
				nbDbT 						= 10;
				nbDbF 						= 20;
				nbDbM 						= 10;			
				
				gameSave.data.dByFloor 		= dByFloor;
				gameSave.data.dByMonster 	= dByMonster;
				gameSave.data.dByTime 		= dByTime;
				gameSave.data.mazeMin 		= mazeMin;
				gameSave.data.mazeMax		= mazeMax;
				gameSave.data.nbDbT 		= nbDbT;
				gameSave.data.nbDbF 		= nbDbF;
				gameSave.data.nbDbM 		= nbDbM;
				gameSave.data.nbWin 		= nbWin;
			}
			

			//stage
			
			parallax.loadGraphic(parallax1, false, false);
			parallax.scrollFactor.x = parallax.scrollFactor.y = 0.5;
			add(parallax);
			
			groundMap = new Maze();
			groundMap.createColorPath(this);
			add(groundMap);
			
			trace(nbWin,nbDbT,nbDbF,nbDbM);
			
			lucie = new Lucie(groundMap.startX, groundMap.startY);
			add(lucie);

			FlxG.camera.target = lucie;
			groundMap.follow();
			
			lightLucie = new Light(lucie.y, lucie.x);  
			add(lightLucie);
			
			monsters = new FlxGroup;
			add(monsters);
			
			emitters = new FlxGroup;
			add(emitters);
			
			darkness = new FlxSprite(0,0);
			darkness.makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
			darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
			darkness.blend = "overlay";
			add(darkness);
			
			// HUI
				
				// Barre de temps
			
			var frameTemps:FlxSprite = new FlxSprite(10,10);	
			frameTemps.makeGraphic(100, 10); 								//White frame for the time bar
			frameTemps.scrollFactor.x = frameTemps.scrollFactor.y = 0;
			add(frameTemps);
			
			var insideTemps:FlxSprite = new FlxSprite(11,11);
			insideTemps.makeGraphic(98,8,0xff000000); 						//Black interior
			insideTemps.scrollFactor.x = insideTemps.scrollFactor.y = 0;
			add(insideTemps);
			
			barTemps.makeGraphic(1,8,0xffff0000); 							//The time bar itself
			barTemps.scrollFactor.x = barTemps.scrollFactor.y = 0;
			barTemps.origin.x = barTemps.origin.y = 0; 						//Zero out the origin
			barTemps.scale.x = 98; 											//Fill up the time bar all the way
			add(barTemps);
			
				// Barre de saut
			
			var frameSaut:FlxSprite = new FlxSprite(690,10);
			frameSaut.makeGraphic(100, 10); 								//White frame for the jump bar
			frameSaut.scrollFactor.x = frameSaut.scrollFactor.y = 0;
			add(frameSaut);
			
			var insideSaut:FlxSprite = new FlxSprite(691,11);
			insideSaut.makeGraphic(98,8,0xff000000); 						//Black interior
			insideSaut.scrollFactor.x = insideSaut.scrollFactor.y = 0;
			add(insideSaut);
			
			barSaut.makeGraphic(1,8,0xffff0000); 							//The jump bar itself
			barSaut.scrollFactor.x = barSaut.scrollFactor.y = 0;
			barSaut.origin.x = barSaut.origin.y = 0; 						//Zero out the origin
			add(barSaut);
			
			pause = new FlxGroup;
			add(pause);
			
			
				trace("dByFloor :", dByFloor);
				trace("dByMonster :", dByMonster);
				trace("dByTime :", dByTime);
				trace("groundMap.lowLimit :", groundMap.lowLimit);
				trace("groundMap.highLimit :", groundMap.highLimit);
			
			super.create();
			FlxG.paused = false;
			tempsScore = 0;
			
			
		}
		
		override public function update():void
		{
			FlxG.collide(lucie, groundMap);
			
			// pause
			
			if (!FlxG.paused) 
				super.update();
			else 
				pause.update();
			
			if (FlxG.keys.justPressed("ESCAPE") || FlxG.keys.justPressed("P")) 
			{
				if(!FlxG.paused)
				{
					FlxG.paused = true;
					pause.revive();
				} 
				else 
				{
					FlxG.paused = false;
					pause.alive = false;
					pause.exists = false;
				}
			}
			
			// fin pause		
			
			if(!FlxG.paused)
				temps += FlxG.elapsed;
			
			if(FlxG.keys.pressed("UP"))
			{
				monsterX = lucie.x;
				monsterY = lucie.y + (200 + 200 * FlxG.random());
			}
			if(FlxG.keys.pressed("DOWN"))
			{
				monsterX = lucie.x;
				monsterY = lucie.y - (200 + 200 * FlxG.random());	
			}
			if(FlxG.keys.pressed("LEFT"))
			{
				monsterX = lucie.x + (200 + 200 * FlxG.random());	
				monsterY = lucie.y;
			}
			if(FlxG.keys.pressed("RIGHT"))
			{
				monsterX = lucie.x - (200 + 200 * FlxG.random());	
				monsterY = lucie.y;
			}
			
			if(temps >= 15)
			{
				spawnMonsters(monsterX, monsterY);
				temps = 0;
			}
			
			if(!FlxG.paused)
				tempsScore += FlxG.elapsed;
			
			// lumiere ON/OFF
			
			if (FlxG.keys.justPressed("SHIFT"))
			{
				if(lightLucie.alive)
					lightLucie.kill();
				else
					lightLucie.revive();
			}
			
			// génération du score
			if(!FlxG.paused && lightLucie.alive)
				counter += FlxG.elapsed;

			if(counter >= 1)
			{
				tempsDepart -= 1;
				counter = 0;
				if(barTemps.scale.x > 0)
					barTemps.scale.x -= 98/tempsMax;
			}
			
			// affichage du compteur de saut
			
			barSaut.scale.x = Lucie.sautCompte*(98/5);
			
			// Conditions de défaite

			if(FlxG.overlap(lucie, monsters) || groundMap.getTile((lucie.x+9)/32, (lucie.y+30)/32) == 0 || tempsDepart <= 0)
				if(dead == false)
				{
					mort();
					dead = true;
				}		
			
			// Conditions de victoire
			
			if(groundMap.getTile(lucie.x/32, lucie.y/32) == 7)
				if(dead == false)
				{
					vivant();
					dead = true;
				}
			
			// Fait coller la lumière à Lucie
			
			if(lightLucie.x != lucie.x - 512)
				lightLucie.x = lucie.x - 512;
			if(lightLucie.y != lucie.y - 512)
				lightLucie.y = lucie.y - 512;
		}
		
		private function spawnMonsters(monsterX : Number, monsterY : Number) : void
		{
			monsters.add(new Monster(monsterX, monsterY));
		}
		
		public static function spawnEmitter (x : int, y : int) : void
		{
			var emitteur:FlxEmitter = new FlxEmitter(x+12, y+12);
			var particles:int = 15;
			
			for(var i:int = 0; i < particles; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(4, 2, 0xDDffffff);
				particle.exists = false;
				particle.blend = "add";
				emitteur.add(particle);
			}
			emitteur.start(true, 0.7);
			emitters.add(emitteur);
		}
		
		public function switchLoose() : void
		{
			FlxG.switchState(new GameOverState());
		}
		
		public function switchWin() : void
		{
			FlxG.switchState(new WinState());
		}
		
		public function mort() : void
		{
			var ratioDbT : Number = nbWin/nbDbT;
			var ratioDbF : Number = nbWin/nbDbF;
			var ratioDbM : Number = nbWin/nbDbM;
			
			if(tempsDepart <= 0)
				if(dByTime > 0)
				{
					nbDbT += 1;
					dByTime = ratioDbT;
				}
			
			if(groundMap.getTile((lucie.x+9)/32, (lucie.y+30)/32) == 0)
				if(dByFloor > 0)
				{
					nbDbF += 1;
					dByFloor = ratioDbF;
				}
			
			if(FlxG.overlap(lucie, monsters))
				if(dByMonster > 0)
				{
					nbDbM += 1;
					dByMonster = ratioDbM;
				}
			
			lucie.kill();
			lightLucie.kill();
			
			var levelPlayed : Boolean = true;
			
			gameSave.data.dByFloor 		= dByFloor;
			gameSave.data.dByMonster 	= dByMonster;
			gameSave.data.dByTime 		= dByTime;
			gameSave.data.mazeMin 		= mazeMin;
			gameSave.data.mazeMax		= mazeMax;
			gameSave.data.nbDbT 		= nbDbT;
			gameSave.data.nbDbF 		= nbDbF;
			gameSave.data.nbDbM 		= nbDbM;
			gameSave.data.levelPlayed 	= levelPlayed;
			
			gameSave.close();
			FlxG.flash(0xffffffff, 1.5);
			FlxG.fade(0xFF000000, 1.5, switchLoose);
		}
		
		public function vivant() : void
		{
			var ratioWin : Number = nbWin/(nbDbT+nbDbF+nbDbM+nbWin);
			var ratioDbT : Number = nbWin/nbDbT;
			var ratioDbF : Number = nbWin/nbDbF;
			var ratioDbM : Number = nbWin/nbDbM;
			
			nbWin 		+= 1;
			dByFloor 	= ratioDbF;
			dByMonster 	= ratioDbM;
			dByTime		= ratioDbT;
			mazeMin 	+= 10*ratioWin;
			mazeMax 	+= 10*ratioWin;
			
			var levelPlayed : Boolean = true;
			
			gameSave.data.dByFloor 		= dByFloor;
			gameSave.data.dByMonster 	= dByMonster;
			gameSave.data.dByTime		= dByTime;
			gameSave.data.mazeMin 		= mazeMin;
			gameSave.data.mazeMax 		= mazeMax;
			gameSave.data.nbWin 		= nbWin;
			gameSave.data.levelPlayed 	= levelPlayed;
				
			gameSave.close();
			FlxG.paused = true;
			FlxG.flash(0xffffffff, 1.5);
			FlxG.fade(0xFF000000, 1.5, switchWin);
		}
	}	
}