package lucyds {
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import lucyds.Room;

	/**
	 * @author DXPCorp
	 */
	public class Grenier extends Room 
	{	
		[Embed(source = "assets/img/salles/Grenier.png")] // change ici le chemin vers la tileStrip sol et murs
		public var tileStrip	: Class;
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
		
		public function Grenier() 
		{
			// remplace la valeur de largeur par la largeur de la pièce en tiles
			var largeur : int = 21;
			
			// remplacer la valeur de roomStr (et enlève les sauts de lignes)
			roomStr ="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,23,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,18,0,0,14,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,13,0,0,14,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,13,0,0,14,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,13,0,0,14,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,13,0,0,14,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,13,0,0,14,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,13,0,0,14,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,13,0,0,14,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,13,0,0,21,17,9,3,10,17,17,17,17,17,17,17,17,17,17,17,17,17,22,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
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
			for(var i : int = 4; i < 24; i++){
				setTileProperties(i, FlxObject.ANY);	
			}
			
		}
		
		public function meubler() : FlxGroup
		{
			if(GameState.clefs[8] != true)
			{
				var papier : Meubles = new Meubles(16, 7, papierImg, 12, 20, "une note", true, "journal4");
				papier.immovable = true;
				meubles.add(papier);
			}
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
				
				case(4): 								//coordonees porte X
				if(Y == 10)					//coordonees porte Y
					FlxG.switchState(new GameState("Couloir2", new FlxPoint(4,8)));
				break;
			}
		}
		
		public function coffres () : FlxGroup
		{
			
			var coffre1 : Coffre = new Coffre(17.3, 4, this, 3, "");
			coffre1.immovable = true;
			lesCoffres.add(coffre1);
			
			
			for (var i : int = 1; i <= lesCoffres.length; i++)
				if(coffresFermes[i] != false)
					coffresFermes[i] = true ;
			
			return lesCoffres;
		}
	}
}