
package Walls
{
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Feb 11, 2012
	 */
	public class WallShader
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		private var _origin:Point;
		private var _config:WallConfig;
		private var _wallStyle:WallStyle;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function WallShader()
		{
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		public function generatePoints($startingPoint:Point, $size:Point, $jitter:Point):Vector.<Point>
		{
			var endPoint:Point = new Point();
			endPoint.x = Math.floor($jitter.x + Math.random() * ($size.x - $jitter.x));
			endPoint.y = $startingPoint.y + Math.floor($jitter.y + Math.random()*($size.y - $jitter.y));
			return new <Point>[endPoint];
		}
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		public function destruct():void
		{
			_origin = null;
			_config = null;
			_wallStyle = null;
		}
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}