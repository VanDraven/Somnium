package lucyds {

	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;

	/**
	 * @author DXPCorp
	 */
	public class Room extends FlxTilemap 
	{
		public var furnitures 	: FlxGroup;
		public var furnitures2 	: FlxGroup;
		public var furnitures3 	: FlxGroup;
		public var chests		: FlxGroup;
		public var papiers		: FlxGroup; 
		public var windows		: FlxGroup;
		public var lumieres		: FlxGroup;
		public var monsters		: FlxGroup;
		public var closedChests : Array;
		
		public function Room(roomStr : String, roomTiles : Class, larg : int, furnitures : FlxGroup, furnitures2 : FlxGroup, furnitures3 : FlxGroup, chests : FlxGroup, windows : FlxGroup, closedChests : Array, monsters : FlxGroup, lights : FlxGroup) 
		{	
			this.furnitures = furnitures;
			this.furnitures2 = furnitures2;
			this.furnitures3 = furnitures3;
			this.chests = chests;
			this.windows = windows;
			this.closedChests = closedChests;
			this.monsters = monsters;
			this.lumieres = lights;
				
			var roomArr : Array = roomStr.split(",");
			for (var i : int = 0; i < roomStr.length; ++i)
			{
				roomArr[i]-- ;
				if (roomArr[i] < 0 )
					roomArr[i] = 0;
			}
			roomStr = arrayToCSV(roomArr, larg);
			
			for(var j : int = 0; j < roomStr.length; ++j)
				roomStr = roomStr.replace(" ", "");
				
			loadMap(roomStr, roomTiles, 32, 32);

		}
		
		public function portes (X : int, Y : int) : void
		{
			
		}
	}
}
