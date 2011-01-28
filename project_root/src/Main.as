package  
{
	import game.worlds.GameWorld;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class Main extends Engine 
	{
		
		public function Main() 
		{
			super(320, 240);
		}
		
		override public function init():void 
		{
			FP.screen.scale = 2;
			FP.world = new GameWorld;
			super.init();
		}
	}
}