package lucyds {
	
	import lucyds.states.MenuState;
	import org.flixel.FlxSave;
	import org.flixel.FlxText;
	import org.flixel.FlxSprite;
	import lucyds.ChambreRosa;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import org.flixel.FlxState;

	/**
	 * @author DXPCorp
	 */
	public class GameState extends FlxState 
	{
		public static var lucie 			: Lucie;
		public static var lightLucie 		: Light;
		public static var lightLucieStatus	: Boolean		= true;
		public static var room 				: Room;
		public static var clefs				: Array			= new Array();
		public static var notes				: Array			= new Array();
		public static var events			: Array			= new Array();
		public static var globalTimer		: Number 		= 0;
		public static var dayCompte			: int 			= 1;
		public static var updateText		: Boolean		= false;
		public static var texte				: String;
		public static var textPos			: String;
		public static var textFace			: String;
		public static var gameSave			: FlxSave;
		private static var dayLength		: int 			= 200;
		private static var dayLightTimer	: Number 		= 10;
		private static var asc				: Boolean 		= true;
		private var noteText 				: FlxText 		= new FlxText(100, FlxG.height/2, FlxG.width - 200);
		private var gameText 				: FlxText		= new FlxText(10, 10, 10);
		private var textBox					: FlxSprite;
		private var visage					: FlxSprite		= new FlxSprite(0,0);
		private var pause 					: FlxGroup;
		private var furnitures				: FlxGroup;
		private var furnitures2				: FlxGroup;
		private var furnitures3				: FlxGroup;
		private var coffres					: FlxGroup;
		private var fenetres				: FlxGroup;
		private var lumieres				: FlxGroup;
		private var monsters				: FlxGroup;
		//private var defaultGroup			: FlxGroup		= new FlxGroup();
		private var startCoo				: FlxPoint;
		private var roomChoosed				: String;
		private var textDisplayed			: Boolean		= false;
		private var fondsFenetres 			: Array 		= new Array();
		private var fondFenetre 			: FlxSprite 	= new FlxSprite();
		private var darkness 				: FlxSprite 	= new FlxSprite(0,0);
		private var box 					: FlxSprite		= new FlxSprite(10, 10);
		private var text 					: FlxText 		= new FlxText(20, 20, 100);
		private var luc 					: FlxSprite 	= new FlxSprite(0,0);
		
		//illustrations
		[Embed(source = "assets/img/Illu/Lucie.jpg")] // illustration
		public var Illu1Img	: Class;
		[Embed(source = "assets/img/JournalRosa/Page1.png")] // illustration
		public var Journal1Img	: Class;
		[Embed(source = "assets/img/JournalRosa/Page2.png")] // illustration
		public var Journal2Img	: Class;
		[Embed(source = "assets/img/JournalRosa/Page3.png")] // illustration
		public var Journal3Img	: Class;
		[Embed(source = "assets/img/JournalRosa/Page4.png")] // illustration
		public var Journal4Img	: Class;
		[Embed(source = "assets/img/JournalRosa/Page5.png")] // illustration
		public var Journal5Img	: Class;
		[Embed(source = "assets/img/JournalRosa/Page6.png")] // illustration
		public var Journal6Img	: Class;
		[Embed(source = "assets/img/JournalRosa/Page7.png")] // illustration
		public var Journal7Img	: Class;
		
		//faces
		[Embed(source="assets/img/Visage1.png")]
		private var vsourire : Class;
		[Embed(source="assets/img/Visage2.png")]
		private var vneutre : Class;
		[Embed(source="assets/img/Visage3.png")]
		private var vpeur : Class;
		[Embed(source="assets/img/Visage4.png")]
		private var vcolere : Class;
		
		public function GameState (roomChoosed : String, startCoo : FlxPoint)
		{
			this.startCoo = startCoo;
			this.roomChoosed = roomChoosed;
			
			
			if(roomChoosed == "ChambreRosa")
				room = new ChambreRosa();
			if(roomChoosed == "Penderie")
				room = new Penderie();
			if(roomChoosed == "ChambreParents")
				room = new ChambreParents();
			if(roomChoosed == "Couloir2")
				room = new Couloirs();
			if(roomChoosed == "SalleBal")
				room = new SalleBal();
			if(roomChoosed == "CaveVin")
				room = new CaveVin();
			if(roomChoosed == "RDC")
				room = new CouloirRDC();
			if(roomChoosed == "Couloir1")
				room = new Couloir1();
			if(roomChoosed == "SalleMusique")
				room = new SalleDeMusique();
			if(roomChoosed == "Bureau")
				room = new Bureau();
			if(roomChoosed == "Grenier")
				room = new Grenier();
			if(roomChoosed == "Bibli")
				room = new Bibli();
			if(roomChoosed == "Cuisine")
				room = new Cuisine();
			if(roomChoosed == "Jardin")
				room = new Jardin();
			if(roomChoosed == "Cabane")
				room = new Cabane();
		}
		
		override public function create() : void
		{
			FlxG.music.kill();
			
			gameSave = new FlxSave();
			gameSave.bind("myStorySave");
			trace(gameSave.data.notNew);
			if(gameSave.data.notNew == true)
			{
				clefs = gameSave.data.clefs;
				notes = gameSave.data.notes;
				events = gameSave.data.events;
				lightLucieStatus = gameSave.data.lightLucieStatus;
				dayLightTimer = gameSave.data.dayLightTimer;
				dayCompte = gameSave.data.dayCompte;
				asc = gameSave.data.asc;
				globalTimer = gameSave.data.globalTimer;
			}
			else
			{
				gameSave.data.clefs = new Array();
				gameSave.data.notes = new Array();
				gameSave.data.events = new Array();
				gameSave.data.notNew = true;
				gameSave.data.dayCompte = 1;
				clefs = new Array;
				dayCompte = 1;
				asc = true;
				globalTimer = 0;
				dayLightTimer = 10;
				lightLucieStatus = true;
			}		
			
			add(room);
			
			fenetres = room.windows;
			
			
			for(var i : int = 0; i < fenetres.length; i++)
			{
				var fenetre : FlxSprite = fenetres.members[i];
				fondFenetre = new FlxSprite(fenetre.x, fenetre.y);
				fondFenetre.makeGraphic(fenetre.width, fenetre.height);
				add(fondFenetre);
				fondsFenetres.push(fondFenetre);
			}
			
			add(fenetres);
			
			//add(defaultGroup);
			furnitures2 = room.furnitures2;
			add(furnitures2);
//			for(i = 0; furnitures2.length > i; i++)
//				defaultGroup.add(furnitures2.members[i]);
			
			furnitures = room.furnitures;
			add(furnitures);
//			for(i = 0; furnitures.length > i; i++)
//				defaultGroup.add(furnitures.members[i]);
			
			coffres = room.chests;
			add(coffres);
//			for(i = 0; coffres.length > i; i++)
//				defaultGroup.add(coffres.members[i]);
			
			lumieres = room.lumieres;
			add(lumieres);
			
			lucie = new Lucie(startCoo.x, startCoo.y);
			add(lucie);
//			defaultGroup.add(lucie);
			
			lightLucie = new Light(lucie.y, lucie.x, darkness);
			add(lightLucie);
			
			FlxG.camera.target = lucie;
			
			monsters = room.monsters;
			add(monsters);
//			for(i = 0; monsters.length > i; i++)
//				defaultGroup.add(monsters.members[i]);
			
			furnitures3 = room.furnitures3;
			add(furnitures3);
//			for(i = 0; furnitures3.length > i; i++)
//				defaultGroup.add(furnitures3.members[i]);
			
			if(dayLightTimer < 50)
			{
				for(i = 0; i < lumieres.length; i++)
				{
					var lum : FlxSprite = lumieres.members[i];
					var lumierePt : FlxPoint = new FlxPoint(lum.x,lum.y);
					var lumiere : Light2 = new Light2(lumierePt.x+20, lumierePt.y, darkness);
					add(lumiere);
				}
			}
				
			darkness.makeGraphic(FlxG.camera.width, FlxG.camera.height, 0xFF000000);
			darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
			darkness.blend = "multiply";
			add(darkness);

			
			box.makeGraphic(110, 30, 0xFF420404);
			box.scrollFactor.x = box.scrollFactor.y = 0;
			text.scrollFactor.x = text.scrollFactor.y = 0;
			add(box);
			add(text);
			add(noteText);
			
			gameText.alpha = 0;
			visage.alpha = 0;
			
			luc.loadGraphic(Illu1Img, false, false, FlxG.camera.width, FlxG.camera.height);
			luc.scrollFactor.x = luc.scrollFactor.y = 0;
			add(luc);
			luc.kill();
			
			FlxG.worldBounds.make(0,0,room.width,room.height);	
			pause = new FlxGroup;
			add(pause);
			
			
		}
		
		override public function draw():void 
		{
   			darkness.fill(0xff000000);
  			super.draw();
 		}
		
		override public function update() : void
		{
			FlxG.collide(lucie, room);
			FlxG.collide(monsters, room);
			//FlxG.collide(monsters);
			FlxG.collide(lucie, monsters);
			FlxG.collide(monsters, furnitures);
			FlxG.collide(monsters, furnitures3);
			FlxG.collide(monsters, coffres);
			FlxG.collide(monsters, fenetres);
			FlxG.collide(lucie, furnitures);
			FlxG.collide(lucie, furnitures3);
			FlxG.collide(lucie, coffres);
			FlxG.collide(lucie, fenetres);
			FlxG.collide(furnitures, room);
			FlxG.collide(furnitures);
			
			// z-sort	
			//defaultGroup.sort("y", FlxGroup.ASCENDING);
			
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
			
			enigmes ();
			 
			// couleur de fond aka soleil
			
			if(dayLightTimer >= dayLength)
				asc = false;
			
			if(dayLightTimer <= 0)
			{
				dayCompte++;
				asc = true;
			}

			if(!FlxG.paused)
			{
				if(asc == false)
					dayLightTimer -= FlxG.elapsed;
				else
					dayLightTimer += FlxG.elapsed;
				
				globalTimer += FlxG.elapsed;
			}
			
			displayDay();
			dayLight();
			
			// portes
			
			if((room.getTile(lucie.x/32, lucie.y/32) == 2 && FlxG.keys.pressed("SPACE")) || (roomChoosed == "SalleBal" && (room.getTile(lucie.x/32, lucie.y/32) == 3 || room.getTile(lucie.x/32, lucie.y/32) == 4) && FlxG.keys.pressed("SPACE")))
			{
				var luX : int = lucie.x/32;
				var luY : int = lucie.y/32;
				trace(luX, luY);
				if(roomChoosed == "CaveVin" &&  luX == 18)
				{
					luc.revive();
				}
				
				gameSave.bind("myStorySave");
				
				gameSave.data.lightLucieStatus 	= lightLucieStatus;
				gameSave.data.dayLightTimer 	= dayLightTimer;
				gameSave.data.dayCompte 		= dayCompte;
				gameSave.data.asc 				= asc;
				gameSave.data.globalTimer		= globalTimer;
				gameSave.data.roomChoosed 		= roomChoosed;
				gameSave.data.luX 				= lucie.x/32;
				gameSave.data.luY 				= lucie.y/32;
				gameSave.data.clefs 			= clefs;
				gameSave.data.notes 			= notes;
				gameSave.data.events 			= events;
				
				room.portes(lucie.x/32,lucie.y/32);
			}
			
			// lumiere ON/OFF
			
			if(lightLucieStatus)
				lightLucie.revive();
			else
				lightLucie.kill();
				
			if (FlxG.keys.justPressed("SHIFT"))
				lightLucieStatus = !lightLucieStatus;
				
			// gameText

			if(updateText)
			{
				if(!textDisplayed)
				{
					textDisplayed = true;
					setGameText();
					FlxG.paused = true;
				}
				
				if(FlxG.keys.pressed("ENTER") || FlxG.keys.justPressed("SPACE"))
				{
					FlxG.paused = false;
					gameText.alpha = 0;
					textBox.alpha = 0;
					visage.alpha = 0;
					updateText = false;
					textDisplayed = false;
				}
			}
			
			//conditions défaite
			
			if(FlxG.overlap(lucie, monsters))
			{
				lucie.kill();
				gameSave.data.dayCompte++;
				FlxG.paused;
				FlxG.flash(0xffffffff, 1.5);
				FlxG.fade(0xFF000000, 1, switchGo);
			}
		}
		
		private function dayLight() : void
		{
			var teinte	: uint	= (dayLightTimer/dayLength) * 255;
			var color	: uint	= teinte | (teinte << 8) | (teinte << 16);
			for(var i : int = 0; i < fondsFenetres.length; i++)
			{
				var fond : FlxSprite = fondsFenetres[i];
				fond.color = color;
			}
			darkness.alpha = 1-(teinte/255);
		}
		
		private function displayDay() : void
		{
			text.text = "Day " + dayCompte;
		}
		
		private function switchGo() : void
		{
			FlxG.music.fadeOut(1);
			FlxG.switchState(new GameState("ChambreRosa", new FlxPoint(3,5)));
		}
		
		private function setGameText() : void
		{	
			if(textPos == "Dialogue")
			{
				textBox = new FlxSprite(FlxG.width/8, FlxG.height/2 + 190);
				textBox.makeGraphic(600, 100, 0xFF420404);
				gameText = new FlxText(textBox.x + 20, textBox.y + 20, textBox.width - 40, texte);				gameText.setFormat (null, 12, 0xFFFFFFFF, "left");
				visage = new FlxSprite();
				visage.alpha = 1;
			}
			
			if(textPos == "Centre")
			{
				textBox = new FlxSprite(FlxG.width/2 - 75, FlxG.height/2 - 70);
				textBox.makeGraphic(150, 30, 0xFF420404);
				gameText = new FlxText(textBox.x + 2, textBox.y + 2, textBox.width - 4, texte);
				gameText.setFormat (null, 8, 0xFFFFFFFF, "center");
			}
			
			if(textFace == "neutre")
			{
				visage.loadGraphic(vneutre);
				//visage = new FlxSprite(textBox.x+textBox.width, textBox.y, vneutre);
			}
			if(textFace == "peur")
			{
				visage.loadGraphic(vpeur);
				//visage = new FlxSprite(textBox.x+textBox.width, textBox.y, vpeur);
			}
			if(textFace == "sourir")
			{
				visage.loadGraphic(vsourire);
				//visage = new FlxSprite(textBox.x+textBox.width, textBox.y, vsourire);
			}
			if(textFace == "colere")
			{
				visage.loadGraphic(vcolere);
				//visage = new FlxSprite(textBox.x+textBox.width, textBox.y, vcolere);
			}
			
			textBox.scrollFactor.x = textBox.scrollFactor.y = 0;
			gameText.scrollFactor.x = gameText.scrollFactor.y = 0;
			
			visage.scrollFactor.x = visage.scrollFactor.y = 0;
			visage.x = FlxG.width/4 + 30;
			visage.y = 12;
			visage.scale.x = visage.scale.y = 0.2;
			
				
			add(textBox);
			add(gameText);
			if(textFace != "none")
				add(visage);
		}
		
		public function enigmes () : void
		{
			if(roomChoosed == "ChambreRosa" && room.getTile(lucie.x/32, lucie.y/32) == 2 && FlxG.keys.pressed("SPACE") && !clefs[2]) // première porte
			{
				textPos = "Dialogue";
				texte = "Je ne peux pas sortir sans mon doudou !";
				textFace = "neutre";
				updateText = true;
			}
			
			if(roomChoosed == "Couloir")
			{
				for(var i : int = 0; i < furnitures.members.length; i++) 					// enigme du zebre
				{
					var fur : FlxSprite = furnitures.members[i];
					var X : int = fur.x/32;
					var Y : int = fur.y/32;
					
					if( X == 48 && Y == 4)
					{
						room.setTile(49, 3, 2);
						room.setTile(50, 3, 2);
						room.setTile(51, 3, 2);
					}
				}
			}
			
			if(roomChoosed == "CaveVin")
			{
				for(i = 0; i < 11; i++) 					// enigme du baril
				{
					var furn : FlxSprite = furnitures.members[i];
					var X2 : int = furn.x/32;
					var Y2 : int = furn.y/32;
					
					if( X2 == 22 && Y2 == 22)
					{
						room.setTile(18, 37, 2);
						room.setTile(18, 36, 0);
						room.setTile(18, 35, 0);
						room.setTile(18, 34, 0);
					}
				}
			}
			//Events
			if(events[0] != true && roomChoosed == "Couloir2")
			{
				textPos = "Dialogue";
				texte = "Oh mon Dieu, qu'est-ce que c'est ? Un ... Un monstre ?!";
				textFace = "peur";
				updateText = true;
				events[0] = true;
			}
			
			if(events[1] != true && roomChoosed == "Grenier")
			{
				textPos = "Dialogue";
				texte = "Qu'est-ce qui se passe ? J'ai la tête qui tourne.";
				textFace = "peur";
				updateText = true;
				events[1] = true;
				FlxG.switchState(new PlayState("InGame", startCoo, roomChoosed));	
			}
			
			//notes
			if(FlxG.keys.pressed("ENTER"))
			{
				noteText.kill();
				luc.kill();
			}
			
			if(clefs[3] && !notes[3] && FlxG.keys.pressed("SPACE"))
			{
				noteText.text = "J’aurais voulu ne jamais dire cela. Je déteste l’entendre. Mais je me souviens. Oui je me souviens de cette jeunesse où j’étais maltraitée. Je n’existais pas aux yeux du monde. Même mes parents m’écrasaient. Je vivais quelque chose de grave et de douloureux, mais je l’acceptais. Pourquoi ? Je ne m’en suis rendu compte que bien plus tard.";
				noteText.scrollFactor.x = noteText.scrollFactor.y = 0;
				add(noteText);
				notes[3] = true;
				FlxG.paused;
			}
			
			if(clefs[5] && !notes[5] && FlxG.keys.pressed("SPACE"))
			{
				luc.loadGraphic(Journal1Img, false, false, FlxG.camera.width, FlxG.camera.height);
				luc.revive();
				notes[5] = true;
				FlxG.paused;
			}
			
			if(clefs[6] && !notes[6] && FlxG.keys.pressed("SPACE"))
			{
				luc.loadGraphic(Journal2Img, false, false, FlxG.camera.width, FlxG.camera.height);
				luc.revive();
				notes[6] = true;
				FlxG.paused;
			}
			
			if(clefs[7] && !notes[7] && FlxG.keys.pressed("SPACE"))
			{
				luc.loadGraphic(Journal3Img, false, false, FlxG.camera.width, FlxG.camera.height);
				luc.revive();
				notes[7] = true;
				FlxG.paused;
			}
			
			if(clefs[8] && !notes[8] && FlxG.keys.pressed("SPACE"))
			{
				luc.loadGraphic(Journal4Img, false, false, FlxG.camera.width, FlxG.camera.height);
				luc.revive();
				notes[8] = true;
				FlxG.paused;
			}
			
			if(clefs[9] && !notes[9] && FlxG.keys.pressed("SPACE"))
			{
				luc.loadGraphic(Journal5Img, false, false, FlxG.camera.width, FlxG.camera.height);
				luc.revive();
				notes[9] = true;
				FlxG.paused;
			}
			
			if(clefs[11] && !notes[11] && FlxG.keys.pressed("SPACE"))
			{
				luc.loadGraphic(Journal7Img, false, false, FlxG.camera.width, FlxG.camera.height);
				luc.revive();
				notes[11] = true;
				FlxG.paused;
			}
			
			if(clefs[10] && !notes[10] && FlxG.keys.pressed("SPACE"))
			{
				luc.loadGraphic(Journal6Img, false, false, FlxG.camera.width, FlxG.camera.height);
				luc.revive();
				notes[10] = true;
				FlxG.paused;
			}
		}
	}
}
