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
	public class Bibli extends Room 
	{	
		[Embed(source = "assets/img/salles/Bibliothèque.png")] // change ici le chemin vers la tileStrip sol et murs
		public var tileStrip	: Class;
		[Embed(source = "assets/img/meuble/bibliothèque.png")] // change ici le chemin vers le meuble
		public var bibliImg	: Class;
		[Embed(source = "assets/img/meuble/tableronde2.png")] // change ici le chemin vers le meuble
		public var tableImg	: Class;
		[Embed(source = "assets/img/meuble/fauteuil.png")] // change ici le chemin vers le meuble
		public var fauteuilImg	: Class;
		[Embed(source = "assets/img/meuble/petitebibliothèque2.png")] // change ici le chemin vers le meuble
		public var pBibliImg	: Class;
		[Embed(source = "assets/img/meuble/petitebibliothèque1.png")] // change ici le chemin vers le meuble
		public var pBibli2Img	: Class;
		[Embed(source = "assets/img/meuble/meublecoté.png")] // change ici le chemin vers le meuble
		public var meubleImg	: Class;
		
		
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
		
		public function Bibli() 
		{
			// remplace la valeur de largeur par la largeur de la pièce en tiles
			var largeur : int = 24;
			
			// remplacer la valeur de roomStr (et enlève les sauts de lignes)
			roomStr ="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,20,0,0,0,0,0,0,0,17,5,6,5,6,5,6,5,6,5,6,5,6,5,6,5,16,0,0,0,0,0,0,0,17,8,9,8,9,8,9,8,9,8,9,8,9,8,9,8,16,0,0,0,0,0,0,0,17,11,12,11,12,11,12,11,12,11,12,11,12,11,12,11,16,0,0,0,0,0,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,0,0,0,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,0,0,0,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,0,0,0,0,0,10,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,0,0,0,0,0,3,2,2,2,2,2,2,2,14,19,19,19,19,19,19,19,23,0,0,0,0,0,0,0,3,2,2,2,2,2,2,2,15,18,18,18,18,18,18,18,18,18,18,18,18,20,0,0,13,2,2,2,2,2,2,2,5,6,5,6,5,6,5,6,5,6,5,6,5,16,0,0,17,2,2,2,2,2,2,2,8,9,8,9,8,9,8,9,8,9,8,9,8,16,0,0,17,2,2,2,2,2,2,2,11,12,11,12,11,12,11,12,11,12,11,12,11,16,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,22,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,23,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
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
			var bibli : Meubles = new Meubles(2, 2.3, bibliImg, 64, 96, "une bibliothèque");
			bibli.immovable = true;
			meubles.add(bibli);
			
			var bibli2 : Meubles = new Meubles(4, 2.3, bibliImg, 64, 96, "une bibliothèque");
			bibli2.immovable = true;
			meubles.add(bibli2);
			
			var bibli3 : Meubles = new Meubles(6, 2.3, bibliImg, 64, 96, "une bibliothèque");
			bibli3.immovable = true;
			meubles.add(bibli3);
			
			var bibli4 : Meubles = new Meubles(8, 2.3, bibliImg, 64, 96, "une bibliothèque");
			bibli4.immovable = true;
			meubles.add(bibli4);
			
			var bibli5 : Meubles = new Meubles(10, 2.3, bibliImg, 64, 96, "une bibliothèque");
			bibli5.immovable = true;
			meubles.add(bibli5);
			
			var bibli6 : Meubles = new Meubles(12, 2.3, bibliImg, 64, 96, "une bibliothèque");
			bibli6.immovable = true;
			meubles.add(bibli6);
			
			var bibli7 : Meubles = new Meubles(14, 2.3, bibliImg, 64, 96, "une bibliothèque");
			bibli7.immovable = true;
			meubles.add(bibli7);
			
			var table : Meubles = new Meubles(6, 18, tableImg, 32, 32, "une table basse");
			table.immovable = true;
			meubles.add(table);
			
			var table2 : Meubles = new Meubles(16, 18, tableImg, 32, 32, "une table basse");
			table2.immovable = true;
			meubles.add(table2);
			
			var table3 : Meubles = new Meubles(5, 21, tableImg, 32, 32, "une table basse");
			table3.immovable = true;
			meubles.add(table3);
			
			var table4 : Meubles = new Meubles(18, 21, tableImg, 32, 32, "une table basse");
			table4.immovable = true;
			meubles.add(table4);
			
			var fauteuil : Meubles = new Meubles(20, 13, fauteuilImg, 32, 64, "un fauteuil");
			fauteuil.immovable = true;
			meubles.add(fauteuil);
			
			var pBibli : Meubles = new Meubles(9, 11.3, pBibliImg, 32, 96, "une bibliothèque");
			pBibli.immovable = true;
			meubles.add(pBibli);
			
			var pBibli2 : Meubles = new Meubles(13, 11.3, pBibli2Img, 32, 96, "une bibliothèque");
			pBibli2.immovable = true;
			meubles.add(pBibli2);
			
			var pBibli3 : Meubles = new Meubles(17, 11.3, pBibliImg, 32, 96, "une bibliothèque");
			pBibli3.immovable = true;
			meubles.add(pBibli3);
			
			var meuble : Meubles = new Meubles(16.3, 7, meubleImg, 22, 64, "une commode");
			meuble.immovable = true;
			meubles.add(meuble);
			
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
				
				case(1): 								//coordonees porte X
				if(Y == 9)					//coordonees porte Y
					FlxG.switchState(new GameState("RDC", new FlxPoint(43,10)));
				if(Y == 10)					//coordonees porte Y
					FlxG.switchState(new GameState("RDC", new FlxPoint(43,11)));
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