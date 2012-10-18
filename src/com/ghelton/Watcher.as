
package com.ghelton
{
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since May 6, 2012
	 */
	public class Watcher
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		public var interval:uint;
		public var tick:Function;
		public var complete:Function;
		public var repeat:int;
		public var paused:Boolean = false;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function Watcher($interval:uint, $tick:Function, $complete:Function = null, $repeat:int = -1)
		{
			interval = $interval;
			tick = $tick;
			complete = $complete;
			repeat = $repeat;
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