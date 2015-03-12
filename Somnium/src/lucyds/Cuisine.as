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
	public class Cuisine extends Room 
	{	
		[Embed(source = "assets/img/salles/cuisine.png")] // change ici le chemin vers la tileStrip sol et murs
		public var tileStrip	: Class;
		[Embed(source = "assets/img/meuble/meublecuisine_évier.png")] // change ici le chemin vers le meuble
		public var evierImg	: Class;
		[Embed(source = "assets/img/meuble/cuisinière.png")] // change ici le chemin vers le meuble
		public var cuisineImg	: Class;
		[Embed(source = "assets/img/meuble/meublecuisine.png")] // change ici le chemin vers le meuble
		public var placardImg	: Class;
		[Embed(source = "assets/img/meuble/frigo.png")] // change ici le chemin vers le meuble
		public var frigoImg	: Class;
		[Embed(source = "assets/img/meuble/table.png")] // change ici le chemin vers le meuble
		public var tableImg	: Class;
		[Embed(source = "assets/img/papier.png")] // change ici le chemin vers le meuble
		public var papierImg	: Class;
		
		
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
		
		public function Cuisine() 
		{
			// remplace la valeur de largeur par la largeur de la pièce en tiles
			var largeur : int = 16;
			
			// remplacer la valeur de roomStr (et enlève les sauts de lignes)
			roomStr ="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,27,19,19,19,19,19,19,19,19,19,19,19,19,22,0,0,18,8,8,8,8,8,8,8,8,8,8,8,8,17,0,0,18,12,12,12,12,12,12,12,12,12,12,12,12,17,0,0,18,16,16,16,16,16,16,16,16,16,16,16,16,17,0,0,18,4,2,4,2,4,2,4,2,4,2,4,2,17,0,0,18,2,4,2,4,2,4,2,4,2,4,2,4,15,0,0,18,4,2,4,2,4,2,4,2,4,2,4,2,3,0,0,18,2,4,2,4,2,4,2,4,2,4,2,4,14,0,0,18,4,2,4,2,4,2,4,2,4,2,4,2,17,0,0,18,2,4,2,4,2,4,2,4,2,4,2,4,17,0,0,18,4,2,4,2,4,2,4,2,4,2,4,2,17,0,0,25,21,21,21,21,21,21,21,21,21,21,21,21,26,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
			meubles = meubler(); 			// Meubles normaux (armoires, bureaux, …)
			meublesSansColl = meubler2();	// Meubles sans collisions (tapis, …)
			lesCoffres = coffres();			// Coffres
			fenetres = addFenetres();		// Fenetres
			lights = addLight();			// Lumières (bougies, lampes, …)
			
			super(roomStr, tileStrip, largeur, meubles, meublesSansColl, meublesDev, lesCoffres, fenetres, coffresFermes, monstres, lights);
			
			setTileProperties(1, FlxObject.NONE); // collisions
			setTileProperties(2, FlxObject.NONE);
			setTileProperties(3, FlxObject.NONE);
			setTileProperties(0, FlxObject.ANY);
			for(var i : int = 4; i < 28; i++){
				setTileProperties(i, FlxObject.ANY);	
			}
			
		}
		
		public function meubler() : FlxGroup
		{
			if(GameState.clefs[7] != true)
			{
				var papier : Meubles = new Meubles(6, 5, papierImg, 12, 20, "une note", true, "journal3");
				papier.immovable = true;
				meubles.add(papier);
			}
			
			var evier : Meubles = new Meubles(4, 4.3, evierImg, 32, 32, "un évier");
			evier.immovable = true;
			meubles.add(evier);
			
			var cuisine : Meubles = new Meubles(7, 4.3, cuisineImg, 32, 32, "une cuisinière");
			cuisine.immovable = true;
			meubles.add(cuisine);
			
			var placard : Meubles = new Meubles(2, 4.3, placardImg, 32, 32, "un placard");
			placard.immovable = true;
			meubles.add(placard);
			
			var placard2 : Meubles = new Meubles(3, 4.3, placardImg, 32, 32, "un placard");
			placard2.immovable = true;
			meubles.add(placard2);
			
			var placard3 : Meubles = new Meubles(5, 4.3, placardImg, 32, 32, "un placard", true, "scie");
			placard3.immovable = true;
			meubles.add(placard3);
			
			var placard4 : Meubles = new Meubles(9, 4.3, placardImg, 32, 32, "un placard");
			placard4.immovable = true;
			meubles.add(placard4);
			
			var placard5 : Meubles = new Meubles(8, 4.3, placardImg, 32, 32, "un placard");
			placard5.immovable = true;
			meubles.add(placard5);
			
			var placard6 : Meubles = new Meubles(6, 4.3, placardImg, 32, 32, "un placard");
			placard6.immovable = true;
			meubles.add(placard6);
			
			var frigo : Meubles = new Meubles(11, 2.3, frigoImg, 64, 96, "un frigo");
			frigo.immovable = true;
			meubles.add(frigo);
			
			var table : Meubles = new Meubles(6, 7, tableImg, 96, 96, "une table");
			table.immovable = true;
			meubles.add(table);
			
			return meubles;
		}
		
		public function meubler2() : FlxGroup
		{
			
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
				
				case(14): 								//coordonees porte X
				if(Y == 7)					//coordonees porte Y
					FlxG.switchState(new GameState("RDC", new FlxPoint(6,21)));
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