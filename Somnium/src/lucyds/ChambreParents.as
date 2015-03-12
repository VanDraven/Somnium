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
	public class ChambreParents extends Room 
	{	
		[Embed(source = "assets/img/salles/ChambreParents.png")] // change ici le chemin vers la tileStrip sol et murs
		public var tileStrip	: Class;
		[Embed(source = "assets/img/meuble/commode.png")] // change ici le chemin vers le meuble
		public var commodeImg	: Class;
		[Embed(source = "assets/img/meuble/meubleDessus.png")] // change ici le chemin vers le meuble
		public var meubleDessusImg	: Class;
		[Embed(source = "assets/img/meuble/tableau.png")] // change ici le chemin vers le meuble
		public var tableauImg	: Class;
		[Embed(source = "assets/img/meuble/litParents.png")] // change ici le chemin vers le meuble
		public var litImg	: Class;
		[Embed(source = "assets/img/meuble/tableNuitBougie.png")] // change ici le chemin vers le meuble
		public var tableNuitBougieImg	: Class;
		[Embed(source = "assets/img/meuble/tableNuitParents.png")] // change ici le chemin vers le meuble
		public var tableNuitParentsImg	: Class;
		
		
		public static var coffresFermes		: Array = new Array();
		public var roomStr 					: String;
		public var borderStr 				: String;
		private var meubles 				: FlxGroup = new FlxGroup();
		private var meublesSansColl 		: FlxGroup = new FlxGroup();
		private var meublesDev		 		: FlxGroup = new FlxGroup();
		private var lesCoffres		 		: FlxGroup = new FlxGroup();
		private var fenetres		 		: FlxGroup = new FlxGroup();
		private var lights					: FlxGroup = new FlxGroup();
		private var monstres		 		: FlxGroup = new FlxGroup();
		
		public function ChambreParents() 
		{
			// remplace la valeur de largeur par la largeur de la pièce en tiles
			var largeur : int = 15;
			
			// remplacer la valeur de roomStr (et enlève les sauts de lignes)
			roomStr ="1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,24,18,18,18,18,18,18,18,18,20,1,1,1,1,1,17,5,5,5,5,5,5,5,5,16,1,1,1,1,1,17,6,6,6,6,6,6,6,6,16,1,1,24,18,18,10,8,8,8,8,8,8,8,8,16,1,1,17,5,5,5,2,2,2,2,2,2,2,2,16,1,1,17,6,9,6,2,2,2,2,2,2,2,2,16,1,1,17,8,12,8,2,2,2,2,2,2,2,2,16,1,1,17,2,3,2,2,2,2,2,2,2,2,2,15,1,1,17,2,2,2,2,2,2,2,2,2,2,2,3,1,1,17,2,2,2,2,2,2,2,2,2,2,2,14,1,1,17,2,2,2,2,2,2,2,2,2,2,2,16,1,1,22,19,19,19,19,19,19,19,19,19,19,19,23,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";		
			meubles = meubler();
			meublesSansColl = meubler2();
			lesCoffres = coffres();
			fenetres = addFenetres();
			
			super(roomStr, tileStrip, largeur, meubles, meublesSansColl, meublesDev, lesCoffres, fenetres, coffresFermes, monstres, lights);
			
			setTileProperties(1, FlxObject.NONE); // collisions
			setTileProperties(2, FlxObject.NONE);
			setTileProperties(0, FlxObject.ANY);

			for(var i : int = 3; i < 23; i++)
				setTileProperties(i, FlxObject.ANY);
		}
		
		public function meubler() : FlxGroup
		{
			var lit : Meubles = new Meubles(6.25, 3, litImg, 80, 109, "un grand lit");
			lit.immovable = true;
			meubles.add(lit);
			
			var tableNuitParents : Meubles = new Meubles(5, 4, tableNuitParentsImg, 32, 47, "une table de nuit", true, "ClefPenderie");
			tableNuitParents.immovable = true;
			meubles.add(tableNuitParents);
			
			var tableNuitBougie : Meubles = new Meubles(9, 4, tableNuitBougieImg, 32, 47, "une table de nuit");
			tableNuitBougie.immovable = true;
			meubles.add(tableNuitBougie);
			
			var tableau : Meubles = new Meubles(10, 2, tableauImg, 96, 64, "un tableau");
			tableau.immovable = true;
			meubles.add(tableau);
			
			var commode : Meubles = new Meubles(11, 4, commodeImg, 64, 44, "une commode");
			commode.immovable = true;
			meubles.add(commode);
			
			var meubleDessus : Meubles = new Meubles(3, 11, meubleDessusImg, 96, 32, "une armoire");
			meubleDessus.immovable = true;
			meubles.add(meubleDessus);
			
			var meubleDessus2 : Meubles = new Meubles(9, 11, meubleDessusImg, 96, 32, "une armoire");
			meubleDessus2.immovable = true;
			meubles.add(meubleDessus2);
			
			return meubles;
		}
		
		public function meubler2() : FlxGroup
		{
//			var tapis : Meubles = new Meubles(6, 7, tapisImg, 132, 68, "");
//			tapis.immovable = true;
//			meublesSansColl.add(tapis);
//			
			return meublesSansColl;
		}
		
		public function addFenetres() : FlxGroup
		{
//			var fenetre : Meubles = new Meubles(6, 2, fenetreImg, 128, 96, "ma fenetre");
//			fenetre.immovable = true;
//			fenetres.add(fenetre);
			
			return fenetres;
		}
		
		override public function portes (X : int, Y : int) : void
		{		
			switch (X) {
				
				case(13): 		//coordonees porte X
				if(Y == 9)		//coordonees porte Y
					FlxG.switchState(new GameState("Couloir2", new FlxPoint(7,20)));
				break;
				
				case(3): 		//coordonees porte X
				if(Y == 8)		//coordonees porte Y
				{ 	
					//FlxG.switchState(new GameState("Couloir", new FlxPoint(1,9)));
					GameState.textPos = "Dialogue";
					GameState.texte = "Cette porte est fermée.";
					GameState.updateText = true;
				}
					
				break;
			}
		}
		
		public function coffres () : FlxGroup
		{
//			var coffre1 : Coffre = new Coffre(10.3, 4, this, 1, "doudou");
//			coffre1.immovable = true;
//			lesCoffres.add(coffre1);
			
			for (var i : int = 1; i <= lesCoffres.length; i++)
				if(coffresFermes[i] != false)
					coffresFermes[i] = true ;
			
			return lesCoffres;
		}
	}
}
