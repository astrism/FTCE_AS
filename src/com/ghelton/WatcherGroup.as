
package com.ghelton
{
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since May 6, 2012
	 */
	public class WatcherGroup
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		public var nextTick:int = 0;
		public var lastTick:int;
		public var interval:uint;
		private var _watchers:Vector.<Watcher> = new <Watcher>[];
		private var _backlog:Vector.<Watcher> = new <Watcher>[];
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function WatcherGroup($interval:uint)
		{
			interval = $interval;
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		public function onTick(dt:uint):void
		{
			if(interval > 0 && nextTick < dt) //tick
			{
				lastTick += dt; //add Delta Time for total time since last tick
				
				var nextWatcher:Watcher;
				if(_backlog.length == 0)
				{
//					trace("--> START BACKLOG: ", interval);
					var watchers:Vector.<Watcher> = _watchers.concat();
					nextWatcher = watchers.pop();
					nextWatcher.tick(lastTick);
					_backlog = watchers.concat();
				} else {
//					trace("--> CONTINUE BACKLOG: ", interval);
					nextWatcher = _backlog.pop();
					nextWatcher.tick(lastTick);
				}
				
				if(_backlog.length == 0)
				{
//					trace("--> END BACKLOG: ", interval);
					nextTick = interval + nextTick - dt; // till next time
					lastTick = 0; // reset last tick
					return;
				} else {
					nextTick = 0; //tick but dont increase so that it gets fired on next round
				}
				
			} else if(nextTick < dt) // for framerate group
			{
				//tick
				nextTick = interval + nextTick - dt;
				lastTick += dt; //add Delta Time for total time since last tick

				var watcher:Watcher;
				for each(watcher in _watchers)
				{
					if(!watcher.paused)
					{
						if(watcher.repeat == -1)
							watcher.tick(lastTick);
						else if(watcher.repeat > 0)
						{
							watcher.tick(lastTick);
							watcher.repeat--;
						} else {
							watcher.complete(lastTick);
							_watchers.splice(_watchers.indexOf(watcher), 1);
						}
					}
				}
				lastTick = 0; // reset last tick
			} else {
				nextTick -= dt; // remove to bring closer to 0
				lastTick += dt; // increase time since last tick
			}
		}
		
		public function addWatcher(newWatcher:Watcher):void
		{
			if(getWatcherByTick(newWatcher.tick) == null)
				_watchers.push(newWatcher);
		}
		
		public function removeWatcher(tick:Function):void
		{
			var watcher:Watcher = getWatcherByTick(tick);
			_watchers.splice(_watchers.indexOf(watcher), 1);
		}
		
		public function getWatcherByTick(tick:Function):Watcher
		{
			var watcher:Watcher;
			for each(watcher in _watchers)
				if(watcher.tick == tick)
					return watcher;
			return null;
		}
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}