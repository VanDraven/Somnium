package lucyds {
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;

	/**
	 * @author DXPCorp
	 */
	public class Meubles extends FlxSprite 
	{
		public var id	 : String;
		public var key 	 : Boolean = false;
		public var keyId : String;
		
		public function Meubles(X : Number, Y : Number, Graphics : Class, largeur : int, hauteur : int, id : String, key : Boolean = false, keyId : String = "") 
		{
			this.id = id;
			this.key = key;
			this.keyId = keyId;
			
			super(X*32, Y*32, Graphics);
			loadGraphic(Graphics, false, false, largeur, hauteur);
			//this.height = hauteur-32;
			//this.offset.y = 32;
		}
		
		override public function update () : void
		{
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
				
			if(keyId == "note1")
				keyIndex = 3;
			
			if(keyId == "scie")
				keyIndex = 4;
				
			if(keyId == "journal1")
				keyIndex = 5;
			
			if(keyId == "journal2")
				keyIndex = 6;
			
			if(keyId == "journal3")
				keyIndex = 7;
			
			if(keyId == "journal4")
				keyIndex = 8;
			
			if(keyId == "journal5")
				keyIndex = 9;
			
			if(keyId == "journal6")
				keyIndex = 10;
			
			if(keyId == "journal7")
				keyIndex = 11;
			
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
				if(id == "ClefPenderie")
					text = "Vous avez trouvé la clef de la penderie.";
				
				if(id == "ClefChambreParents")
					text = "Vous avez trouvé une clef.";
					
				if(id == "note1")
					text = "Vous avez trouvé une note.";
				
				if(id == "journal1" || id == "journal2" || id == "journal3" || id == "journal4" || id == "journal5" || id == "journal6" || id == "journal7")
					text = "Vous avez trouvé une page de journal.";
					
				if(id == "scie")
					text = "Vous avez trouvé une scie.";
					
				GameState.textPos = "Centre";
			}
			//meubles
			else
			{
				GameState.textPos = "Dialogue";
				text = "C'est "+id+".";
			}
			
			GameState.textFace = "neutre"; 
			GameState.texte = text;
			GameState.updateText = true;
		}
	}
}
