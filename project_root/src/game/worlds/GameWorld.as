package game.worlds 
{
	import engine.Dungeon;
	import game.entities.View;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class GameWorld extends World 
	{
		public function GameWorld() { }
		
		static public var view:View;
		static public var dungeon:Dungeon;
		
		override public function begin():void 
		{
			dungeon = new Dungeon;
			
			dungeon.CreateTestMap();
			
			view = new View;
			add(view);
			
			super.begin();
		}
	}
}