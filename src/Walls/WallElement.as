
package Walls
{
	import com.ghelton.GElement;
	
	import flash.geom.Point;
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Feb 11, 2012
	 */
	public class WallElement extends GElement
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		private var _origin:Point;
		private var _config:WallConfig;
		private var _style:WallStyle;
		private var _shader:WallShader;
		private var _points:Vector.<Point>;
		public var innerEdge:Number;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function WallElement($origin:Point, $wallConfig:WallConfig, $wallStyle:WallStyle, $wallShader:WallShader)
		{
			_origin = $origin;
			_config = $wallConfig;
			_style = $wallStyle;
			_shader = $wallShader;
			_points = $wallShader.generatePoints(new Point(), _config.blockSize, _config.blockJitter).slice();
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		public function update(offset:Number, speed:Number):void
		{
			offsetCurrentPoints(speed);
			var newY:Number = 0;
			var lastPoint:Point = _points[_points.length - 1];
			
			if(lastPoint.y < _config.wallSize.y)
			{
				while(lastPoint.y < _config.wallSize.y)
				{
					var newPoints:Vector.<Point> = _shader.generatePoints(lastPoint, _config.blockSize, _config.blockJitter);
					_points = _points.concat(newPoints);
					lastPoint = _points[_points.length - 1];
				}
			}
			drawPoints(offset);
			
			if(_config.direction > 0)
				innerEdge = _config.blockSize.x - lastPoint.y;
			else
				innerEdge = _config.blockJitter.x;
		}
		
		private function drawPoints(xOffset:int):void
		{
			// Clear out old area
			graphics.clear();
			
			// Draws first wall point
			graphics.beginFill(_style.color);
			graphics.moveTo(_origin.x, _points[0].y); // top left
			
			for each(var point:Point in _points)
				graphics.lineTo(_origin.x + xOffset + (point.x * _config.direction), point.y);
				
			//final line
			graphics.lineTo(_origin.x, _config.wallSize.y);
			
			// graphics.lineTo(_origin.x, _origin.y);
			graphics.endFill();
		}
		
		private function offsetCurrentPoints(speed:Number):void
		{
			var newPoint:Point;
			var yLimit:Number = (_config.blockSize.y * 2) * -1;
			
			for each(var point:Point in _points) {
				point.y -= speed;
				
				if(point.y < yLimit) {
					delete _points[point];
				}
			}
			
		}
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}