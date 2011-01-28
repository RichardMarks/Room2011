package engine 
{
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class MapCell 
	{
		static public function MakeNorthWallCell(items:Array):MapCell
		{
			var cell:MapCell = new MapCell;
			cell.northWall = true;
			cell.southWall = false;
			cell.eastWall = false;
			cell.westWall = false;
			cell.items.length = 0;
			for each(var item:* in items)
			{
				cell.items.push(item);
			}
			return cell;
		}
		
		static public function MakeNorthWestWallCell(items:Array):MapCell
		{
			var cell:MapCell = new MapCell;
			cell.northWall = true;
			cell.southWall = false;
			cell.eastWall = false;
			cell.westWall = true;
			cell.items.length = 0;
			for each(var item:* in items)
			{
				cell.items.push(item);
			}
			return cell;
		}
		
		static public function MakeNorthEastWallCell(items:Array):MapCell
		{
			var cell:MapCell = new MapCell;
			cell.northWall = true;
			cell.southWall = false;
			cell.eastWall = true;
			cell.westWall = false;
			cell.items.length = 0;
			for each(var item:* in items)
			{
				cell.items.push(item);
			}
			return cell;
		}
		
		static public function MakeSouthWallCell(items:Array):MapCell
		{
			var cell:MapCell = new MapCell;
			cell.northWall = false;
			cell.southWall = true;
			cell.eastWall = false;
			cell.westWall = false;
			cell.items.length = 0;
			for each(var item:* in items)
			{
				cell.items.push(item);
			}
			return cell;
		}
		
		static public function MakeSouthWestWallCell(items:Array):MapCell
		{
			var cell:MapCell = new MapCell;
			cell.northWall = false;
			cell.southWall = true;
			cell.eastWall = false;
			cell.westWall = true;
			cell.items.length = 0;
			for each(var item:* in items)
			{
				cell.items.push(item);
			}
			return cell;
		}
		
		static public function MakeSouthEastWallCell(items:Array):MapCell
		{
			var cell:MapCell = new MapCell;
			cell.northWall = false;
			cell.southWall = true;
			cell.eastWall = true;
			cell.westWall = false;
			cell.items.length = 0;
			for each(var item:* in items)
			{
				cell.items.push(item);
			}
			return cell;
		}
		
		static public function MakeWestWallCell(items:Array):MapCell
		{
			var cell:MapCell = new MapCell;
			cell.northWall = false;
			cell.southWall = false;
			cell.eastWall = false;
			cell.westWall = true;
			cell.items.length = 0;
			for each(var item:* in items)
			{
				cell.items.push(item);
			}
			return cell;
		}
		
		static public function MakeEastWallCell(items:Array):MapCell
		{
			var cell:MapCell = new MapCell;
			cell.northWall = false;
			cell.southWall = false;
			cell.eastWall = true;
			cell.westWall = false;
			cell.items.length = 0;
			for each(var item:* in items)
			{
				cell.items.push(item);
			}
			return cell;
		}
		
		static public function MakeNorthSouthCoridoorCell(items:Array):MapCell
		{
			var cell:MapCell = new MapCell;
			cell.northWall = false;
			cell.southWall = false;
			cell.eastWall = true;
			cell.westWall = true;
			cell.items.length = 0;
			for each(var item:* in items)
			{
				cell.items.push(item);
			}
			return cell;
		}
		
		static public function MakeEastWestCoridoorCell(items:Array):MapCell
		{
			var cell:MapCell = new MapCell;
			cell.northWall = true;
			cell.southWall = true;
			cell.eastWall = false;
			cell.westWall = false;
			cell.items.length = 0;
			for each(var item:* in items)
			{
				cell.items.push(item);
			}
			return cell;
		}
		
		static public function MakeSolidQuadCell():MapCell
		{
			var cell:MapCell = new MapCell;
			cell.northWall = true;
			cell.southWall = true;
			cell.eastWall = true;
			cell.westWall = true;
			cell.items.length = 0;
			return cell;
		}
		
		static public function MakeOpenCell(items:Array):MapCell
		{
			var cell:MapCell = new MapCell;
			cell.northWall = false;
			cell.southWall = false;
			cell.eastWall = false;
			cell.westWall = false;
			cell.items.length = 0;
			for each(var item:* in items)
			{
				cell.items.push(item);
			}
			return cell;
		}
		
		public var northWall:Boolean = false;
		public var southWall:Boolean = false;
		public var westWall:Boolean = false;
		public var eastWall:Boolean = false;
		
		public var items:Array = [];
		
		public function MapCell() { }
		
	}
}