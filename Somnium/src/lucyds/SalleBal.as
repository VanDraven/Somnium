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
	public class SalleBal extends Room 
	{	
		[Embed(source = "assets/img/salles/SalleBal.png")] // change ici le chemin vers la tileStrip sol et murs
		public var tileStrip	: Class;
		[Embed(source = "assets/img/meuble/bar.png")] // change ici le chemin vers le meuble
		public var barImg	: Class;
		[Embed(source = "assets/img/meuble/barrieres.png")] // change ici le chemin vers le meuble
		public var barrieresImg	: Class;
		[Embed(source = "assets/img/meuble/chaise.png")] // change ici le chemin vers le meuble
		public var chaiseImg	: Class;
		[Embed(source = "assets/img/meuble/chaiseHaut.png")] // change ici le chemin vers le meuble
		public var chaiseTImg	: Class;
		[Embed(source = "assets/img/meuble/chaisedos.png")] // change ici le chemin vers le meuble
		public var chaisedosImg	: Class;
		[Embed(source = "assets/img/meuble/chaiseProfilDroit.png")] // change ici le chemin vers le meuble
		public var chaiseProfilDroitImg	: Class;
		[Embed(source = "assets/img/meuble/ChaiseProfilGauche.png")] // change ici le chemin vers le meuble
		public var chaiseProfilGaucheImg	: Class;
		[Embed(source = "assets/img/meuble/contrebasse.png")] // change ici le chemin vers le meuble
		public var contrebasseImg	: Class;
		[Embed(source = "assets/img/meuble/GrandBar.png")] // change ici le chemin vers le meuble
		public var grandBarImg	: Class;
		[Embed(source = "assets/img/meuble/GrandeTable.png")] // change ici le chemin vers le meuble
		public var grandeTableImg	: Class;
		[Embed(source = "assets/img/meuble/piano.png")] // change ici le chemin vers le meuble
		public var pianoImg	: Class;
		[Embed(source = "assets/img/meuble/planteBal1.png")] // change ici le chemin vers le meuble
		public var planteBal1Img	: Class;
		[Embed(source = "assets/img/meuble/planteBal2.png")] // change ici le chemin vers le meuble
		public var planteBal2Img	: Class;
		[Embed(source = "assets/img/meuble/planteBal3.png")] // change ici le chemin vers le meuble
		public var planteBal3Img	: Class;
		[Embed(source = "assets/img/meuble/planteBal4.png")] // change ici le chemin vers le meuble
		public var planteBal4Img	: Class;
		[Embed(source = "assets/img/meuble/table.png")] // change ici le chemin vers le meuble
		public var tableImg	: Class;
		[Embed(source = "assets/img/meuble/tableauMort.png")] // change ici le chemin vers le meuble
		public var tableauMortImg	: Class;
		[Embed(source = "assets/img/meuble/Tabouret.png")] // change ici le chemin vers le meuble
		public var TabouretImg	: Class;
		[Embed(source = "assets/img/meuble/tappisserie.png")] // change ici le chemin vers le meuble
		public var tappisserieImg	: Class;
		[Embed(source = "assets/img/meuble/porteFenetre.png")] // change ici le chemin vers le meuble
		public var fenetreImg	: Class;
		[Embed(source = "assets/img/meuble/trappe.png")] // change ici le chemin vers le meuble
		public var trappeImg	: Class;
		[Embed(source = "assets/img/papier.png")] // change ici le chemin vers le meuble
		public var papierImg	: Class;
		
		
		public static var coffresFermes		: Array = new Array();
		public var roomStr 					: String;
		public var borderStr 				: String;
		private var meubles 				: FlxGroup = new FlxGroup();
		private var meublesSansColl 		: FlxGroup = new FlxGroup();
		private var meublesDev				: FlxGroup = new FlxGroup();
		private var lesCoffres		 		: FlxGroup = new FlxGroup();
		private var fenetres		 		: FlxGroup = new FlxGroup();
		private var lights		 			: FlxGroup = new FlxGroup();
		private var monstres		 		: FlxGroup = new FlxGroup();
		
		public function SalleBal() 
		{
			// remplace la valeur de largeur par la largeur de la pièce en tiles
			var largeur : int = 50;
			
			// remplacer la valeur de roomStr (et enlève les sauts de lignes)
			roomStr ="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,41,35,35,35,35,35,35,35,35,35,35,35,35,40,0,0,0,0,41,35,35,35,35,35,35,35,35,35,35,35,35,40,0,0,0,0,0,0,0,0,0,0,41,35,35,35,35,35,35,35,27,26,26,0,26,26,26,26,26,26,0,26,26,29,35,35,35,35,27,26,26,0,26,26,26,26,26,26,0,26,26,29,35,35,35,35,35,35,35,40,0,0,34,26,26,26,0,0,26,26,26,32,32,0,32,32,32,32,32,32,0,32,32,26,0,0,0,0,26,32,32,0,32,32,32,32,32,32,0,32,32,26,26,26,0,0,26,26,26,39,0,0,34,32,32,32,0,0,32,32,32,38,38,0,38,38,38,38,38,38,0,38,38,32,0,0,0,0,32,38,38,0,38,38,38,38,38,38,0,38,38,32,32,32,0,0,32,32,32,39,0,0,34,38,38,38,0,0,38,38,38,7,8,7,8,7,8,7,8,7,8,7,8,38,0,0,0,0,38,7,8,7,8,7,8,7,8,7,8,7,8,38,38,38,0,0,38,38,38,39,0,0,34,8,7,8,5,4,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,5,4,5,4,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,5,4,7,8,7,39,0,0,34,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,39,0,0,34,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,39,0,0,34,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,39,0,0,34,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,39,0,0,34,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,39,0,0,34,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,39,0,0,34,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,39,0,0,34,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,39,0,0,34,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,39,0,0,34,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,39,0,0,34,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,7,8,39,0,0,34,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,13,13,13,13,13,14,14,14,14,14,14,13,13,13,13,13,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,39,0,0,34,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,13,13,13,13,13,14,14,14,14,14,14,13,13,13,13,13,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,39,0,0,34,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,2,2,2,2,2,2,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,3,10,11,39,0,0,34,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,2,2,2,2,2,2,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,39,0,0,34,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,2,2,2,2,2,2,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,39,0,0,34,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,2,2,2,2,2,2,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,39,0,0,34,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,2,2,2,2,2,2,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,39,0,0,34,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,2,2,2,2,2,2,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,39,0,0,34,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,2,2,2,2,2,2,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,39,0,0,34,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,2,2,2,2,2,2,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,39,0,0,34,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,2,2,2,2,2,2,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,39,0,0,34,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,2,2,2,2,2,2,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,39,0,0,34,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,2,2,2,2,2,2,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,39,0,0,34,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,2,2,2,2,2,2,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,39,0,0,34,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,2,2,2,2,2,2,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,39,0,0,34,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,2,2,2,2,2,2,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,39,0,0,34,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,2,2,2,2,2,2,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,39,0,0,34,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,2,2,2,2,2,2,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,39,0,0,34,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,2,2,2,2,2,2,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,15,16,17,39,0,0,34,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,2,2,2,2,2,2,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,21,22,23,39,0,0,30,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,33,3,3,3,3,3,3,28,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,46,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";		
			meubles = meubler();
			meublesSansColl = meubler2();
			meublesDev = meublesDevant();
			lesCoffres = coffres();
			fenetres = addFenetres();
			lights = addLight();
			
			super(roomStr, tileStrip, largeur, meubles, meublesSansColl, meublesDev, lesCoffres, fenetres, coffresFermes, monstres, lights);
			
			
			setTileProperties(0, FlxObject.ANY);
			
			for(var i : int = 1; i < 24; i++)
				setTileProperties(i, FlxObject.NONE);
			
			for(i = 24; i < 48; i++)
				setTileProperties(i, FlxObject.ANY);
		}
		
		public function meubler() : FlxGroup
		{
			if(GameState.clefs[5] != true)
			{
				var papier : Meubles = new Meubles(25, 35, papierImg, 12, 20, "une note", true, "journal1");
				papier.immovable = true;
				meubles.add(papier);
			}
			
			var bar : Meubles = new Meubles(42, 18, barImg, 64, 224, "un bar");
			bar.immovable = true;
			meubles.add(bar);
			
			var grandeTable1 : Meubles = new Meubles(31, 28, grandeTableImg, 288, 96, "une table");
			grandeTable1.immovable = true;
			meubles.add(grandeTable1);
			
			var grandeTable2 : Meubles = new Meubles(33, 34, grandeTableImg, 288, 96, "une table");
			grandeTable2.immovable = true;
			meubles.add(grandeTable2);
			
			var table1 : Meubles = new Meubles(5, 22, tableImg, 96, 96, "une table");
			table1.immovable = true;
			meubles.add(table1);
			
			var table2 : Meubles = new Meubles(15, 22, tableImg, 96, 96, "une table");
			table2.immovable = true;
			meubles.add(table2);
			
			var table3 : Meubles = new Meubles(5, 33, tableImg, 96, 96, "une table");
			table3.immovable = true;
			meubles.add(table3);
			
			var table4 : Meubles = new Meubles(15, 33, tableImg, 96, 96, "une table");
			table4.immovable = true;
			meubles.add(table4);
			
			var table5 : Meubles = new Meubles(10, 27, tableImg, 96, 96, "une table");
			table5.immovable = true;
			meubles.add(table5);
			
			var posXChaisePD : Array = [3.5, 3.5, 13.5, 13.5, 8.5];
			var posYChaisePD : Array = [22, 33, 22, 33, 27];
			
			for(var i : int = 0; i < 5; i++)
			{
				var chaisePD : Meubles = new Meubles(posXChaisePD[i], posYChaisePD[i], chaiseProfilDroitImg, 32, 62, "une chaise");
				chaisePD.immovable = true;
				meubles.add(chaisePD);
			}
			
			var posXChaisePG : Array = [8.5, 8.5, 18.5, 18.5, 13.5];
			var posYChaisePG : Array = [22, 33, 22, 33, 27];
			
			for(i = 0; i < 5; i++)
			{
				var chaisePG : Meubles = new Meubles(posXChaisePG[i], posYChaisePG[i], chaiseProfilGaucheImg, 32, 62, "une chaise");
				chaisePG.immovable = true;
				meubles.add(chaisePG);
			}
			
			var posXChaiseD : Array = [6, 6, 16, 16, 11];
			var posYChaiseD : Array = [24, 35, 24, 35, 29];
			
			for(i = 0; i < 5; i++)
			{
				var chaiseD : Meubles = new Meubles(posXChaiseD[i], posYChaiseD[i], chaisedosImg, 32, 62, "une chaise");
				chaiseD.immovable = true;
				meubles.add(chaiseD);
			}
			
			var plante1 : Meubles = new Meubles(10, 3, planteBal1Img, 26, 73, "une plante");
			plante1.immovable = true;
			meubles.add(plante1);
			
			var plante2 : Meubles = new Meubles(21, 3, planteBal2Img, 31, 73, "une plante");
			plante2.immovable = true;
			meubles.add(plante2);
			
			var plante3 : Meubles = new Meubles(28, 3, planteBal3Img, 29, 73, "une plante");
			plante3.immovable = true;
			meubles.add(plante3);
			
			var plante4 : Meubles = new Meubles(39, 3, planteBal4Img, 29, 73, "une plante");
			plante4.immovable = true;
			meubles.add(plante4);
			
			var tableau : Meubles = new Meubles(15, 3, tableauMortImg, 64, 64, "un tableau");
			tableau.immovable = true;
			meubles.add(tableau);
			
			var tapisserie : Meubles = new Meubles(32, 3, tappisserieImg, 128, 64, "une tapisserie");
			tapisserie.immovable = true;
			meubles.add(tapisserie);
			
			return meubles;
		}
		
		public function meubler2() : FlxGroup
		{
			var trape : Meubles = new Meubles(45, 20, trappeImg, 32, 32, "");
			trape.immovable = true;
			meublesSansColl.add(trape);
			
			return meublesSansColl;
		}
		
		public function meublesDevant() : FlxGroup
		{
			var posXChaise : Array = [32, 34, 36, 38, 40, 34, 36, 38, 40, 42];
			var posYChaise : Array = [27, 27, 27, 27, 27, 33, 33, 33, 33, 33];
			
			for(var i : int = 0; i < 10; i++)
			{
				var chaise : Meubles = new Meubles(posXChaise[i]-1, posYChaise[i]+1, chaiseTImg, 23, 30, "une chaise");
				chaise.immovable = true;
				meublesDev.add(chaise);
				chaise.height = 32;
				chaise.offset.y = 62-32;
			}
			
			var posXChaiseF : Array = [6, 6, 16, 16, 11];
			var posYChaiseF : Array = [20, 31, 20, 31, 25];
			
			for(i = 0; i < 5; i++)
			{
				var chaiseF : Meubles = new Meubles(posXChaiseF[i], posYChaiseF[i]+1, chaiseImg, 32, 62, "une chaise");
				chaiseF.immovable = true;
				meublesDev.add(chaiseF);
				chaiseF.height = 32;
				chaiseF.offset.y = 62-32;
			}
					
			var barrieres1 : Meubles = new Meubles(2, 17, barrieresImg, 480, 38, "une barriere");
			barrieres1.immovable = true;
			meublesDev.add(barrieres1);
			barrieres1.height = 0;
			
			var barrieres2 : Meubles = new Meubles(33, 17, barrieresImg, 480, 38, "une barriere");
			barrieres2.immovable = true;
			meublesDev.add(barrieres2);
			barrieres2.height = 0;
			
			return meublesDev;
		}
		
		public function addFenetres() : FlxGroup
		{
			var posX : Array = [5, 6, 12, 19, 23, 24, 25, 26, 30, 37, 43, 44];
			var posY : Array = [3, 3, 2, 2, 3, 3, 3, 3, 2, 2, 3, 3];
			
			for(var i : int = 0; i < 12; i++)
			{
				var fenetre : Meubles = new Meubles(posX[i], posY[i], fenetreImg, 32, 96, "une porte-fenetre");
				fenetre.immovable = true;
				fenetres.add(fenetre);
			}
			
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
				
				case(45): 		//coordonees porte X
				if(Y == 20)		//coordonees porte Y
					FlxG.switchState(new GameState("CaveVin", new FlxPoint(3,5)));
				break;
				
				case(24): 		//coordonees porte X
				if(Y == 38)		//coordonees porte Y
					FlxG.switchState(new GameState("RDC", new FlxPoint(17,22)));
				if(Y == 6)
					FlxG.switchState(new GameState("Jardin", new FlxPoint(13,36)));
				break;
				
				case(25): 		//coordonees porte X
				if(Y == 38)		//coordonees porte Y
					FlxG.switchState(new GameState("RDC", new FlxPoint(18,22)));
				if(Y == 6)
					FlxG.switchState(new GameState("Jardin", new FlxPoint(14,36)));
				break;
				
				case(26):
				if(Y == 6)
					FlxG.switchState(new GameState("Jardin", new FlxPoint(15,36)));
				break;
				
				case(23):
				if(Y == 6)
					FlxG.switchState(new GameState("Jardin", new FlxPoint(12,36)));
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