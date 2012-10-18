
package Walls
{
	import flash.geom.Point;
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Feb 11, 2012
	 */
	public class WallConfig
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		public static const WALL_FACE_LEFT:int = -1;
		public static const WALL_FACE_RIGHT:int = 1;
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		public var wallSize:Point;
		public var blockSize:Point;
		public var blockJitter:Point;
		public var direction:int;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function WallConfig($wallSize:Point, $blockSize:Point, $blockJitter:Point, $direction:int)
		{
			wallSize = $wallSize;
			blockSize = $blockSize;
			blockJitter = $blockJitter;
			direction = $direction;
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}