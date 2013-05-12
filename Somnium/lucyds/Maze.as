package lucyds {
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	
	public class Maze extends FlxTilemap
	{		
		private static const LOWLIMIT		: uint = 600;
		private static const HIGHLIMIT		: uint = 700;
		
		private static var numCasesW	: uint = 100;
		private static var numCasesH	: uint = 50;
		
		public var tempsDest		: Number 						= 0.15 / PlayState.dByFloor;
		public var lowLimit			: int							= LOWLIMIT + PlayState.mazeMin;
		public var highLimit		: int							= HIGHLIMIT + PlayState.mazeMax;
		
		public var fields			: Vector.<Vector.<uint>>		= new Vector.<Vector.<uint>>(numCasesW);
		private var fieldValues 	: Vector.<Vector.<uint>>		= new Vector.<Vector.<uint>>(numCasesW);
		private var colorFields 	: Vector.<Vector.<FlxSprite>> 	= new Vector.<Vector.<FlxSprite>>(numCasesW);
		public var numFields 		: uint							= 0;
		public var startX			: uint;
		public var startY			: uint;
		private	var endX			: uint;
		private var endY			: uint;
		public var fieldValuations  : Vector.<Vector.<uint>>;
		private var counter			: Number 						= 0;
		private var firstRealBN		: int;
		
		[Embed(source = "assets/img/Tilestrip2.png")]
		public var mazeTiles:Class;
		
		public function Maze():void
		{
			defineStart();
			defineEnd();
			
			createPathBetween(startX, startY, endX, endY, lowLimit, highLimit);
			createExtraConections();
			
			fieldValuations = valuateFields(endX, endY);
			fields = rotateMatrix(fields);
			fieldValues = rotateMatrix(fieldValues);
			
			create3D();
			
			firstRealBN = realBN();
			trace(firstRealBN);
			
			var dataStr:String = convertMatrixToStr(fields);
			this.loadMap(dataStr, mazeTiles, 32, 32);
			this.setTileProperties(1, FlxObject.NONE); // collisions
			this.setTileProperties(6, FlxObject.NONE);
			this.setTileProperties(7, FlxObject.NONE);
			this.setTileProperties(0, FlxObject.ANY);
			start();
		}
		
		override public function update():void 
		{			
			var realBiggestNumber : int = realBN();
			counter += FlxG.elapsed;
			var tempsDestFin : Number = (tempsDest - PlayState.lucie.jump*0.03);
			if (counter >= 3 + tempsDestFin)
			{
				destruction(realBiggestNumber);
				--realBiggestNumber;
				counter = 3;
			}
			
			var XX			: Number 	= PlayState.lucie.x - endX*32;
			var YY			: Number 	= PlayState.lucie.y - endY*32;
			var distance 	: Number	= Math.sqrt( XX * XX + YY * YY );
			
			if ((firstRealBN/2 > realBiggestNumber) || ((distance < 100) && PlayState.lightLucie.alive))
				stop();
		}
		
		private function rotateMatrix(matrix : Vector.<Vector.<uint>>) : Vector.<Vector.<uint>>
		{
			var matrixHeight	: uint = matrix.length;
			var matrixWidth		: uint = matrix[0].length;
			var rotatedMatrix	: Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>(matrixWidth);
			
			for (var x : uint = 0; x < matrixWidth; ++x)
			{
				rotatedMatrix[x] = new Vector.<uint>(matrixHeight);
				for (var y : uint = 0; y < matrixHeight; ++y)
					rotatedMatrix[x][y] = matrix[y][x];	
			}
			
			return rotatedMatrix;
		}
		
		private function convertMatrixToStr( mat:Vector.<Vector.<uint>>):String
		{
			var mapString : String = "";
			
			for (var y : uint = 0; y < mat.length; ++y)
				mapString += mat[y].join() + "\n";
			
			return mapString;
		}
		
		private function initPath() : void
		{
			numFields = 0;
			
			for (var i : uint = 0; i < numCasesW; ++i)
			{
				fields[i] = new Vector.<uint>(numCasesH);
				fieldValues[i] = new Vector.<uint>(numCasesH);
				colorFields[i] = new Vector.<FlxSprite>(numCasesH);
			}
		}
		
		private function createPathBetween(startX		: int,
										   startY		: int,
										   endX			: int,
										   endY			: int,
										   lowLimit		: int,
										   highLimit	: int) : void
		{
			var numTries : int = 0;
			
			numFields = 0;
			
			var dispertion : Boolean = false;
			
			if(numTries < 50)
			{
				while ((numFields < lowLimit || numFields > highLimit) && dispertion == false)
				{
					initPath();
					createPath(startX, startY, endX, endY);
					
					if(numFields/2 > realBN())
						dispertion = false;
					else
						dispertion = true;
						
					++numTries;
					trace("NumTries = ", numTries);
				}	
			}
			
			else
			{
				defineEnd();
				numTries = 0;
			}
		}
		
		private function createExtraConections() : void
		{
			var flip : uint = 0;
			var testExtra : int = 0;
			
			for (var x : uint = 1; x < numCasesW - 1; ++x)
				for (var y : uint = 1; y < numCasesH - 1; ++y)
					if (!fields[x][y] &&
						((fields[x + 1][y] && fields[x - 1][y]) ||
							(fields[x][y + 1] && fields[x][y - 1])))
					{
						// on rentre ici quand on PEUT creer un pont.
						if (flip == 30)
						{
							fields[x][y] = 1;
							flip = 1;
							testExtra++;
						}
						else
							++flip;
					}

		}
		
		private function createPath(startX	: int,
									startY	: int,
									endX	: int,
									endY	: int) : Boolean
		{
			// Cas d'arret OK
			if ((startX - endX) * (startX - endX) + (startY - endY) * (startY - endY) <= 1)
			{
				createField(startX, startY);
				createField(endX, endY);
				return true;
			}
			
			// Cas d'arret KO
			if (startX < 1 || startX >= numCasesW - 1|| startY < 1 || startY >= numCasesH - 1 || // test bords
				fields[startX][startY] == 1 || // test case courante
				!testAdjacents(startX, startY) || // test adjacents
				!testDiagonals(startX, startY)) // teste diagonales.
			{
				return false;
			}
			
			// Cas general
			createField(startX, startY);
			
			var success		: Boolean	= false;
			var triedPaths	: uint		= 0;
			
			while (!success && triedPaths != 15)
			{
				var randomisedNumber : Number = FlxG.random();

				if (randomisedNumber < 0.25)
				{
					success = createPath(startX + 1, startY, endX, endY);
					triedPaths |= 1;
				}
				else if (randomisedNumber < 0.5)
				{
					success = createPath(startX, startY + 1, endX, endY);
					triedPaths |= 2;
				}
				else if (randomisedNumber < 0.75)
				{
					success = createPath(startX - 1, startY, endX, endY);
					triedPaths |= 4;
				}
				else
				{
					success = createPath(startX, startY - 1, endX, endY);
					triedPaths |= 8;
				}
			}
			
			return success;
		}
		
		private function testAdjacents(x : int, y : int) : Boolean
		{
			if (countAdjacents(x, y) <= 1)
				return true;
			else
				return false;
		}
		
		private function countAdjacents(x : int, y : int) : uint
		{
			return	int(fields[x + 1][y]) + 
					int(fields[x][y + 1]) +
					int(fields[x][y - 1]) + 
					int(fields[x - 1][y]);
		}
		
		private function testDiagonals(startX : int, startY : int) : Boolean
		{
			// si je viens du bas.
			if (fields[startX][startY - 1] && (
				fields[startX - 1][startY + 1] ||
				fields[startX + 1][startY + 1]))
				return false;
			
			// si je viens du haut
			if (fields[startX][startY + 1] && (
				fields[startX - 1][startY - 1] ||
				fields[startX + 1][startY - 1]))
				return false;
			
			// si je viens de gauche
			if (fields[startX - 1][startY] && (
				fields[startX + 1][startY - 1] ||
				fields[startX + 1][startY + 1]))
				return false;
			
			// si je viens de droite
			if (fields[startX + 1][startY] && (
				fields[startX - 1][startY - 1] ||
				fields[startX - 1][startY + 1]))
				return false;
			
			return true;
		}
		
		private function createField(x : uint, y : uint) : void
		{
			fields[x][y] = 1;
			++numFields;
		}
		
		private function create3D() : void
		{
			var matrixHeight	: uint = fields.length;
			var matrixWidth		: uint = fields[0].length;
			
			for (var x : uint = 1; x < matrixWidth - 1; ++x)
			{
				for (var y : uint = 1; y < matrixHeight - 1; ++y)
				{
					if (fields[y][x] == 1 && fields[y+1][x] == 0)
						fields[y+1][x] = 8;
					if (fields[y][x] == 1 && fields[y][x+1] == 0)
						fields[y][x+1] = 3;
					if (fields[y][x] == 1 && fields[y+1][x] != 1 && fields[y][x+1] !=1 && fields[y+1][x+1] == 0)
						fields[y+1][x+1] = 2;
					if (fields[y][x] == 1 && fields[y+1][x] == 1 && fields[y][x+1] == 1 && fields[y+1][x+1] != 1)
						fields[y+1][x+1] = 5;
					if (fields[y][x] == 8 && fields[y-1][x-1] != 1)
						fields[y][x] = 4;
				}
			}
						
		}
		
		private function valuateFields(x : int, y : int, currentValue : int = 1) : Vector.<Vector.<uint>>
		{
			if (fieldValues[x][y] == 0 || fieldValues[x][y] > currentValue)
			{
				fieldValues[x][y] = currentValue;
		
				if (fields[x - 1][y])
				valuateFields(x - 1, y, currentValue + 1);
		
				if (fields[x + 1][y])
				valuateFields(x + 1, y, currentValue + 1);
		
				if (fields[x][y - 1])
				valuateFields(x, y - 1, currentValue + 1);
		
				if (fields[x][y + 1])
				valuateFields(x, y + 1, currentValue + 1);
			}
			return fieldValues;
		}
		
		public function createColorPath(state:FlxState) : void
		{
			var matrixWidth		: uint = fields.length;
			var matrixHeigth	: uint = fields[0].length;
			var biggestNumber	: uint = 0;	
			var x				: uint = 0;
			var y				: uint = 0;
			
			for (x = 0; x < matrixWidth; ++x)
				for (y = 0; y < matrixHeigth; ++y)
					if (fields[x][y] == 1 && fieldValues[x][y] > biggestNumber)
						biggestNumber = fieldValues[x][y];
			
			var realBiggestNumber : int = biggestNumber;
			
			while (biggestNumber-- > 1)
			{
				var ratio	: Number	= biggestNumber / realBiggestNumber;
				var red		: uint		= (ratio) * 255;
				var green	: uint		= (ratio) * 255;
				var blue	: uint		= (ratio) * 255;
				var color	: uint		= (0xff << 24) | blue | (green << 8) | (red << 16);
				
				for (x = 0; x < matrixWidth; ++x)
					for (y = 0; y < matrixHeigth; ++y)
						if (biggestNumber == fieldValues[x][y])
						{
							var colorPath : FlxSprite = new FlxSprite(32 * y, 32 * x);
							colorPath.makeGraphic(32,32,color);
							colorFields[y][x] = colorPath;
							state.add(colorPath);	
						}
			}
		}
		
		private function start () : void
		{
			this.setTile(startX, startY, 6);
		}
		
		private function stop () : void
		{
			this.setTile(endX, endY, 7);
		}
		
		public function realBN () : int
		{
			var matrixWidth		: uint = fields.length;
			var matrixHeigth	: uint = fields[0].length;
			var biggestNumber	: uint = 0;	
			var x				: uint = 0;
			var y				: uint = 0;
			
			for (x = 0; x < matrixWidth; ++x)
				for (y = 0; y < matrixHeigth; ++y)
					if (fields[x][y] == 1 && fieldValues[x][y] > biggestNumber)
						biggestNumber = fieldValues[x][y];
			return biggestNumber;	
		}
		
		private function destruction (realBiggestNumber : int) : void
		{
			var matrixWidth		: uint = fields.length;
			var matrixHeigth	: uint = fields[0].length;
			var x : uint = 0;
			var y : uint = 0;
			for (x = 0; x < matrixWidth; ++x)
				for (y = 0; y < matrixHeigth; ++y)
					if (realBiggestNumber == fieldValues[x][y])
					{
						this.setTile(y, x, 0);
						fields[x][y] = 0;
						PlayState.spawnEmitter(y*32, x*32);
						
						// detruit les rebords
						
						if(fields[x+1][y] != 1)
							this.setTile(y, x+1, 0);
						if(fields[x][y+1] != 1)
							this.setTile(y+1, x, 0);
						if(fields[x+1][y+1] == 2)
							this.setTile(y+1, x+1, 0);
						
						if(colorFields[y][x])
							colorFields[y][x].kill(); 
					}
		}
		private function defineStart() : void
		{
			var rand : Number = FlxG.random();
			
			if(rand < 0.25)
			{
				startX = 1;
				startY = FlxG.random()* (numCasesH - 2);
			}
			else if (rand < 0.5)
			{
				startX = numCasesW - 2;
				startY = FlxG.random()* (numCasesH - 2);
			}
			else if (rand < 0.75)
			{
				startY = 1;
				startX = FlxG.random()* (numCasesW - 2);
			}
			else
			{
				startY = numCasesH - 2;
				startX = FlxG.random()* (numCasesW - 2);
			}			
			trace(startX, startY);
		}
		
		
		private function defineEnd() : void
		{					
			if(startX == 1)
			{
				endX = numCasesW - 2;
				endY = FlxG.random()* (numCasesH - 2);
			}
			
			if(startX == numCasesW - 2)
			{
				endX = 1;
				endY = FlxG.random()* (numCasesH - 2);
			}
			
			if(startY == 1)
			{
				endY = numCasesH - 2;
				endX = FlxG.random()* (numCasesW - 2);
			}
			
			if(startY == numCasesH - 2)
			{
				endY = 1;
				endX = FlxG.random()* (numCasesW - 2);
			}
			trace(endX, endY);
		}
	}
}