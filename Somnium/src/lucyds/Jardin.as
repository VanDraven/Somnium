package lucyds {
	import org.flixel.FlxPath;
	import org.flixel.FlxSprite;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import lucyds.Meubles;
	import org.flixel.FlxObject;
	import lucyds.Room;

	/**
	 * @author DXPCorp
	 */
	public class Jardin extends Room 
	{	
		[Embed(source = "assets/img/salles/jardin.png")] // change ici le chemin vers la tileStrip sol et murs
		public var tileStrip	: Class;
		[Embed(source = "assets/img/meuble/arbre6.png")] // change ici le chemin vers le meuble
		public var arbre1Img	: Class;
		[Embed(source = "assets/img/meuble/arbre5.png")] // change ici le chemin vers le meuble
		public var arbre2Img	: Class;
		[Embed(source = "assets/img/meuble/chemin.png")] // change ici le chemin vers le meuble
		public var cheminImg	: Class;
		[Embed(source = "assets/img/meuble/CheminBoue.png")] // change ici le chemin vers le meuble
		public var boueImg	: Class;
		[Embed(source = "assets/img/meuble/barriereGauche.png")] // change ici le chemin vers le meuble
		public var barriereGImg	: Class;
		[Embed(source = "assets/img/meuble/barriereDroite.png")] // change ici le chemin vers le meuble
		public var barriereDImg	: Class;
		[Embed(source = "assets/img/meuble/buisson.png")] // change ici le chemin vers le meuble
		public var buissonImg	: Class;
		
		
		public static var coffresFermes		: Array = new Array();
		public var roomStr 					: String;
		public var borderStr 				: String;
		private var meubles 				: FlxGroup = new FlxGroup();
		private var meublesSansColl 		: FlxGroup = new FlxGroup();
		private var meublesDev			 	: FlxGroup = new FlxGroup();
		private var lesCoffres		 		: FlxGroup = new FlxGroup();
		private var fenetres		 		: FlxGroup = new FlxGroup();
		private var lights		 			: FlxGroup = new FlxGroup();
		private var monstres		 		: FlxGroup = new FlxGroup();
		
		public function Jardin() 
		{
			// remplace la valeur de largeur par la largeur de la pièce en tiles
			var largeur : int = 38;
			
			// remplacer la valeur de roomStr (et enlève les sauts de lignes)
			roomStr ="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,51,35,35,42,0,0,0,0,0,0,51,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,42,0,0,34,14,14,33,0,0,0,0,0,0,34,6,7,8,6,7,8,6,7,8,6,7,8,6,7,8,6,7,8,6,7,8,14,14,14,33,0,0,34,14,14,33,0,0,0,0,0,0,34,14,15,16,14,15,16,14,15,16,14,15,16,14,15,16,14,15,16,14,15,16,6,7,14,33,0,0,34,14,14,33,0,0,0,0,0,0,34,6,7,8,6,7,8,6,7,8,6,7,8,15,15,15,6,7,8,6,7,8,14,14,16,33,0,0,34,14,14,27,35,35,35,35,35,35,17,14,15,16,14,15,16,14,15,16,14,15,16,6,7,8,14,15,16,14,15,16,14,14,8,33,0,0,34,14,14,20,22,23,20,20,22,23,20,6,7,8,6,7,14,14,14,14,14,14,8,8,15,16,8,8,8,6,7,14,14,15,16,33,0,0,34,14,14,20,30,31,20,21,30,31,20,14,15,16,14,15,16,14,15,8,14,15,14,8,8,8,6,14,14,14,14,16,6,7,8,33,0,0,34,14,14,20,20,20,20,29,20,20,20,6,7,8,6,7,8,6,15,15,15,15,8,14,14,14,14,15,16,8,15,15,14,15,16,33,0,0,34,6,7,8,6,7,8,3,7,8,8,14,15,16,14,15,16,14,15,15,15,15,8,8,7,14,8,8,15,8,7,8,6,7,8,33,0,0,34,14,15,16,14,14,14,14,14,14,14,6,7,8,6,7,8,6,8,8,8,8,16,8,8,16,14,14,8,8,8,8,14,15,16,33,0,0,34,14,14,14,14,14,8,8,6,14,14,14,15,16,15,8,14,14,14,14,15,15,8,8,15,8,8,8,14,8,8,8,8,7,8,33,0,0,34,6,7,14,14,14,14,14,14,14,8,6,7,8,8,14,14,15,15,14,8,6,7,8,15,7,8,8,15,14,14,14,14,15,16,33,0,0,34,14,15,8,8,8,8,8,8,8,14,14,14,15,14,14,14,14,14,14,14,8,8,8,14,15,6,8,8,8,14,14,8,7,8,33,0,0,34,6,7,8,8,8,7,8,8,14,8,8,15,14,6,8,14,15,8,8,14,8,8,6,7,8,14,8,16,14,8,14,14,15,16,33,0,0,34,14,15,8,8,14,15,8,14,15,16,14,8,14,8,15,14,8,8,8,14,14,16,14,15,8,8,8,8,14,14,14,6,7,8,33,0,0,34,6,8,8,8,14,14,14,8,6,7,8,6,8,14,8,14,8,15,8,14,14,7,8,6,7,8,14,15,14,14,14,14,15,16,33,0,0,34,14,15,16,14,14,8,8,8,8,8,8,14,14,14,14,14,8,8,8,16,14,15,16,14,15,16,26,41,41,41,41,41,41,41,50,0,0,34,6,7,14,14,14,14,14,14,14,14,14,14,14,8,14,14,14,7,8,6,14,8,6,7,8,14,33,0,0,0,0,0,0,0,0,0,0,34,14,15,14,15,14,15,15,15,14,14,14,14,14,14,14,14,14,15,16,14,15,16,14,15,16,14,33,0,0,0,0,0,0,0,0,0,0,34,15,15,6,14,8,14,14,14,14,14,14,14,14,14,14,14,14,8,8,8,6,7,8,6,7,14,33,0,0,0,0,0,0,0,0,0,0,34,15,15,14,14,16,14,14,14,14,14,15,14,14,14,14,14,14,14,15,8,8,15,16,14,15,14,33,0,0,0,0,0,0,0,0,0,0,34,15,14,8,14,14,14,8,14,14,14,14,8,14,14,14,14,14,14,8,7,8,8,7,8,14,14,33,0,0,0,0,0,0,0,0,0,0,34,14,14,14,14,14,14,14,8,14,14,14,14,14,14,14,8,15,14,14,8,8,14,8,16,14,8,33,0,0,0,0,0,0,0,0,0,0,34,14,14,6,14,14,14,14,15,14,15,15,14,14,14,14,7,8,14,14,14,14,8,14,14,15,8,33,0,0,0,0,0,0,0,0,0,0,34,14,14,14,14,16,14,15,14,14,14,14,14,14,14,14,14,8,8,14,14,14,14,14,14,14,8,33,0,0,0,0,0,0,0,0,0,0,34,14,14,14,6,7,8,6,7,8,6,15,14,14,14,14,6,14,14,15,8,14,14,14,15,14,8,33,0,0,0,0,0,0,0,0,0,0,34,14,15,16,14,15,16,14,15,15,15,15,16,14,15,16,14,15,16,8,15,16,14,14,14,14,8,33,0,0,0,0,0,0,0,0,0,0,34,14,14,15,7,8,6,15,15,6,7,8,6,7,8,6,7,8,6,8,8,8,15,15,14,14,8,33,0,0,0,0,0,0,0,0,0,0,34,14,14,15,15,15,15,15,16,14,15,16,14,15,16,14,15,16,14,15,16,8,8,16,14,14,8,33,0,0,0,0,0,0,0,0,0,0,34,6,7,8,6,7,8,6,7,8,6,7,8,6,7,8,6,7,8,6,7,8,8,8,8,14,14,33,0,0,0,0,0,0,0,0,0,0,34,14,15,16,14,15,16,14,15,16,14,15,16,14,15,16,14,15,16,14,15,16,14,15,16,14,14,33,0,0,0,0,0,0,0,0,0,0,34,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,33,0,0,0,0,0,0,0,0,0,0,34,2,13,4,11,2,4,13,4,12,2,11,10,4,11,2,13,11,2,13,12,11,2,12,10,4,13,33,0,0,0,0,0,0,0,0,0,0,34,10,11,11,13,10,4,13,11,11,11,10,13,2,13,4,11,10,11,11,11,4,4,13,11,12,10,33,0,0,0,0,0,0,0,0,0,0,34,11,2,4,11,10,4,10,2,13,10,10,11,11,13,10,11,4,4,4,10,12,13,4,4,2,11,33,0,0,0,0,0,0,0,0,0,0,34,13,4,13,4,13,2,10,11,13,11,3,3,3,3,11,2,10,10,11,10,2,11,4,10,10,12,33,0,0,0,0,0,0,0,0,0,0,49,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
			meubles = meubler(); 			// Meubles normaux (armoires, bureaux, …)
			meublesSansColl = meubler2();	// Meubles sans collisions (tapis, …)
			lesCoffres = coffres();			// Coffres
			fenetres = addFenetres();		// Fenetres
			lights = addLight();			// Lumières (bougies, lampes, …)
			
			super(roomStr, tileStrip, largeur, meubles, meublesSansColl, meublesDev, lesCoffres, fenetres, coffresFermes, monstres, lights);
			
			setTileProperties(0, FlxObject.ANY);
			for(var i : int = 1; i < 16; i++)
			{
				setTileProperties(i, FlxObject.NONE);
			}
			for(i = 16; i < 55; i++){
				setTileProperties(i, FlxObject.ANY);	
			}
			monstres = spawnMonsters();	
		}
		
		public function meubler() : FlxGroup
		{
			var arbre1 : Meubles = new Meubles(22, 4, arbre1Img, 64, 96, "un arbre");
			arbre1.immovable = true;
			meubles.add(arbre1);
			
			var arbre2 : Meubles = new Meubles(32, 3, arbre2Img, 64, 96, "un arbre mort");
			arbre2.immovable = true;
			meubles.add(arbre2);
			
			var arbre3 : Meubles = new Meubles(31, 10, arbre1Img, 64, 96, "un arbre");
			arbre3.immovable = true;
			meubles.add(arbre3);
			
			var arbre4 : Meubles = new Meubles(15, 4, arbre1Img, 64, 96, "un arbre");
			arbre4.immovable = true;
			meubles.add(arbre4);
			
			var arbre5 : Meubles = new Meubles(3, 21, arbre2Img, 64, 96, "un arbre mort");
			arbre5.immovable = true;
			meubles.add(arbre5);
			
			var barriereG : Meubles = new Meubles(2, 17, barriereGImg, 320, 50, "une barrière");
			barriereG.immovable = true;
			meubles.add(barriereG);
			
			var barriereD : Meubles = new Meubles(15, 17, barriereDImg, 416, 50,  "une barrière");
			barriereD.immovable = true;
			meubles.add(barriereD);
			
			var buisson : Meubles = new Meubles(12, 18, buissonImg, 96, 50, "un buisson");
			buisson.immovable = true;
			//meubles.add(buisson);
			
			return meubles;
		}
		
		public function meubler2() : FlxGroup
		{
			var chemin : Meubles = new Meubles(11, 20, cheminImg, 224, 384, "");
			chemin.immovable = true;
			meublesSansColl.add(chemin);
			
			var boue : Meubles = new Meubles(7, 9, boueImg, 256, 352, "");
			boue.immovable = true;
			meublesSansColl.add(boue);
			
			return meublesSansColl;
		}
		
		public function addFenetres() : FlxGroup
		{
			
			return fenetres;
		}
		
		public function addLight() : FlxGroup
		{
			
			return lights;
		}
		
		override public function portes (X : int, Y : int) : void
		{		
			switch (X) {
				
				case(8): 								//coordonees porte X
				if(Y == 9)		//coordonees porte Y
					FlxG.switchState(new GameState("Cabane", new FlxPoint(6,9)));
				break;
				
				case(12): 													//coordonees porte X
				if(Y == 36)		//coordonees porte Y + clef nécessaire
					FlxG.switchState(new GameState("SalleBal", new FlxPoint(24,6)));
				break;
				
				case(13): 													//coordonees porte X
				if(Y == 36)		//coordonees porte Y + clef nécessaire
					FlxG.switchState(new GameState("SalleBal", new FlxPoint(25,6)));
				break;
				
				case(14): 													//coordonees porte X
				if(Y == 36)		//coordonees porte Y + clef nécessaire
					FlxG.switchState(new GameState("SalleBal", new FlxPoint(26,6)));
				break;
				
				case(15): 													//coordonees porte X
				if(Y == 36)		//coordonees porte Y + clef nécessaire
					FlxG.switchState(new GameState("SalleBal", new FlxPoint(27,6)));
				break;
			}
		}
		
		public function coffres () : FlxGroup
		{
			
			for (var i : int = 1; i <= lesCoffres.length; i++)
				if(coffresFermes[i] != false)
					coffresFermes[i] = true ;
			
			return lesCoffres;
		}
		
		public function spawnMonsters() : FlxGroup
		{
			var monsterX	: int = 0;
			var monsterY	: int = 0;
			var monstre4	: FlxSprite;
			var chemin4 	: FlxPath 		= new FlxPath();
			while(getTile(monsterX, monsterY) < 8 || getTile(monsterX, monsterY) > 15){
				monsterX = FlxG.random()*38;
				monsterY = FlxG.random()*39;
			}
			monstre4 = new BigMonstres(monsterX, monsterY, chemin4, this, false, true);
			
			monstres.add(monstre4);
			
			var enemy : BigMonstres;
			for(var i : int = 0; i <10; i++)
			{
				enemy = recycleEnemy();
			}
			//enemy.reset(X, Y);
			
			return monstres;
		}
		
		private function recycleEnemy():BigMonstres
		{
			// Get the first available Enemy instance from group. You cast it to Enemy because you will get a FlxObject.
			var enemy:BigMonstres = monstres.getFirstAvailable() as BigMonstres;
			
			// Check if the instance is null because if there is no enemy instance with dead = true property, it will return null.
			if (enemy == null)
			{
				// If it is null, you create a new instance because you have no other choice.
				var monsterX	: int = 0;
				var monsterY	: int = 0;
				var chemin 	: FlxPath 		= new FlxPath();
				while(getTile(monsterX, monsterY) < 8 || getTile(monsterX, monsterY) > 15){
					monsterX = FlxG.random()*38;
					monsterY = FlxG.random()*39;
				}
				var newEnemy:BigMonstres = new BigMonstres(monsterX, monsterY, chemin, this, false, true);
				monstres.add(newEnemy);
				return newEnemy; // When you return the newly created instance, your function ends here. It will not execute the lines below.
			}
			
			// If not null, you return the first available instance.
			return enemy;
		}
	}
}