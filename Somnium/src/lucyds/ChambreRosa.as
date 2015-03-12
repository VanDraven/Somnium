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
	public class ChambreRosa extends Room 
	{	
		[Embed(source = "assets/img/salles/ChambreRosa.png")] // change ici le chemin vers la tileStrip sol et murs
		public var tileStrip	: Class;
		[Embed(source = "assets/img/meuble/FenetreRosa.png")] // change ici le chemin vers le meuble
		public var fenetreImg	: Class;
		[Embed(source = "assets/img/meuble/tapisRosa.png")] // change ici le chemin vers le meuble
		public var tapisImg	: Class;
		[Embed(source = "assets/img/meuble/litRosa.png")] // change ici le chemin vers le meuble
		public var litImg	: Class;
		[Embed(source = "assets/img/meuble/tableRosa.png")] // change ici le chemin vers le meuble
		public var tableImg	: Class;
		[Embed(source = "assets/img/meuble/plancheRosaBas.png")] // change ici le chemin vers le meuble
		public var plancheBasImg	: Class;
		[Embed(source = "assets/img/meuble/plancheRosahaut.png")] // change ici le chemin vers le meuble
		public var plancheHautImg	: Class;
		[Embed(source = "assets/img/meuble/meubleDessus.png")] // change ici le chemin vers le meuble
		public var meubleDessusImg	: Class;
		
		
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
		
		public function ChambreRosa() 
		{
			// remplace la valeur de largeur par la largeur de la pièce en tiles
			var largeur : int = 14;
			
			// remplacer la valeur de roomStr (et enlève les sauts de lignes)
			roomStr ="1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,18,12,12,12,12,12,12,12,12,12,12,14,1,1,11,4,4,4,4,0,0,0,0,4,4,10,1,1,11,5,5,5,5,0,0,0,0,5,5,10,1,1,11,6,6,6,6,0,0,0,0,6,6,10,1,1,11,2,2,2,2,2,2,2,2,2,2,9,1,1,11,2,2,2,2,2,2,2,2,2,2,3,1,1,11,2,2,2,2,2,2,2,2,2,2,8,1,1,11,2,2,2,2,2,2,2,2,2,2,10,1,1,11,2,2,2,2,2,2,2,2,2,2,10,1,1,16,13,13,13,13,13,7,3,8,13,13,17,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";		
			
			meubles = meubler(); 			// Meubles normaux (armoires, bureaux, …)
			meublesSansColl = meubler2();	// Meubles sans collisions (tapis, …)
			lesCoffres = coffres();			// Coffres
			fenetres = addFenetres();		// Fenetres
			lights = addLight();			// Lumières (bougies, lampes, …)
			
			super(roomStr, tileStrip, largeur, meubles, meublesSansColl, meublesDev, lesCoffres, fenetres, coffresFermes, monstres, lights);
			
			setTileProperties(1, FlxObject.NONE); // collisions
			setTileProperties(2, FlxObject.NONE);
			setTileProperties(0, FlxObject.ANY);
			setTileProperties(3, FlxObject.ANY);
			setTileProperties(4, FlxObject.ANY);
			setTileProperties(5, FlxObject.ANY);	
		}
		
		public function meubler() : FlxGroup
		{
			var lit : Meubles = new Meubles(7.4, 4, litImg, 40, 89, "mon lit");
			lit.immovable = true;
			meubles.add(lit);
			
			var table : Meubles = new Meubles(6, 4, tableImg, 31, 46, "ma table de nuit", true, "ClefPenderie");
			table.immovable = true;
			meubles.add(table);
			
			var plancheBas : Meubles = new Meubles(2, 4, plancheBasImg, 96, 32, "mes etageres");
			plancheBas.immovable = true;
			meubles.add(plancheBas);
			
			var plancheHaut : Meubles = new Meubles(2, 3, plancheHautImg, 96, 32, "mes etageres");
			plancheHaut.immovable = true;
			meubles.add(plancheHaut);
			
			var meubleDessus : Meubles = new Meubles(9, 9, meubleDessusImg, 96, 32, "une armoire");
			meubleDessus.immovable = true;
			meubles.add(meubleDessus);
			
			return meubles;
		}
		
		public function meubler2() : FlxGroup
		{
			var tapis : Meubles = new Meubles(6, 7, tapisImg, 132, 68, "");
			tapis.immovable = true;
			meublesSansColl.add(tapis);
			
			return meublesSansColl;
		}
		
		public function addFenetres() : FlxGroup
		{
			var fenetre : Meubles = new Meubles(6, 2, fenetreImg, 128, 96, "ma fenetre");
			fenetre.immovable = true;
			fenetres.add(fenetre);
			
			return fenetres;
		}
		
		public function addLight() : FlxGroup
		{
			var table : Meubles = new Meubles(6, 4, tableImg, 31, 46, "ma table de nuit", true, "ClefPenderie");
			table.immovable = true;
			lights.add(table);
			
			return lights;
		}
		
		override public function portes (X : int, Y : int) : void
		{		
			switch (X) {
				
				case(12): 								//coordonees porte X
				if(Y == 6 && GameState.clefs[2])		//coordonees porte Y
					FlxG.switchState(new GameState("Couloir2", new FlxPoint(7,13)));
				break;
				
				case(8): 													//coordonees porte X
				if(Y == 10 && GameState.clefs[0] && GameState.clefs[2])		//coordonees porte Y + clef nécessaire
					FlxG.switchState(new GameState("Penderie", new FlxPoint(7,5)));
				if(Y == 10 && GameState.clefs[2])
				{
					GameState.textPos = "Dialogue";
					GameState.texte = "Cette porte est fermée.";
					GameState.updateText = true;
				}
				break;
			}
		}
		
		public function coffres () : FlxGroup
		{
			var coffre1 : Coffre = new Coffre(10.3, 4, this, 1, "doudou");
			coffre1.immovable = true;
			lesCoffres.add(coffre1);
			
			for (var i : int = 1; i <= lesCoffres.length; i++)
				if(coffresFermes[i] != false)
					coffresFermes[i] = true ;
			
			return lesCoffres;
		}
	}
}
