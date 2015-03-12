package lucyds.states {
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.plugin.FlxInputText;

	public class ProfileState extends FlxState 
	{
		
		private var inputName : FlxInputText = new FlxInputText(FlxG.width / 2, FlxG.height / 2 - 64, 120);
		
		public function ProfileState() 
		{
			var name : FlxText;
			name = new FlxText(0, FlxG.height / 2 - 128, FlxG.width, "Entrez votre nom :");
			name.setFormat (null, 32, 0xFFFFFFFF, "center");
			add(name);
			
			inputName.backgroundColor = 0xffff0000;
			inputName.setMaxLength(10);
			inputName.hasFocus = true;
			inputName.draw();
			add(inputName);
			
		}
		
		override public function update() : void
		{
		}
	}
}
