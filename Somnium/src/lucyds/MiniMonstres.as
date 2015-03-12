package lucyds {
	//import org.flixel.FlxSound;
	import org.flixel.FlxPoint;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxG;
	import org.flixel.FlxPath;
	import org.flixel.FlxSprite;

	/**
	 * @author DXPCorp
	 */
	public class MiniMonstres extends FlxSprite 
	{
		[Embed(source="assets/img/monstreCouloirs.png")]
		private var monstresImg : Class;
		
//		[Embed(source="assets/sounds/screamStart.mp3")]
//		private var screamStartMP3 : Class;
		
//		[Embed(source="assets/sounds/screamBody.mp3")]
//		private var screamBodyMP3 : Class;
		
		private var orientation			: String		= "Up";
		private var chemin 				: FlxPath;
		private var globalPath			: FlxPath		= new FlxPath();
		private var attackPath 			: FlxPath		= new FlxPath();
		private var pathId				: String;
		private var attackRadius		: int			= 96;
		private var near				: int			= 32;
		private var oldLucieMidpoint 	: FlxPoint		= new FlxPoint();
		private var lastLucie			: FlxPoint		= new FlxPoint();
		private var retourPoint 		: FlxPoint		= new FlxPoint();
		private var ronde 				: uint;
		private var map 				: FlxTilemap	= new FlxTilemap();
		private var stopIndex			: uint			= 0;
		private var nextNode 			: int;
		private var nodeCount			: int			= 0;
		private var hasAttacked			: Boolean		= false;
		private var found				: Boolean		= false;
		private var stopDefined			: Boolean		= false;
		private var stopOnce			: Boolean		= false;
		private var lucieFirst			: Boolean		= false;
		private var random				: Boolean		= false;
	//	private var startPlayed			: Boolean		= false;
		private var vigilanceTimer		: Number		= 0;
		private var seekTimer			: Number		= 0;
	//	private var screamStart			: FlxSound		= FlxG.play(screamStartMP3);
	//	private var screamBody			: FlxSound		= FlxG.play(screamBodyMP3);
		
		public function MiniMonstres(X : Number, Y : Number, chemin : FlxPath,map : FlxTilemap, ronde : Boolean = true, random : Boolean = false) 
		{
			this.chemin = chemin;
			globalPath = chemin;
			this.map = map;
			this.random = random;
			
			if(ronde)
				this.ronde = PATH_LOOP_FORWARD;
			else
				this.ronde = PATH_YOYO;
				
			
			super(X*32, Y*32);
			
			loadGraphic(monstresImg, true, false, 27, 48, true);
			
			this.width = 14;
			this.height = 16;
			this.offset.x = 5;
			this.offset.y = 25;
			
			addAnimation("Walk Left", [4,5,6,7], 7, true);
			addAnimation("Idle Left", [4], 0, false);
			addAnimation("Walk Right", [8,9,10,11], 7, true);
			addAnimation("Idle Right", [8], 0, false);
			addAnimation("Walk Up", [12,13,14,15], 7, true);
			addAnimation("Idle Up", [12], 0, false);
			addAnimation("Walk Down", [0,1,2,3], 7, true);
			addAnimation("Idle Down", [0], 0, true);
			
			if(random == true)
			{
				this.ronde = PATH_FORWARD;
				randomPath();
			}
			
			this.followPath(chemin, 100, this.ronde);
				
			pathId = "normal";
			//seek();
		}
		
		override public function update() : void
		{
			animate();

			var i : int = 0;
			
			seekTimer += FlxG.elapsed;
			
			if(seekTimer >= 0.2)
			{
				seekTimer = 0;
				found = seek();
			}
			
			if(found)
			{
				hasAttacked = true;
				nextNode = _pathNodeIndex;
				attackPath = map.findPath(this.getMidpoint(), GameState.lucie.getMidpoint());
				for(i = 0; i < attackPath.nodes.length; i++)
				{
					nodeCount++;
					chemin.addPointAt(attackPath.nodes[i], nextNode -1 + i);
				}
				lastLucie = GameState.lucie.getMidpoint();
				this.pathSpeed = 200;
				pathId = "Attack";
				stopDefined = false;
//				if(!startPlayed)
//				{
//					startPlayed = true;
//					screamStart.play();
//				}
//				trace(screamStart.alive);
			}
			
			if(!found && hasAttacked && !stopDefined)
			{
				for(i = 0; i < nodeCount; i++)
					chemin.removeAt(_pathNodeIndex-1);
				nodeCount = 0;
				
				stopDefined = true;
				if(!stopOnce)
				{
					stopIndex = _pathNodeIndex;
					stopOnce = true;
				}
				
				chemin = map.findPath(this.getMidpoint(), lastLucie);
				chemin.add(0, 0);
				followPath(chemin, 100);
				pathId = "versLucie";
			}
			
			if(stopDefined && pathId == "versLucie" && chemin.nodes.length - 1 == _pathNodeIndex && !found)
			{
				this.moves = false;
				vigilanceTimer += FlxG.elapsed;
			}
			
			if(vigilanceTimer >= 3 && hasAttacked && !found)
			{
				getGoodPath();
				
				retourPoint = chemin.nodes[stopIndex];
				
				chemin = map.findPath(this.getMidpoint(), retourPoint);
				chemin.add(0, 0);
				this.followPath(chemin, 100);
				pathId = "retour";
				this.moves = true;
				vigilanceTimer = 0;
				hasAttacked = false;
				stopDefined = false;
				stopOnce = false;
			}

			if(chemin.nodes.length == _pathNodeIndex+1 && pathId == "retour" && !found)
			{
				chemin = globalPath;
				this.followPath(chemin, 100, this.ronde);
				_pathNodeIndex = stopIndex;
				pathId = "normal";
			}
			
			if(random && chemin.nodes.length == _pathNodeIndex+1 && pathId == "normal" && !found)
				randomPath();
		}
		
		private function animate() : void
		{
			if (velocity.y > 0)
				orientation = "Down";
			else if (velocity.y < 0)
				orientation = "Up";
				
			if (velocity.x > 0)
				orientation = "Right";
			else if (velocity.x < 0)
				orientation = "Left";
				
			if (!this.moves)
				play("Idle " + orientation);
			else
				play("Walk " + orientation);
		}
		
		private function seek() : Boolean
		{
			var detected 	: Boolean 	= false;
			var XX			: Number 	= GameState.lucie.x - this.x;
			var YY			: Number 	= GameState.lucie.y - this.y;
			var distance 	: Number	= Math.sqrt( XX * XX + YY * YY );
			var pathToLucie	: FlxPath	= map.findPath(this.getMidpoint(),GameState.lucie.getMidpoint(), true, false);
			var nbNodes		: int;
			
			if(pathToLucie != null)
				nbNodes	= pathToLucie.nodes.length;
			else
				nbNodes = 100;
			
			if(GameState.lightLucie.alive && nbNodes <= 4)
				detected = true;
				
			if(!GameState.lightLucie.alive && hasAttacked)
				if(nbNodes <= 4)
					detected = true;
			
			if(distance <= attackRadius)
			{
				if(lucieFirst == false)
				{
					oldLucieMidpoint = GameState.lucie.getMidpoint();
					lucieFirst = true;
				}
				if(GameState.lucie.getMidpoint() != oldLucieMidpoint)
					detected = true;
			}
			else
				lucieFirst = false;

			
			if (distance <= near)
				detected = true;

			oldLucieMidpoint = GameState.lucie.getMidpoint();
			return detected;	
		}
		
		private function getGoodPath() : void
		{
			if(chemin.nodes.length == _pathNodeIndex+1)
			{
				if(pathId == "versLucie" || pathId == "retour")
				{
					_pathNodeIndex = stopIndex;
					chemin = globalPath;
				}
			}
		}
		
		public function randomPath () : void
		{
			var origin : FlxPoint = this.getMidpoint();
			var possibleEnd : Array = map.getTileCoords(1);
			var endIndex : int = FlxG.random()*possibleEnd.length;
			var end : FlxPoint = possibleEnd[endIndex];
			
			while(map.getTile(end.x/32, end.y/32) != 1)
			{
				endIndex = FlxG.random()*possibleEnd.length;
			}
	
			end = possibleEnd[endIndex];
			
			chemin = map.findPath(origin, end);
			chemin.add(0, 0);
			globalPath = chemin;
			this.followPath(chemin);
		}
	}
}
