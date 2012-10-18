
package Emitter
{
	import com.ghelton.WatchTower;
	
	import flash.display.MovieClip;
	
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Jun 28, 2012
	 */
	public class Particle
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		private var _size:int;
		private var _speed:Number;
		public var rep:MovieClip;
		public var height:Number;
		// CONSTRUCTOR
		//--------------------------------------
		public function Particle($rep:MovieClip, $size:int, $speed:Number)
		{
			super();
			rep = $rep;
			_size = $size;
			_speed = $speed;
			rep.cacheAsBitmap = true;
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		public function move(dt:uint):Boolean
		{
			_speed += _size;
			rep.y -= Math.log(_speed * (dt / WatchTower.SECOND));
			rep.rotation += Math.log(Math.random() / _speed);
			
			if(rep.y <= -rep.height)
			{
				return false;
			}
			return true;
		}
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}