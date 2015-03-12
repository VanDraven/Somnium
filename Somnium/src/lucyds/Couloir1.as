package lucyds {
	import org.flixel.FlxSprite;
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import lucyds.Room;

	import org.flixel.FlxGroup;

	/**
	 * @author DXPCorp
	 */
	public class Couloir1 extends Room 
	{
		[Embed(source = "assets/img/salles/CouloirsOK.png")] // change ici le chemin vers la tileStrip sol et murs
		public var tileStrip	: Class;
		[Embed(source = "assets/img/zebre.png")] // change ici le chemin vers le meuble
		public var armoireImg	: Class;
		
		public static var coffresFermes		: Array = new Array();
		public var roomStr 					: String;
		private var meubles 				: FlxGroup = new FlxGroup();
		private var meublesSansColl 		: FlxGroup = new FlxGroup();
		private var meublesDev		 		: FlxGroup = new FlxGroup();
		private var lesCoffres		 		: FlxGroup = new FlxGroup();
		private var fenetres		 		: FlxGroup = new FlxGroup();
		private var lights					: FlxGroup = new FlxGroup();
		private var monstres				: FlxGroup = new FlxGroup();
		
		public function Couloir1() 
		{
			// remplacer la valeur de roomStr (et enlève les sauts de lignes)
			roomStr ="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24,18,18,18,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24,18,18,18,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,5,6,5,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,5,6,5,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,8,4,8,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,8,4,8,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,11,7,11,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24,18,18,18,18,10,11,7,11,15,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,10,2,3,2,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,5,6,5,6,5,2,3,2,6,5,6,5,6,5,6,5,6,5,6,5,6,5,6,5,6,5,6,5,6,5,6,5,6,5,6,5,5,6,2,2,2,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,8,9,8,9,8,2,2,2,9,8,9,8,9,8,9,8,9,8,9,8,9,8,9,8,9,8,9,8,9,8,9,8,9,8,9,8,8,9,2,2,2,16,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,11,12,11,12,11,2,2,2,12,11,12,11,12,11,12,11,12,11,12,11,12,11,12,11,12,11,12,11,12,11,12,11,12,11,12,11,11,12,2,2,2,16,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,15,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22,19,13,3,14,13,2,2,2,14,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,13,2,2,2,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,17,2,2,2,15,18,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,2,2,2,14,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,2,2,2,5,6,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,2,2,2,16,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,2,2,2,8,9,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,2,2,2,16,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,2,2,2,11,12,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,2,2,2,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,2,2,2,2,2,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24,18,18,20,0,0,17,2,2,2,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,2,2,2,2,2,16,0,0,0,0,24,18,18,20,0,0,0,0,0,0,0,0,0,0,0,0,17,5,6,16,0,0,17,2,2,2,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,2,2,2,14,19,23,0,0,24,18,10,5,6,15,18,18,18,18,18,18,18,18,18,18,18,18,10,8,9,16,0,0,17,2,2,2,15,18,18,18,18,18,18,18,18,18,18,20,0,0,0,0,0,0,0,0,1,17,2,2,2,15,18,18,18,18,10,5,6,8,9,5,6,5,6,5,6,5,6,5,6,5,6,5,6,11,12,16,0,0,17,2,2,2,6,5,6,5,6,5,6,5,6,5,6,16,0,0,0,0,0,0,0,0,1,10,2,2,2,5,6,5,6,5,6,8,9,11,12,8,9,8,9,4,9,8,9,8,9,8,9,8,9,2,2,16,0,0,17,2,2,2,9,8,9,8,9,8,9,8,9,8,9,16,0,0,0,0,0,0,0,0,1,3,2,2,2,8,9,8,9,8,9,11,12,2,2,11,12,11,12,7,12,11,12,11,12,11,12,11,12,2,2,15,18,18,10,2,2,2,12,11,12,11,12,11,12,11,12,11,12,16,0,0,0,0,0,0,0,0,1,13,2,2,2,11,12,11,12,11,12,2,2,2,2,2,2,2,2,3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,0,0,0,0,0,0,1,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,0,0,0,0,0,0,1,17,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,16,0,0,0,0,0,0,0,0,1,10,2,2,2,14,19,19,19,19,19,19,19,19,19,19,13,25,25,25,25,25,25,25,25,14,19,19,19,19,19,13,2,2,2,14,19,19,19,19,19,19,13,3,3,14,19,19,19,23,0,0,0,0,0,0,0,0,1,3,2,2,2,16,0,0,0,0,0,0,0,0,0,0,17,25,25,25,25,25,25,25,25,16,0,0,0,0,0,22,19,19,19,23,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,13,2,2,2,16,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,22,19,19,19,23,1,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
			meubles = meubler();
			
			super(roomStr, tileStrip, 58, meubles, meublesSansColl, meublesDev, lesCoffres, fenetres, coffresFermes, monstres, lights);
			
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
			setTileProperties(18, FlxObject.ANY);
			setTileProperties(19, FlxObject.ANY);
			setTileProperties(20, FlxObject.ANY);
			setTileProperties(21, FlxObject.ANY);
			setTileProperties(22, FlxObject.ANY);
			setTileProperties(23, FlxObject.ANY);
			setTileProperties(24, FlxObject.ANY);
			setTileProperties(25, FlxObject.ANY);
			setTileProperties(26, FlxObject.ANY);
			
			monstres = spawnMonsters();
		}
		
		public function meubler() : FlxGroup
		{	
//			var armoire1 : Meubles = new Meubles(76, 5, armoireImg, 17, 32, "un zebre");
//			armoire1.moves = false;
//			meubles.add(armoire1);
//			
//			var armoire2 : Meubles = new Meubles(52, 4, armoireImg, 17, 32, "un zebre");
//			armoire2.immovable = true;
//			meubles.add(armoire2);
			
			return meubles;
		}
		
		override public function portes (X : int, Y : int) : void
		{		
			switch (X) {
				
				case(5): 		//coordonees porte X
				if(Y == 10)		//coordonees porte Y
					FlxG.switchState(new GameState("Bureau", new FlxPoint(7,5))); // coordonéées porte d'entrée
				break;
				
				case(8): 		//coordonees porte X
				if(Y == 26)		//coordonees porte Y
					FlxG.switchState(new GameState("Couloir2", new FlxPoint(9,29))); // coordonéées porte d'entrée
				break;
				
				case(17): 		//coordonees porte X
				if(Y == 22)		//coordonees porte Y
					FlxG.switchState(new GameState("SalleBal", new FlxPoint(26,38))); // coordonéées porte d'entrée
				break;
				
				case(18): 		//coordonees porte X
				if(Y == 22)		//coordonees porte Y
					FlxG.switchState(new GameState("SalleBal", new FlxPoint(26,38))); // coordonéées porte d'entrée
				break;
				
				case(42): 		//coordonees porte X
				if(Y == 4)		//coordonees porte Y
					FlxG.switchState(new GameState("Couloir2", new FlxPoint(41,5))); // coordonéées porte d'entrée
				break;
				
				
				case(23): 		//coordonees porte X
				if(Y == 23)		//coordonees porte Y
					FlxG.switchState(new GameState("RDC", new FlxPoint(22,22))); // coordonéées porte d'entrée
				break;
				case(24): 		//coordonees porte X
				if(Y == 23)		//coordonees porte Y
					FlxG.switchState(new GameState("RDC", new FlxPoint(23,22))); // coordonéées porte d'entrée
				break;
				case(25): 		//coordonees porte X
				if(Y == 23)		//coordonees porte Y
					FlxG.switchState(new GameState("RDC", new FlxPoint(24,22))); // coordonéées porte d'entrée
				break;
				case(26): 		//coordonees porte X
				if(Y == 23)		//coordonees porte Y
					FlxG.switchState(new GameState("RDC", new FlxPoint(25,22))); // coordonéées porte d'entrée
				break;
				case(27): 		//coordonees porte X
				if(Y == 23)		//coordonees porte Y
					FlxG.switchState(new GameState("RDC", new FlxPoint(26,22))); // coordonéées porte d'entrée
				break;
				case(28): 		//coordonees porte X
				if(Y == 23)		//coordonees porte Y
					FlxG.switchState(new GameState("RDC", new FlxPoint(27,22))); // coordonéées porte d'entrée
				break;
				case(29): 		//coordonees porte X
				if(Y == 23)		//coordonees porte Y
					FlxG.switchState(new GameState("RDC", new FlxPoint(28,22))); // coordonéées porte d'entrée
				break;
				case(30): 		//coordonees porte X
				if(Y == 23)		//coordonees porte Y
					FlxG.switchState(new GameState("RDC", new FlxPoint(29,22))); // coordonéées porte d'entrée
				break;
				
				case(44):
				if(Y == 9)
					FlxG.switchState(new GameState("SalleMusique", new FlxPoint(2,9))); // coordonéées porte d'entrée
				if(Y == 10)
					FlxG.switchState(new GameState("SalleMusique", new FlxPoint(2,10))); // coordonéées porte d'entrée
				break;
			}
		}
		
		public function spawnMonsters () : FlxGroup
		{
//			var monstre1 	: FlxSprite;
//			var chemin1 	: FlxPath 		= new FlxPath();
//			var pathStart1 	: FlxPoint 		= new FlxPoint(4*32, 46*32);
//			var pathEnd1 	: FlxPoint 		= new FlxPoint(73*32, 20*32);
//			
//			chemin1 = this.findPath(pathStart1, pathEnd1);
//			monstre1 = new MiniMonstres(4, 46, chemin1, this, false);
//			
//			monstres.add(monstre1);
//			
//			var monstre2 	: FlxSprite;
//			var chemin2 	: FlxPath 		= new FlxPath();
//			chemin2.add(35*32, 19*32);
//			chemin2.add(35*32, 44*32);
//			chemin2.add(66*32, 44*32);
//			chemin2.add(66*32, 19*32);
//			monstre2 = new MiniMonstres(35, 19, chemin2, this, true);
//			
//			monstres.add(monstre2);
//			
			var monstre3	: FlxSprite;
			var chemin3 	: FlxPath 		= new FlxPath();
			monstre3 = new MiniMonstres(20, 23, chemin3, this, false, true);
			
			monstres.add(monstre3);
//			

			var cointoss	: uint = FlxG.random()*4;
			
			if(cointoss < 1){
				var monsterX	: int = 0;
				var monsterY	: int = 0;
				var monstre4	: FlxSprite;
				var chemin4 	: FlxPath 		= new FlxPath();
				while(getTile(monsterX, monsterY) != 1){
					monsterX = FlxG.random()*58;
					monsterY = FlxG.random()*29;
				}
				monstre4 = new MiniMonstres(monsterX, monsterY, chemin4, this, false, true);
				
				monstres.add(monstre4);
			}
			
//			var monster1X 	: uint 			= 0;
//			var monster1Y 	: uint 			= 0;
//			var monstre5	: FlxSprite;
//			var chemin5 	: FlxPath 		= new FlxPath();
//			while(getTile(monster1X, monster1Y) != 1){
//				monster1X = FlxG.random()*58;
//				monster1Y = FlxG.random()*29;
//				monstre5 = new MiniMonstres(monster1X, monster1Y, chemin5, this, false, true);
//			}
//			monstres.add(monstre5);
//
			return monstres;
		}
	}
}
