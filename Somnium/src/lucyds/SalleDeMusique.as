package lucyds {
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import lucyds.Meubles;
	import org.flixel.FlxObject;
	import lucyds.Room;

	/**
	 * @author DXPCorp
	 */
	public class SalleDeMusique extends Room 
	{	
		[Embed(source = "assets/img/salles/SalleMusique.png")] // change ici le chemin vers la tileStrip sol et murs
		public var tileStrip	: Class;
		[Embed(source = "assets/img/meuble/harpe.png")] // change ici le chemin vers le meuble
		public var harpeImg	: Class;
		[Embed(source = "assets/img/meuble/fenetremusique.png")] // change ici le chemin vers le meuble
		public var fenetreImg	: Class;
		[Embed(source = "assets/img/meuble/partitionpleine.png")] // change ici le chemin vers le meuble
		public var pupitreImg	: Class;
		[Embed(source = "assets/img/meuble/Partitionvide.png")] // change ici le chemin vers le meuble
		public var pupitre1Img	: Class;
		[Embed(source = "assets/img/meuble/piano.png")] // change ici le chemin vers le meuble
		public var pianoImg	: Class;
		[Embed(source = "assets/img/meuble/Tabouret.png")] // change ici le chemin vers le meuble
		public var tabouretImg	: Class;
		[Embed(source = "assets/img/meuble/contrebassemusique.png")] // change ici le chemin vers le meuble
		public var contrebasseImg	: Class;
		
		
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
		
		public function SalleDeMusique() 
		{
			// remplace la valeur de largeur par la largeur de la pièce en tiles
			var largeur : int = 24;
			
			// remplacer la valeur de roomStr (et enlève les sauts de lignes)
			roomStr ="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,33,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,27,0,0,0,0,0,22,14,19,15,14,15,19,10,14,15,19,10,15,14,19,10,14,19,18,23,27,0,0,0,22,7,8,9,7,8,7,8,9,9,7,8,7,9,8,9,7,8,14,15,21,0,0,0,22,20,29,25,20,24,25,29,29,25,20,24,29,20,24,25,20,24,8,7,21,0,0,0,22,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,24,20,21,0,0,0,22,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,21,0,0,0,22,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,21,0,0,0,11,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,21,0,0,0,3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,21,0,0,0,3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,21,0,0,0,16,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,21,0,0,0,22,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,21,0,0,0,22,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,21,0,0,0,22,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,21,0,0,0,22,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,21,0,0,0,22,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,21,0,0,0,22,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,21,0,0,0,22,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,21,0,0,0,31,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
			meubles = meubler(); 			// Meubles normaux (armoires, bureaux, …)
			meublesSansColl = meubler2();	// Meubles sans collisions (tapis, …)
			lesCoffres = coffres();			// Coffres
			fenetres = addFenetres();		// Fenetres
			lights = addLight();			// Lumières (bougies, lampes, …)
			
			super(roomStr, tileStrip, largeur, meubles, meublesSansColl, meublesDev, lesCoffres, fenetres, coffresFermes, monstres, lights);
			
			setTileProperties(1, FlxObject.NONE); // collisions
			setTileProperties(2, FlxObject.NONE);
			setTileProperties(3, FlxObject.NONE);
			setTileProperties(4, FlxObject.NONE);
			setTileProperties(0, FlxObject.ANY);
			for(var i : int = 5; i < 33; i++){
				setTileProperties(i, FlxObject.ANY);	
			}
			
		}
		
		public function meubler() : FlxGroup
		{
			var harpe : Meubles = new Meubles(3, 3.5, harpeImg, 58, 74, "une harpe");
			harpe.immovable = true;
			meubles.add(harpe);
			
			var pupitre1 : Meubles = new Meubles(12, 13, pupitreImg, 29, 55, "un pupitre");
			pupitre1.immovable = true;
			meubles.add(pupitre1);
			
			var pupitre2 : Meubles = new Meubles(7, 14, pupitre1Img, 29, 54, "un pupitre");
			pupitre2.immovable = true;
			meubles.add(pupitre2);
			
			var pupitre3 : Meubles = new Meubles(5, 16, pupitre1Img, 29, 54, "un pupitre");
			pupitre3.immovable = true;
			meubles.add(pupitre3);
			
			var pupitre4 : Meubles = new Meubles(17, 14, pupitre1Img, 29, 54, "un pupitre");
			pupitre4.immovable = true;
			meubles.add(pupitre4);
			
			var pupitre5 : Meubles = new Meubles(19, 16, pupitre1Img, 29, 54, "un pupitre");
			pupitre5.immovable = true;
			meubles.add(pupitre5);
			
			var piano : Meubles = new Meubles(18, 8, pianoImg, 110, 121, "un piano");
			piano.immovable = true;
			meubles.add(piano);
			
			var tabouret : Meubles = new Meubles(5, 5, tabouretImg, 28, 29, "un tabouret");
			tabouret.immovable = true;
			meubles.add(tabouret);
			
			var tabouret2 : Meubles = new Meubles(16, 10, tabouretImg, 28, 29, "un tabouret");
			tabouret2.immovable = true;
			meubles.add(tabouret2);
			
			var contre : Meubles = new Meubles(19, 3.5, contrebasseImg, 24, 58, "une contrebasse");
			contre.immovable = true;
			meubles.add(contre);
			
			return meubles;
		}
		
		public function meubler2() : FlxGroup
		{
			
			
			return meublesSansColl;
		}
		
		public function addFenetres() : FlxGroup
		{
			var fenetre : Meubles = new Meubles(7, 2, fenetreImg, 32, 64, "une fenetre");
			fenetre.immovable = true;
			fenetres.add(fenetre);
			
			var fenetre2 : Meubles = new Meubles(11, 2, fenetreImg, 32, 64, "une fenetre");
			fenetre2.immovable = true;
			fenetres.add(fenetre2);
			
			var fenetre3 : Meubles = new Meubles(15, 2, fenetreImg, 32, 64, "une fenetre");
			fenetre3.immovable = true;
			fenetres.add(fenetre3);
			
			return fenetres;
		}
		
		public function addLight() : FlxGroup
		{
			
			
			return lights;
		}
		
		override public function portes (X : int, Y : int) : void
		{		
			switch (X) {
				
				case(2): 								//coordonees porte X
				if(Y == 9)					//coordonees porte Y
					FlxG.switchState(new GameState("Couloir1", new FlxPoint(44,9)));
				if(Y == 10)					//coordonees porte Y
					FlxG.switchState(new GameState("Couloir1", new FlxPoint(44,10)));
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
	}
}
