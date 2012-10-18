
package Emitter
{
	import flash.display.MovieClip;
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Jun 27, 2012
	 */
	public class EmitterSet
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		public var particleRep:Class;
		public var size:int;
		public var speed:Number;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function EmitterSet($particleRep:Class, $size:int, $speed:int = 5)
		{
			particleRep = $particleRep;
			size = $size;
			speed = $speed;
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