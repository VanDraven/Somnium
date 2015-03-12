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
	public class Penderie extends Room 
	{	
		[Embed(source = "assets/img/salles/penderie.png")] // change ici le chemin vers la tileStrip sol et murs
		public var tileStrip	: Class;
		[Embed(source = "assets/img/meuble/dressing.png")] // change ici le chemin vers le meuble
		public var dressingImg	: Class;
		[Embed(source = "assets/img/meuble/commode.png")] // change ici le chemin vers le meuble
		public var commodeImg	: Class;
		[Embed(source = "assets/img/meuble/meubleDessus.png")] // change ici le chemin vers le meuble
		public var meubleDessusImg	: Class;
		[Embed(source = "assets/img/papier.png")] // change ici le chemin vers le meuble
		public var papierImg	: Class;
		
		
		public static var coffresFermes		: Array = new Array();
		public var roomStr 					: String;
		public var borderStr 				: String;
		private var meubles 				: FlxGroup = new FlxGroup();
		private var meublesSansColl 		: FlxGroup = new FlxGroup();
		private var meublesDev		 		: FlxGroup = new FlxGroup();
		private var lesCoffres		 		: FlxGroup = new FlxGroup();
		private var fenetres		 		: FlxGroup = new FlxGroup();
		private var lights			 		: FlxGroup = new FlxGroup();
		private var monstres		 		: FlxGroup = new FlxGroup();
		
		public function Penderie() 
		{
			// remplace la valeur de largeur par la largeur de la pièce en tiles
			var largeur : int = 12;
			
			// remplacer la valeur de roomStr (et enlève les sauts de lignes)
			roomStr ="0,0,0,0,0,0,0,0,0,0,0,0,0,18,9,9,9,9,9,9,9,9,14,0,0,8,4,4,4,4,4,4,4,4,7,0,0,8,5,5,5,5,5,12,5,5,7,0,0,8,6,6,6,6,6,15,6,6,7,0,0,8,2,2,2,2,2,3,2,2,7,0,0,8,2,2,2,2,2,2,2,2,7,0,0,8,2,2,2,2,2,2,2,2,7,0,0,16,10,10,10,10,10,10,10,10,17,0,0,0,0,0,0,0,0,0,0,0,0,0";		
			meubles = meubler();
			meublesSansColl = meubler2();
			lesCoffres = coffres();
			fenetres = addFenetres();
			
			super(roomStr, tileStrip, largeur, meubles, meublesSansColl, meublesDev, lesCoffres, fenetres, coffresFermes, monstres, lights);
			
			setTileProperties(1, FlxObject.NONE); // collisions
			setTileProperties(2, FlxObject.NONE);

			setTileProperties(0, FlxObject.ANY);
			setTileProperties(3, FlxObject.ANY);
			setTileProperties(4, FlxObject.ANY);
			setTileProperties(5, FlxObject.ANY);
			setTileProperties(6, FlxObject.ANY);
			setTileProperties(7, FlxObject.ANY);
			setTileProperties(8, FlxObject.ANY);
			setTileProperties(9, FlxObject.ANY);
			setTileProperties(10, FlxObject.ANY);
			setTileProperties(11, FlxObject.ANY);
			setTileProperties(12, FlxObject.ANY);
			setTileProperties(13, FlxObject.ANY);
			setTileProperties(14, FlxObject.ANY);
			setTileProperties(15, FlxObject.ANY);
			setTileProperties(16, FlxObject.ANY);
			setTileProperties(17, FlxObject.ANY);
		}
		
		public function meubler() : FlxGroup
		{
			var dressing : Meubles = new Meubles(2, 2, dressingImg, 128, 105, "une penderie");
			dressing.immovable = true;
			meubles.add(dressing);
			
			var commode : Meubles = new Meubles(8, 4, commodeImg, 64, 44, "une commode");
			commode.immovable = true;
			meubles.add(commode);
			
			var meubleDessus : Meubles = new Meubles(2, 7, meubleDessusImg, 96, 32, "une armoire");
			meubleDessus.immovable = true;
			meubles.add(meubleDessus);
			
			var meubleDessus2 : Meubles = new Meubles(7, 7, meubleDessusImg, 96, 32, "une armoire");
			meubleDessus2.immovable = true;
			meubles.add(meubleDessus2);
			
			if(GameState.clefs[3] != true)
			{
				var papier : Meubles = new Meubles(6, 6, papierImg, 12, 20, "une note", true, "note1");
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
		
		override public function portes (X : int, Y : int) : void
		{		
			switch (X) {
				
				case(7): 		//coordonees porte X
				if(Y == 5)		//coordonees porte Y
					FlxG.switchState(new GameState("ChambreRosa", new FlxPoint(8,10)));
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
