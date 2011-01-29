package game.entities 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.utils.*;
	
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class View extends Entity 
	{
		private const mapWidth:Number = 7;
		private const mapHeight:Number = 7;
		private const mapData:String = "wwwwwwwwsswsswwswwsswwsswwswwswwsswwssssswwwwwwww";
		
		private var mySceneBuffer:BitmapData;
		private var myGrid:Grid;
		
		private var myPreviousDirection:Point = new Point;
		private var myPreviousPlane:Point = new Point;
		
		private var myDirection:Point = new Point(0, -1);
		private var myPlane:Point = new Point(0.66, 0);
		
		public function View() 
		{
			mySceneBuffer = new BitmapData(FP.width, FP.height, true, 0xFF000000);
			
			Input.define("dpad-u", Key.UP);
			Input.define("dpad-d", Key.DOWN);
			Input.define("dpad-l", Key.LEFT);
			Input.define("dpad-r", Key.RIGHT);
			Input.define("action", Key.X);
			
			x = 1;
			y = 4;
			
			myGrid = new Grid(mapWidth, mapHeight, 1, 1);
			
			var i:Number = 0;
			for (var my:Number = 0; my < mapHeight; my++)
			{
				for (var mx:Number = 0; mx < mapWidth; mx++)
				{
					if (mapData.substr(i, 1) == "w")
					{
						myGrid.setCell(mx, my, true);
					}
					i++;
				}
			}
			
			RenderScene();
		}
		
		private function WalkForward(walkSpeed:Number):Boolean
		{
			var moved:Boolean = false;
			
			var check:Point = new Point(uint(x + myDirection.x * walkSpeed), uint(y));
			trace("walk forward request A: from", x, y, "to", check.x, check.y);
			trace("x=", x, "\n",
			"myDirection.x=", myDirection.x, "\n",
			"walkSpeed=", walkSpeed, "\n");
			
			if (!myGrid.getCell(check.x, check.y))
			{
				x = check.x;
				moved = true;
			}
			
			check.x = uint(x);
			check.y = uint(y + myDirection.y * walkSpeed);
			trace("walk forward request B: from", x, y, "to", check.x, check.y);
			trace("x=", x, "\n",
			"myDirection.x=", myDirection.x, "\n",
			"walkSpeed=", walkSpeed, "\n");
			
			if (!myGrid.getCell(check.x, check.y))
			{
				y = check.y;
				moved = true;
			}
			
			return moved;
		}
		
		private function WalkBackward(walkSpeed:Number):Boolean
		{
			var moved:Boolean = false;
			
			var check:Point = new Point(uint(x - myDirection.x * walkSpeed), uint(y));
			trace("walk backward request A: from", x, y, "to", check.x, check.y);
			trace("x=", x, "\n",
			"myDirection.x=", myDirection.x, "\n",
			"walkSpeed=", walkSpeed, "\n");
			
			if (!myGrid.getCell(check.x, check.y))
			{
				x = check.x;
				moved = true;
			}
			
			check.x = uint(x);
			check.y = uint(y - myDirection.y * walkSpeed);
			trace("walk backward request B: from", x, y, "to", check.x, check.y);
			trace("x=", x, "\n",
			"myDirection.x=", myDirection.x, "\n",
			"walkSpeed=", walkSpeed, "\n");
			
			if (!myGrid.getCell(check.x, check.y))
			{
				y = check.y;
				moved = true;
			}
			
			return moved;
		}
		
		override public function update():void 
		{
			var turnSin:Number, turnCos:Number;
			var walkSpeed:Number = 16.0 * FP.elapsed;
			var turnSpeed:Number = 45.0;
			
			var moved:Boolean = false;
			
			if (Input.pressed("dpad-u"))
			{
				moved = WalkForward(walkSpeed);
			}
			else if (Input.pressed("dpad-d"))
			{
				moved = WalkBackward(walkSpeed);
			}
			
			if (Input.pressed("dpad-r"))
			{
				turnSin = Math.sin(turnSpeed);
				turnCos = Math.cos(turnSpeed);
				
				myPreviousDirection.x = Number(myDirection.x);
				myDirection.x = myDirection.x * turnCos - myDirection.y * turnSin;
				myDirection.y = myPreviousDirection.x * turnSin + myDirection.y * turnCos;
				
				myPreviousPlane.x = Number(myPlane.x);
				myPlane.x = myPlane.x * turnCos - myPlane.y * turnSin;
				myPlane.y = myPreviousPlane.x * turnSin + myPlane.y * turnCos;
				moved = true;
			}
			else if (Input.pressed("dpad-l"))
			{
				turnSin = Math.sin(-turnSpeed);
				turnCos = Math.cos(-turnSpeed);
				
				myPreviousDirection.x = Number(myDirection.x);
				myDirection.x = myDirection.x * turnCos - myDirection.y * turnSin;
				myDirection.y = myPreviousDirection.x * turnSin + myDirection.y * turnCos;
				
				myPreviousPlane.x = Number(myPlane.x);
				myPlane.x = myPlane.x * turnCos - myPlane.y * turnSin;
				myPlane.y = myPreviousPlane.x * turnSin + myPlane.y * turnCos;
				moved = true;
			}
			
			if (moved)
			{
				x = int(x);
				y = int(y);
				//myDirection.normalize(1);
				
				moved = false;
				RenderScene();
			}
			
			super.update();
		}
		
		override public function render():void 
		{	
			FP.buffer.copyPixels(mySceneBuffer, mySceneBuffer.rect, new Point);
			
			for (var my:Number = 0; my < mapHeight; my++)
			{
				for (var mx:Number = 0; mx < mapWidth; mx++)
				{
					Image.createRect(7, 7, (myGrid.getCell(mx, my))? 0xFF0000 : 0x646464).render(new Point(mx * 8, my * 8), new Point);
				}
			}
			
			var pIcon:Point = new Point(2 + (x * 8), 2 + (y * 8));
			var pLook:Point = new Point((pIcon.x+1) + myDirection.x*4, (pIcon.y+1) + myDirection.y*4);
			
			Image.createRect(2, 2, 0xFFFFFF).render(pIcon, new Point);
			Image.createRect(1, 1, 0xFFFF00).render(pLook, new Point);
			
			super.render();
		}
		
		private function RenderScene():void
		{
			mySceneBuffer.fillRect(mySceneBuffer.rect, 0xFF000000);
			
			mySceneBuffer.fillRect(new Rectangle(0,0,mySceneBuffer.width,int(mySceneBuffer.height*0.5)), 0xFFB0C8FD);
			
			trace("rendering scene: x/y pos", x, ",", y,"facing",myDirection);
			
			for (var ix:Number = 0; ix < FP.width; ix++)
			{
				DoRay(ix);
			}
		}
		
		private function DoRay(ix:Number):void
		{
			var camX:Number = 2 * ix / Number(FP.width - 1);
			var rayX:Number = x;
			var rayY:Number = y;
			var rayDirectionX:Number = myDirection.x + myPlane.x * camX;
			var rayDirectionY:Number = myDirection.y + myPlane.y * camX;
			var mapX:Number = int(rayX);
			var mapY:Number = int(rayY);
			
			var sideDistanceX:Number = 0;
			var sideDistanceY:Number = 0;
			var dx2:Number = rayDirectionX * rayDirectionX;
			var dy2:Number = rayDirectionY * rayDirectionY;
			var deltaDistanceX:Number = Math.sqrt(1 + dy2 / dx2);
			var deltaDistanceY:Number = Math.sqrt(1 + dx2 / dy2);
			var perpendicularWallDistance:Number = 0;
			
			var stepX:Number = 0;
			var stepY:Number = 0;
			var side:Number = 0;
			var hit:Number = 0;
			
			if (rayDirectionX < 0)
			{
				stepX = -1;
				sideDistanceX = (rayX - mapX) * deltaDistanceX;
			}
			else
			{
				stepX = 1;
				sideDistanceX = (mapX + 1 - rayX) * deltaDistanceX;
			}
			
			if (rayDirectionY < 0)
			{
				stepY = -1;
				sideDistanceY = (rayY - mapY) * deltaDistanceY;
			}
			else
			{
				stepY = 1;
				sideDistanceY = (mapY + 1 - rayY) * deltaDistanceY;
			}
			
			while (!hit)
			{
				if (sideDistanceX < sideDistanceY)
				{
					sideDistanceX += deltaDistanceX;
					mapX += stepX;
					side = 0;
				}
				else
				{
					sideDistanceY += deltaDistanceY;
					mapY += stepY;
					side = 1;
				}
				
				if (myGrid.getCell(uint(mapX), uint(mapY)))
				{
					hit = 1;
				}
			}
			
			if (side == 0)
			{
				perpendicularWallDistance = Math.abs((mapX - rayX + (1 - stepX) / 2) / rayDirectionX);
			}
			else
			{
				perpendicularWallDistance = Math.abs((mapY - rayY + (1 - stepY) / 2) / rayDirectionY);
			}
			
			var lineHeight:Number = Math.abs(int(FP.height / perpendicularWallDistance));
			
			var halfLineHeight:Number = int(lineHeight * 0.5);
			var halfScreenHeight:Number = int(FP.height * 0.5);
			
			var startY:Number = -halfLineHeight + halfScreenHeight;
			var endY:Number = halfLineHeight + halfScreenHeight;
			
			if (startY < 0) 
			{ 
				startY = 0; 
			}
			
			if (endY >= FP.height)
			{
				endY = FP.height - 1;
			}
			
			/*
			trace(
				"mapX=", mapX, "\n",
				"mapY=", mapY, "\n",
				"rayX=", rayX, "\n",
				"rayY=", rayY, "\n",
				
				"side=", side, "\n",
				
				"perpendicularWallDistance=", perpendicularWallDistance, "\n",
				"lineHeight=", lineHeight, "\n",
				"halfLineHeight=", halfLineHeight, "\n",
				"halfScreenHeight=", halfScreenHeight, "\n",
				"startY=", startY, "\n",
				"endY=", endY, "\n");
			*/
			RenderLine(ix, startY, endY, (side == 1)? 0xFF56BD51 : 0xFF378833);
			
		}
		
		private function RenderLine(x:Number, startY:Number, endY:Number, color:uint):void
		{
			//trace("rendering line from", x, startY, "to", x, endY, "in color", color);
			for (var iy:Number = startY; iy < endY; iy++)
			{
				mySceneBuffer.setPixel32(x, iy, color);
			}
		}
	}
}