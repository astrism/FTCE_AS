
package data
{
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Feb 13, 2012
	 */
	public class ArnikaData
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		public var startingX:Number = 0;
		public var moveSpeed:Number = 0;
		public var maxSpeed:Number = 500;
		public var rotation:Number = 0;
		public var locationOffset:Number = 0;
		
		public var ballMoveSpeed:Number = 0;
		public var ballMaxSpeed:Number = 3;
		public var ballRotation:Number = 0;
		public var ballSize:Number = 100;
		public var ballMass:Number = 0.5;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function ArnikaData()
		{
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		//for tweenlite
		public function getRotation():Number
		{
			return rotation;
		}
		
		public function getLocation():Number
		{
			return startingX + locationOffset;
		}
		
		public function getBallRotation():Number
		{
			return ballRotation;
		}
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}