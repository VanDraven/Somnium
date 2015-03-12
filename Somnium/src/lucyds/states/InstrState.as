package lucyds.states
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class InstrState extends FlxState
	{
		override public function create():void
		{
			var instructions:FlxText;
			instructions = new FlxText(FlxG.width/4, 100, FlxG.width/2,
				"Contrôles" +
				"z q s d ou haut bas gauche droite pour se déplacer\n" + 
				"Shift pour allumer et éteindre la lanterne de Rosa \n" +
				"Espace pour executer une action (ouvrir une porte ou un coffre par exemple) ou sauter pendant une phase de labyrinthe. \n" +
				"P pour mettre le jeu en pause, Echap pour retourner au menu principal" +
				"Pas d'inquiétudes, le jeu sauvegarde automatiquement votre progression." +
				"\n" +
				"Règle du jeu, mode labyrinthe : \n" +
				"\n" +
				"Allez sur la case rouge. \n" + 
				"Suivez toujours le chemin le plus sombre pour y arriver. \n" +
				"Les fantômes suivent votre lumière, éteignez-la pour les semer. \n" +
				"En haut à droite se trouve votre barre d'énergie. \n Quand elle est remplie, vous êtes capables d'exécuter 5 sauts.");
			instructions.setFormat (null, 12, 0xFFFFFFFF, "center");
			add(instructions);
			
			var instructions2:FlxText;
			instructions2 = new FlxText(0, FlxG.height - 32, FlxG.width, "Appuyez sur espace pour revenir");
			instructions2.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(instructions2);
		}
		
		override public function update():void
		{
			super.update();
			
			if(FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE"))
				FlxG.switchState(new MenuState());
		}
	}
}