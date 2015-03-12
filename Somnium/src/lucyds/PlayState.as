package lucyds {

	import org.flixel.FlxPoint;
	import lucyds.states.MenuState;
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
		public static var dByMonster		: Number = 1;
		public static var dByFloor			: Boolean = false;
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
		public static var lightLucie 		: LightMaze;
		public static var groundMap 		: Maze;
		public static var darkness 			: FlxSprite;
		public static var parallax 			: FlxSprite;
		public static var zebraPwnd			: Boolean			= false;
		public static var best				: int;
		public static var score				: int;
		public static var jump 				: int				= 0;
		public static var sautCompte 		: Number 			= 2;
		private static var emitters			: FlxGroup;
		
		public var tempsDepart				: Number			= TEMPSDEPART / dByTime;
		public var tempsMax					: Number			= TEMPSDEPART / dByTime;
		private var monsters				: FlxGroup;
		private var zebras					: FlxGroup;
		private var zebre 					: Zebra;
		private var pause 					: FlxGroup;
		private var temps 					: Number			= 0;
		private var monsterX 				: int;
		private var monsterY 				: int;
		private	var barSaut					: FlxSprite 		= new FlxSprite(691,11);
		private var dead					: Boolean			= false; 						// On ne meurt qu'une fois !
		private var zebraX 					: int 				= 0;
		private var zebraY					: int 				= 0;
		private var zebraExist				: Boolean			= false;
		private var zebraOnce 				: Boolean 			= false;
		
		private var type					: String;
		private var roomChoosed				: String;
		private var startCoo				: FlxPoint;
	
		[Embed(source = "assets/img/largeparallax5.png")]
		public var parallax1 : Class;
		
		public function PlayState(type : String, startCoo : FlxPoint, roomChoosed : String)
		{
			this.type = type;
			this.roomChoosed = roomChoosed;
			this.startCoo = startCoo;
		}
		
		override public function create() : void
		{	
			FlxG.music.kill();
			
			// sauvegarde
			
			gameSave = new FlxSave;
			gameSave.bind("mySave");
						
			if(gameSave.data.levelPlayed == true)
			{
				dByMonster 	= gameSave.data.dByMonster; 
				dByTime 	= gameSave.data.dByTime; 
				dByFloor	= gameSave.data.dByFloor;
				mazeMin 	= gameSave.data.mazeMin; 
				mazeMax 	= gameSave.data.mazeMax;
				nbWin 		= gameSave.data.nbWin;
				nbDbT 		= gameSave.data.nbDbT;
				nbDbF 		= gameSave.data.nbDbF;
				nbDbM 		= gameSave.data.nbDbM;
				best		= gameSave.data.best;
			}
			
			else 										//si c'est la première partie jouée
			{
				dByMonster 	= 1; 
				dByTime 	= 1;
				dByFloor	= false; 
				mazeMin 	= 0; 
				mazeMax 	= 0;
				nbWin 		= 10;
				nbDbT 		= 10;
				nbDbF 		= 10;
				nbDbM 		= 10;
				best		= 10;
				
				var tropTemps 		: Number = 0;	
				
				gameSave.data.dByMonster 	= dByMonster;
				gameSave.data.dByTime 		= dByTime;
				gameSave.data.dByFloor		= dByFloor;
				gameSave.data.mazeMin 		= mazeMin;
				gameSave.data.mazeMax		= mazeMax;
				gameSave.data.nbDbT 		= nbDbT;
				gameSave.data.nbDbF 		= nbDbF;
				gameSave.data.nbDbM 		= nbDbM;
				gameSave.data.nbWin 		= nbWin; 
				gameSave.data.tropTemps 	= tropTemps;
				
				if(gameSave.data.best > 0)
					best = gameSave.data.best;
				else
					gameSave.data.best = best;
			}
			

			//stage
			
			parallax = new FlxSprite();
			parallax.loadGraphic(parallax1, false, false);
			parallax.scrollFactor.x = parallax.scrollFactor.y = 0.5;
			add(parallax);
			
			groundMap = new Maze();
			groundMap.createColorPath(this);
			add(groundMap);
			
			trace(nbWin,nbDbT,nbDbF,nbDbM);
			
			zebras = new FlxGroup();
			add(zebras);
			
			lucie = new Lucie(groundMap.startX, groundMap.startY);
			add(lucie);
			
			FlxG.camera.target = lucie;
			groundMap.follow();
			
			
			lightLucie = new LightMaze(lucie.y, lucie.x);  
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
			
				// Barre de saut
			
			var frameSaut:FlxSprite = new FlxSprite(690,10);
			frameSaut.makeGraphic(100, 10); 								//White frame for the jump bar
			frameSaut.scrollFactor.x = frameSaut.scrollFactor.y = 0;
			add(frameSaut);
			
			var insideSaut:FlxSprite = new FlxSprite(691,11);
			insideSaut.makeGraphic(98,8,0xff000000); 						//Black interior
			insideSaut.scrollFactor.x = insideSaut.scrollFactor.y = 0;
			add(insideSaut);
			
			barSaut.makeGraphic(1,8,0xff9b40bf); 							//The jump bar itself
			barSaut.scrollFactor.x = barSaut.scrollFactor.y = 0;
			barSaut.origin.x = barSaut.origin.y = 0; 						//Zero out the origin
			add(barSaut);
			
			pause = new FlxGroup;
			add(pause);
			
			super.create();
			FlxG.paused = false;
			tempsScore = 0;
		}
		
		override public function update():void
		{
			FlxG.collide(lucie, groundMap);
			//FlxG.collide(monsters, groundMap);
			
			saut();
			
			// pause
			
			if (!FlxG.paused) 
				super.update();
			else 
				pause.update();
			
			if (FlxG.keys.justPressed("P")) 
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
			
			if (FlxG.keys.justPressed("ESCAPE")) 
				FlxG.switchState(new MenuState());
			
			// fin pause		
			
			if(!FlxG.paused)
				temps += FlxG.elapsed;
			

			/// Apparition monstre
			
			if(temps >= 15)
			{
				spawnMonsters();
				temps = 0;
			}
			
			if(!FlxG.paused)
				tempsScore += FlxG.elapsed;
			
			// Apparition zebre
			
			var numZ : int = 0;
			
			if(temps >=10 + 30*FlxG.random() && lightLucie.alive && !zebraExist && numZ < 10000 && !zebraOnce)
			{

				var distance : int = 0;
				
				while(groundMap.fields[zebraY][zebraX] != 1  || distance < 5*32)
				{
					zebraX = 0;
					zebraY = 0;
					numZ++;					
					
					while(zebraX >= 90 || zebraY >= 60 || zebraX <= 0 || zebraY <= 0)
					{
						var flipX 	: Number 	= FlxG.random();
						var flipY 	: Number 	= FlxG.random();
						var zXdist 	: int 		= FlxG.random()*256;
						var zYdist 	: int 		= FlxG.random()*256;
						
						distance = Math.sqrt( zXdist * zXdist + zYdist * zYdist);
					
						if(flipX < 0.5)
							zebraX = (lucie.x + zXdist)/32;
						else
							zebraX = (lucie.x - zXdist)/32;
						
						if(flipY > 0.5)
							zebraY = (lucie.y + zYdist)/32;
						else
							zebraY = (lucie.y - zYdist)/32;
					}
				}
				
				zebras.add(zebre = new Zebra(zebraX*32 + 8, zebraY*32));
				zebraExist = true;
				zebraOnce = true;
			}
			
			// chope la peluche
			
			if(FlxG.overlap(lucie, zebras))
			{
				zebre.kill();
				zebraExist = false;
				zebraPwnd = true;
			}
			
			// plus de peluche si plus de sol
			
			if(groundMap.getTile(zebraX, zebraY) == 0 && zebraExist)
			{
				zebraExist = false;
				zebre.kill();
			}
				
			// si lumière off : zebra pas visible
			
			if(!lightLucie.alive && zebraExist)
				zebre.kill();
			else if(lightLucie.alive && zebraExist)
				zebre.revive();
						
			// lumiere ON/OFF
			
			if (FlxG.keys.justPressed("SHIFT"))
			{
				if(lightLucie.alive)
					lightLucie.kill();
				else
					lightLucie.revive();
			}
			
			// moins il reste de temps, plus la lumière clignotte
			if(!FlxG.paused && lightLucie.alive)
			{
				var blink : Number = tempsDepart*FlxG.random()*10;
				if(Math.exp(tempsMax/tempsDepart)/tempsMax > blink)
					lightLucie.flicker(1/60);
			}
			
			// si destruction trop près alors shake
			
			var luciX : int = lucie.x/32;
			var luciY : int = lucie.y/32;
			
			if((groundMap.fieldValues[luciY][luciX]) + 4 >= groundMap.realBN() && !FlxG.paused)
				FlxG.shake(0.005, 0.1);
			
			// affichage du compteur de saut
			
			barSaut.scale.x = sautCompte*(98/5);
			
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
		
		private function spawnMonsters() : void
		{
//			var error : int = 0;
//			while((groundMap.fields[monsterX][monsterY] != 1) || (error > 100))
//			{	
//				if(FlxG.keys.pressed("UP"))
//				{
//					monsterX = lucie.x;
//					monsterY = lucie.y + (200 + 200 * FlxG.random());
//				}
//				if(FlxG.keys.pressed("DOWN"))
//				{
//					monsterX = lucie.x;
//					monsterY = lucie.y - (200 + 200 * FlxG.random());	
//				}
//				if(FlxG.keys.pressed("LEFT"))
//				{
//					monsterX = lucie.x + (200 + 200 * FlxG.random());	
//					monsterY = lucie.y;
//				}
//				if(FlxG.keys.pressed("RIGHT"))
//				{
//					monsterX = lucie.x - (200 + 200 * FlxG.random());	
//					monsterY = lucie.y;
//				}
//				error++;
//			}
				var distance : int = 0;
				
//				while(groundMap.fields[monsterY][monsterX] != 1  || distance < 5*32)
//				{
					monsterX = 0;
					monsterY = 0;					
					
					while(monsterX >= 90 || monsterY >= 60 || monsterX <= 0 || monsterY <= 0)
					{
						var flipX 	: Number 	= FlxG.random();
						var flipY 	: Number 	= FlxG.random();
						var zXdist 	: int 		= FlxG.random()*256;
						var zYdist 	: int 		= FlxG.random()*256;
						
						distance = Math.sqrt( zXdist * zXdist + zYdist * zYdist);
					
						if(flipX < 0.5)
							monsterX = (lucie.x + zXdist)/32;
						else
							monsterX = (lucie.x - zXdist)/32;
						
						if(flipY > 0.5)
							monsterY = (lucie.y + zYdist)/32;
						else
							monsterY = (lucie.y - zYdist)/32;
//					}
				}
			trace(monsterX, monsterY);
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
			if(type == "InGame")
			{
				FlxG.switchState(new GameState("ChambreRosa", new FlxPoint(3,5)));
				GameState.dayCompte++;
				
				if(GameState.events[2] != true)
				{
					GameState.textPos = "Dialogue";
					GameState.texte = "Oh quel cauchemar.";
					GameState.textFace = "peur";
					GameState.updateText = true;
					GameState.events[2] = true;
				}
			}
			else if(type == "StandAlone")
				FlxG.switchState(new CutSceneGO());
		}
		
		public function switchWin() : void
		{
			if(type == "InGame")
			{
				FlxG.switchState(new GameState(roomChoosed, startCoo));
				if(GameState.events[2] != true)
				{
					GameState.textPos = "Dialogue";
					GameState.texte = "Oh quel cauchemar.";
					GameState.textFace = "peur";
					GameState.updateText = true;
					GameState.events[2] = true;
				}
			}
			else if(type == "StandAlone")
				FlxG.switchState(new WinState());
		}
		
		public function mort() : void
		{
			var ratioDbT : Number = nbWin/nbDbT;
			var ratioDbM : Number = nbWin/nbDbM;
			
			if(tempsDepart <= 0)
				if(dByTime > 0)
				{
					nbDbT += 1;
					dByFloor = false;
					dByTime = ratioDbT;
				}
			
			if(groundMap.getTile((lucie.x+9)/32, (lucie.y+30)/32) == 0)
			{
					nbDbF += 1;
					dByFloor = true;
			}
			
			if(FlxG.overlap(lucie, monsters))
				if(dByMonster > 0)
				{
					nbDbM += 1;
					dByFloor = false;
					dByMonster = ratioDbM;
				}
			
			lucie.kill();
			lightLucie.kill();
			
			var levelPlayed : Boolean = true;
			
			gameSave.data.dByMonster 	= dByMonster;
			gameSave.data.dByTime 		= dByTime;
			gameSave.data.dByFloor		= dByFloor;
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
			var ratioDbM : Number = nbWin/nbDbM;
			
			nbWin 		+= 1;
			dByMonster 	= ratioDbM;
			dByTime		= ratioDbT;
			dByFloor	= false;
			mazeMin 	+= 20*ratioWin;
			mazeMax 	+= 20*ratioWin;
			
			if(zebraPwnd)
					score = ((groundMap.numFields*2 + groundMap.realBN()) * (1/groundMap.tempsDest) * dByMonster * dByTime * 10);
				else
					score = ((groundMap.numFields + groundMap.realBN()) * (1/groundMap.tempsDest) * dByMonster * dByTime * 10);
					
			var levelPlayed : Boolean = true;
			
			gameSave.data.dByMonster 	= dByMonster;
			gameSave.data.dByTime		= dByTime;
			gameSave.data.dByFloor		= dByFloor;
			gameSave.data.mazeMin 		= mazeMin;
			gameSave.data.mazeMax 		= mazeMax;
			gameSave.data.nbWin 		= nbWin;
			
			gameSave.data.tropTemps 	= groundMap.pathRatio * (groundMap.realBN() * tempsScore / groundMap.firstRealBN);
			gameSave.data.lastTempsDest = groundMap.tempsDest;
			
			gameSave.data.levelPlayed 	= levelPlayed;
			if(score > gameSave.data.best)
			{
				best = score;
				gameSave.data.best = score;
			}	
			gameSave.close();
			FlxG.paused = true;
			FlxG.flash(0xffffffff, 1.5);
			FlxG.fade(0xFF000000, 1.5, switchWin);
		}
		
		public function saut () : void
		{
			// commande de saut
			
			if(sautCompte <= 5)
				sautCompte += FlxG.elapsed/60;			
					
			if(sautCompte >= 1)
			{
				if(FlxG.keys.justPressed("SPACE") && (FlxG.keys.pressed("Q") || FlxG.keys.pressed("LEFT")) && PlayState.groundMap.getTile((lucie.x-64)/32, lucie.y/32) == 1)
				{
					lucie.x = lucie.x - 64;
					sautCompte--;
					jump++;
				}
				if(FlxG.keys.justPressed("SPACE") && (FlxG.keys.pressed("D") || FlxG.keys.pressed("RIGHT")) && PlayState.groundMap.getTile((lucie.x+64)/32, lucie.y/32) == 1)
				{
					lucie.x = lucie.x + 64;
					sautCompte--;
					jump++;
				}
				if(FlxG.keys.justPressed("SPACE") && (FlxG.keys.pressed("Z") || FlxG.keys.pressed("UP")) && PlayState.groundMap.getTile(lucie.x/32, (lucie.y-64)/32) == 1)
				{
					lucie.y = lucie.y - 64;
					sautCompte--;
					jump++;
				}
				if(FlxG.keys.justPressed("SPACE") && (FlxG.keys.pressed("S") || FlxG.keys.pressed("DOWN")) && PlayState.groundMap.getTile(lucie.x/32, (lucie.y+64)/32) == 1)
				{
					lucie.y = lucie.y + 64;
					sautCompte--;
					jump++;
				}
			}
		}
	}	
}