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
	public class CaveVin extends Room 
	{	
		[Embed(source = "assets/img/salles/CaveVin.png")] // change ici le chemin vers la tileStrip sol et murs
		public var tileStrip	: Class;
		[Embed(source = "assets/img/meuble/barildroit.png")] // change ici le chemin vers le meuble
		public var barilImg	: Class;
		[Embed(source = "assets/img/meuble/barils.png")] // change ici le chemin vers le meuble
		public var barilCoucheImg	: Class;
		[Embed(source = "assets/img/meuble/barilsmasse.png")] // change ici le chemin vers le meuble
		public var barilsImg	: Class;
		[Embed(source = "assets/img/meuble/cavevin3.png")] // change ici le chemin vers le meuble
		public var etageresImg	: Class;

		
		
		public static var coffresFermes		: Array = new Array();
		public var roomStr 					: String;
		private var meubles 				: FlxGroup = new FlxGroup();
		private var meublesSansColl 		: FlxGroup = new FlxGroup();
		private var meublesDev			 	: FlxGroup = new FlxGroup();
		private var lesCoffres		 		: FlxGroup = new FlxGroup();
		private var fenetres		 		: FlxGroup = new FlxGroup();
		private var lights		 			: FlxGroup = new FlxGroup();
		private var monstres		 		: FlxGroup = new FlxGroup();
		
		public function CaveVin() 
		{
			// remplace la valeur de largeur par la largeur de la pièce en tiles
			var largeur : int = 26;
			
			// remplacer la valeur de roomStr (et enlève les sauts de lignes)
			roomStr ="1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,1,45,15,19,24,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,37,1,0,0,0,0,1,30,18,26,18,20,21,20,21,20,21,18,18,18,20,21,20,21,20,21,29,1,0,0,0,0,1,30,25,33,25,27,28,27,28,27,28,25,25,25,27,28,27,28,27,28,29,1,0,0,0,0,1,30,32,40,32,34,35,34,35,34,35,32,32,32,34,35,34,35,34,35,29,1,1,1,1,1,1,30,2,3,4,5,10,12,2,5,9,4,11,9,11,2,5,12,10,4,24,31,31,31,37,1,1,30,9,10,11,12,4,5,2,11,9,10,11,12,11,9,5,2,4,5,20,21,20,21,29,1,1,43,36,36,36,36,36,36,36,36,36,36,36,36,36,36,22,4,5,2,27,28,27,28,29,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,30,11,12,11,34,35,34,35,29,1,1,1,45,31,31,31,31,31,31,31,31,31,31,31,31,31,15,9,5,12,2,5,4,5,29,1,1,1,30,18,18,20,21,20,21,20,21,20,21,20,21,20,21,12,4,5,10,11,11,12,29,1,1,1,30,25,25,27,28,27,28,27,28,27,28,27,28,27,28,9,11,12,2,12,2,11,29,1,1,1,30,32,32,34,35,34,35,34,35,34,35,34,35,34,35,9,10,11,12,23,36,36,44,1,1,1,30,11,12,9,10,11,12,12,2,9,4,2,9,10,11,5,2,4,9,29,1,1,1,1,1,1,30,9,10,5,4,12,9,10,11,12,9,9,5,4,12,9,12,10,5,29,1,1,1,1,1,1,30,5,9,23,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,44,1,1,1,1,1,1,30,12,2,29,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,30,4,2,24,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,37,1,0,1,1,30,11,9,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,29,1,0,1,1,30,2,5,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,29,1,0,1,1,30,12,4,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,29,1,0,0,1,30,2,9,5,4,5,4,10,11,5,10,9,10,11,12,9,10,11,12,2,4,29,1,0,0,1,30,9,2,12,11,12,5,9,10,11,12,5,10,2,5,5,2,4,5,9,11,29,1,0,0,1,30,9,10,11,12,2,11,12,9,10,11,12,5,9,12,12,9,4,5,10,11,29,1,0,0,1,43,36,36,36,36,36,36,36,36,36,36,36,36,36,22,9,12,9,10,11,12,29,1,0,0,1,1,1,1,1,1,1,1,1,1,1,45,31,31,31,15,4,5,10,11,10,10,29,1,0,0,1,45,31,31,31,31,31,31,31,31,31,15,18,18,18,18,9,10,11,12,4,5,29,1,0,0,1,30,18,18,18,18,18,18,18,18,18,18,25,25,25,25,9,2,4,5,11,12,29,1,0,0,1,30,25,25,25,25,25,25,25,25,25,25,32,32,32,32,5,9,9,10,11,12,29,1,0,0,1,30,32,32,32,32,32,32,32,32,32,32,5,4,10,5,12,4,12,12,4,9,29,1,0,0,1,30,9,10,11,12,2,4,9,2,9,5,9,10,11,12,12,11,4,5,11,2,29,1,0,0,1,30,2,12,5,10,9,11,12,12,4,12,9,10,11,12,23,36,36,36,36,36,44,1,0,0,1,30,9,9,12,11,9,10,11,12,11,12,23,36,36,36,44,1,1,1,1,1,1,1,1,0,1,43,36,36,36,36,36,36,36,22,2,12,29,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,30,12,9,24,31,31,31,31,31,31,31,31,31,37,1,0,0,1,0,0,0,0,0,0,0,1,30,2,2,18,18,18,18,18,18,18,18,18,18,29,1,0,0,0,0,0,0,0,0,0,0,1,30,11,2,25,25,25,25,25,25,25,25,25,25,29,1,0,0,0,0,0,0,0,0,0,0,1,30,5,10,32,32,32,32,32,32,32,32,32,32,29,1,0,0,0,0,0,0,0,0,0,0,1,30,11,12,2,5,5,11,12,3,9,10,11,12,29,1,0,0,0,0,0,0,0,0,0,0,1,30,9,10,11,12,10,11,2,10,5,11,12,11,29,1,0,0,0,0,0,0,0,0,0,0,1,43,36,36,36,36,36,36,36,36,36,36,36,36,44,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0";		
			
			meubles = meubler(); 			// Meubles normaux (armoires, bureaux, …)
			meublesSansColl = meubler2();	// Meubles sans collisions (tapis, …)
			lesCoffres = coffres();			// Coffres
			fenetres = addFenetres();		// Fenetres
			lights = addLight();			// Lumières (bougies, lampes, …)
			
			super(roomStr, tileStrip, largeur, meubles, meublesSansColl, meublesDev, lesCoffres, fenetres, coffresFermes, monstres, lights);
			
			setTileProperties(1, FlxObject.NONE); // collisions
			setTileProperties(2, FlxObject.NONE);
			setTileProperties(0, FlxObject.ANY);
			for(var i : int = 1; i <= 13 ; i++)
				setTileProperties(i, FlxObject.NONE);
			for(i = 14; i <= 48 ; i++)
				setTileProperties(i, FlxObject.ANY);
		}
		
		public function meubler() : FlxGroup
		{
			var posXBaril : Array = [3, 22.3, 21.3, 22.3, 22.3, 22.3];
			var posYBaril : Array = [23.8, 30.8, 30.8, 22, 24.6, 25.9];
			
			for(var i : int = 0; i < 6; i++)
			{
				var baril : Meubles = new Meubles(posXBaril[i], posYBaril[i]-1, barilImg, 22, 37, "un baril");
				baril.immovable = true;
				meubles.add(baril);
			}
			
			var posXBarilC : Array = [8, 7, 9];
			var posYBarilC : Array = [29, 29, 29];
			
			for(i = 0; i < 3; i++)
			{
				var barilC : Meubles = new Meubles(posXBarilC[i], posYBarilC[i], barilCoucheImg, 24, 50, "un baril");
				barilC.immovable = true;
				meubles.add(barilC);
			}
			
			var barilM : Meubles = new Meubles(21, 23.3, barilImg, 22, 37, "un baril");
			barilM.moves = false;
			meubles.add(barilM);
			
			var barilMasse : Meubles = new Meubles(3, 28, barilsImg, 96, 82, "un tas de baril");
			barilMasse.immovable = true;
			meubles.add(barilMasse);
			
			return meubles;
		}
		
		public function meubler2() : FlxGroup
		{
//			var tapis : Meubles = new Meubles(6, 7, tapisImg, 132, 68, "");
//			tapis.immovable = true;
//			meublesSansColl.add(tapis);
			
			return meublesSansColl;
		}
		
		public function addFenetres() : FlxGroup
		{
//			var fenetre : Meubles = new Meubles(6, 2, fenetreImg, 128, 96, "ma fenetre");
//			fenetre.immovable = true;
//			fenetres.add(fenetre);
			
			return fenetres;
		}
		
		public function addLight() : FlxGroup
		{
//			var table : Meubles = new Meubles(6, 4, tableImg, 31, 46, "ma table de nuit", true, "ClefPenderie");
//			table.immovable = true;
//			lights.add(table);
			
			return lights;
		}
		
		override public function portes (X : int, Y : int) : void
		{		
			switch (X) {
				
				case(3): 		//coordonees porte X
				if(Y == 5)		//coordonees porte Y
					FlxG.switchState(new GameState("SalleBal", new FlxPoint(45,20)));
				break;
				
				case(18): 		//coordonees porte X
				if(Y == 37)		//coordonees porte Y
				{
					FlxG.fade(0xAA000000, 4, illu1);
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
		
		private function illu1() : void
		{
			FlxG.switchState(new GameState("ChambreRosa", new FlxPoint(6,6)));
			GameState.textPos = "Dialogue";
			GameState.texte = "Qu'est-ce que c'était ? Un cauchemar ?";
			GameState.textFace = "peur";
			GameState.updateText = true;
		}
	}
}
