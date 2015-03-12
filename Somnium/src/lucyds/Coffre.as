package lucyds {
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;

	/**
	 * @author DXPCorp
	 */
	public class Coffre extends FlxSprite 
	{
		[Embed(source="assets/img/meuble/coffreOuvert.png")]
		private var coffreOImg : Class;
		[Embed(source="assets/img/meuble/coffreFerme.png")]
		private var coffreFImg : Class;
			
		private var room : Room;
		private var index : int;
		private var keyId : String;
		private var key : Boolean = true;
		private var id : String = "Le coffre est vide";
		
		public function Coffre(X : Number, Y : Number, room : Room, index : int, keyId : String) 
		{
			super(X*32, Y*32);
			this.room = room;
			this.index = index;
			this.keyId = keyId;
		}
		
		override public function update() : void
		{
			if(this.isTouching(ANY) && FlxG.keys.justPressed("SPACE"))
				room.closedChests[index] = false;
			
			if(room.closedChests[index] == true)
				loadGraphic(coffreFImg, false, false, 47, 48, false);
			else
				loadGraphic(coffreOImg, false, false, 47, 48, false);
				
			if(this.isTouching(ANY) && FlxG.keys.justReleased("SPACE"))
			{
				if(keyId != "")
					checkKey(keyId);
					
				if(key)
				{
					generateText(keyId);
					grabKey(keyId);
				}
				else
					generateText(id);
			}
			
			super.update();
		}
		
		public function getKeyIndex(keyId : String) : uint
		{
			var keyIndex : uint;
			
			if(keyId == "ClefPenderie")
				keyIndex = 0;
			
			if(keyId == "ClefChambreParents")
				keyIndex = 1;
			
			if(keyId == "doudou")
				keyIndex = 2;
			
			
			return keyIndex;
		}
		
		public function grabKey(keyId : String) : void
		{
			GameState.clefs[getKeyIndex(keyId)] = true;
			this.key = false;
		}
		
		public function checkKey(keyId : String) : void
		{
			if(GameState.clefs[getKeyIndex(keyId)] != true)
				this.key = true;
			else
				this.key = false;
		}
		
		public function generateText(id : String) : void
		{
			var text : String;
			
			//clefs
			if(key)
			{
				if(id == "doudou")
					text = "Vous avez retrouvé le doudou";
					
				GameState.textPos = "Centre";
			}
			//meubles
			else
			{
				GameState.textPos = "Dialogue";
				text = id;
			}
			
			GameState.texte = text;
			GameState.updateText = true;
		}
	}
}
