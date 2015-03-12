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
	public class Bureau extends Room 
	{	
		[Embed(source = "assets/img/salles/Bureau.png")] // change ici le chemin vers la tileStrip sol et murs
		public var tileStrip	: Class;
		[Embed(source = "assets/img/meuble/bibliothèque.png")] // change ici le chemin vers le meuble
		public var bibliImg	: Class;
		[Embed(source = "assets/img/meuble/bureau.png")] // change ici le chemin vers le meuble
		public var bureauImg	: Class;
		[Embed(source = "assets/img/meuble/fauteuil.png")] // change ici le chemin vers le meuble
		public var fauteuilImg	: Class;
		[Embed(source = "assets/img/meuble/petitebibliothèque2.png")] // change ici le chemin vers le meuble
		public var pBibliImg	: Class;
		[Embed(source = "assets/img/meuble/petitebibliothèque1.png")] // change ici le chemin vers le meuble
		public var pBibli2Img	: Class;
		[Embed(source = "assets/img/meuble/meublecoté.png")] // change ici le chemin vers le meuble
		public var meubleImg	: Class;
		[Embed(source = "assets/img/meuble/tapis.png")] // change ici le chemin vers le meuble
		public var tapisImg	: Class;
		
		
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
		
		public function Bureau() 
		{
			// remplace la valeur de largeur par la largeur de la pièce en tiles
			var largeur : int = 17;
			
			// remplacer la valeur de roomStr (et enlève les sauts de lignes)
			roomStr ="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24,18,18,18,18,18,18,18,18,18,20,0,0,0,0,0,0,17,5,6,5,6,5,6,5,6,5,16,0,0,0,0,0,0,17,8,4,8,9,8,9,8,9,8,16,0,0,0,0,0,0,17,11,7,11,12,11,12,11,12,11,16,0,0,0,0,0,0,17,2,3,2,2,2,2,2,2,2,16,0,0,0,0,0,0,17,2,2,2,2,2,2,2,2,2,16,0,0,0,0,0,0,17,2,2,2,2,2,2,2,2,2,16,0,0,0,0,0,0,17,2,2,2,2,2,2,2,2,2,16,0,0,24,18,18,18,10,2,2,2,2,2,2,2,2,2,16,0,0,17,5,6,5,6,2,2,2,2,2,2,2,2,2,16,0,0,17,8,9,8,9,2,2,2,2,2,2,2,2,2,16,0,0,17,11,12,11,12,2,2,2,2,2,2,2,2,2,16,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,22,19,19,19,19,19,19,19,19,19,19,19,19,19,23,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
			meubles = meubler(); 			// Meubles normaux (armoires, bureaux, …)
			meublesSansColl = meubler2();	// Meubles sans collisions (tapis, …)
			lesCoffres = coffres();			// Coffres
			fenetres = addFenetres();		// Fenetres
			lights = addLight();			// Lumières (bougies, lampes, …)
			
			super(roomStr, tileStrip, largeur, meubles, meublesSansColl, meublesDev, lesCoffres, fenetres, coffresFermes, monstres, lights);
			
			setTileProperties(1, FlxObject.NONE); // collisions
			setTileProperties(2, FlxObject.NONE);
			setTileProperties(0, FlxObject.ANY);
			for(var i : int = 3; i < 24; i++){
				setTileProperties(i, FlxObject.ANY);	
			}
			
		}
		
		public function meubler() : FlxGroup
		{
			var bibli : Meubles = new Meubles(9, 2, bibliImg, 64, 96, "une bibliothèque");
			bibli.immovable = true;
			meubles.add(bibli);
			
			var bibli2 : Meubles = new Meubles(13, 2, bibliImg, 64, 96, "une bibliothèque");
			bibli2.immovable = true;
			meubles.add(bibli2);
			
			var bureau : Meubles = new Meubles(9, 10, bureauImg, 64, 32, "un bureau");
			bureau.immovable = true;
			meubles.add(bureau);
			
			var fauteuil : Meubles = new Meubles(10, 8.1, fauteuilImg, 32, 64, "un fauteuil");
			fauteuil.immovable = true;
			meubles.add(fauteuil);
			
			var pBibli : Meubles = new Meubles(5, 10, pBibliImg, 32, 96, "une bibliothèque");
			pBibli.immovable = true;
			meubles.add(pBibli);
			
			var pBibli2 : Meubles = new Meubles(2, 10, pBibli2Img, 32, 96, "une bibliothèque");
			pBibli2.immovable = true;
			meubles.add(pBibli2);
			
			var meuble : Meubles = new Meubles(14.3, 12, meubleImg, 22, 64, "une commode");
			meuble.immovable = true;
			meubles.add(meuble);
			
			return meubles;
		}
		
		public function meubler2() : FlxGroup
		{
			var tapis : Meubles = new Meubles(8, 8, tapisImg, 128, 128, "un tapis");
			tapis.immovable = true;
			meublesSansColl.add(tapis);
			
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
				
				case(7): 								//coordonees porte X
				if(Y == 5)					//coordonees porte Y
					FlxG.switchState(new GameState("Couloir1", new FlxPoint(5,10)));
				break;
			}
		}
		
		public function coffres () : FlxGroup
		{
			
			var coffre1 : Coffre = new Coffre(3.3, 12, this, 2, "");
			coffre1.immovable = true;
			lesCoffres.add(coffre1);
			
			for (var i : int = 1; i <= lesCoffres.length; i++)
				if(coffresFermes[i] != false)
					coffresFermes[i] = true ;
			
			return lesCoffres;
		}
	}
}