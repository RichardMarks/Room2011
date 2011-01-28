package engine 
{
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class Dungeon 
	{
		
		private var mapWidth:Number;
		private var mapHeight:Number;
		private var mapSize:Number;
		
		private var map:Vector.<MapCell>;
		public function get Map():Vector.<MapCell> { return map; }
		
		public function CreateTestMap():void
		{
			CreateMap(21, 21);
			
			// add a wall around the outside of the map
			var i:Number = 0, top:Number = 0, bottom:Number = mapHeight - 2, left:Number = 0, right:Number = mapWidth - 2;
			
			for (i = 1; i < mapWidth - 1; i++)
			{
				map[i] = MapCell.MakeNorthWallCell([]);
				map[i + (bottom * mapWidth)] = MapCell.MakeSouthWallCell([]);
			}
			
			for (i = 1; i < mapHeight - 1; i++)
			{
				map[i * mapWidth] = MapCell.MakeWestWallCell([]);
				map[right + (i * mapWidth)] = MapCell.MakeEastWallCell([]);
			}
			
			map[0] = MapCell.MakeNorthWestWallCell([]);
			map[right] = MapCell.MakeNorthEastWallCell([]);
			map[bottom * mapWidth] = MapCell.MakeSouthWestWallCell([]);
			map[right + (bottom * mapWidth)] = MapCell.MakeSouthEastWallCell([]);
		}
		
		public function CreateMap(width:Number, height:Number):void
		{
			// set the map size
			mapWidth = width;
			mapHeight = height;
			mapSize = mapWidth * mapHeight;
			
			// create the map
			map = new Vector.<MapCell>(mapSize);
			for (var i:Number = 0; i < mapSize; i++)
			{
				map[i] = MapCell.MakeOpenCell([]);
			}
		}
		
		public function SetCell(x:Number, y:Number, cell:MapCell):void
		{
			x %= mapWidth;
			y %= mapHeight;
			map[x + (y * mapWidth)] = cell;
		}
		
		public function GetCell(x:Number, y:Number):MapCell
		{
			x %= mapWidth;
			y %= mapHeight;
			return map[x + (y * mapWidth)];
		}
		
		public function Dungeon() 
		{
			
		}
		
	}
}