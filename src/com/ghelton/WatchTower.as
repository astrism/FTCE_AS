package com.ghelton
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.getTimer;

	public class WatchTower
	{
		
		public static const TENTH:uint = 100;
		public static const SECOND:uint = 1000;
		public static var frameTime:uint = 0;
		
		public function WatchTower()
		{
		}
		
		public static function startWatching(stage:Stage):void
		{
			frameTime = SECOND / stage.frameRate;
			stage.addEventListener(Event.ENTER_FRAME, watch);
		}
		
		public static function pauseWatching(stage:Stage):void
		{
			stage.removeEventListener(Event.ENTER_FRAME, watch);
		}
		
		public static function watch(e:Event):void {
			now = getTimer();
			dt = now - last;
			last = now;
			
			var group:WatcherGroup;
			var watcher:Watcher;
			for each(group in _watcherGroups)
			{
				group.onTick(dt);
			}
		}
		
		private static var last:uint = 0;
		public static var now:uint = 0;
		public static var dt:uint = 1;
		private static var _watcherGroups:Vector.<WatcherGroup> = new <WatcherGroup>[];
		
		public static function addWatcher(watcher:Watcher):void
		{
			var watcherGroup:WatcherGroup;
			for each(watcherGroup in _watcherGroups)
			{
				if(watcherGroup.interval == watcher.interval)
				{
					watcherGroup.addWatcher(watcher);
					return;
				}
			}
			//add new group
			var newGroup:WatcherGroup = new WatcherGroup(watcher.interval);
			newGroup.addWatcher(watcher);
			_watcherGroups.push(newGroup);
		}
		public static function removeWatcher(interval:int, tick:Function):void
		{
			var watcherGroup:WatcherGroup;
			for each(watcherGroup in _watcherGroups)
			{
				if(watcherGroup.interval == interval)
				{
					watcherGroup.removeWatcher(tick);
					return;
				}
			}
		}
		
		public static function resumeWatcher(interval:int, tick:Function):void
		{
			var watcher:Watcher = getWatcher(interval, tick);
			if(watcher != null)
				watcher.paused = false;
		}
		
		public static function pauseWatcher(interval:int, tick:Function):void
		{
			var watcher:Watcher = getWatcher(interval, tick);
			if(watcher != null)
				watcher.paused = true;
		}
		
		private static function getWatcher(interval:int, tick:Function):Watcher
		{
			var watcherGroup:WatcherGroup;
			var watcher:Watcher;
			for each(watcherGroup in _watcherGroups)
			{
				if(watcherGroup.interval == interval)
				{
					watcher = watcherGroup.getWatcherByTick(tick);
					if(watcher != null)
						return watcher;
				}
			}
			return null;
		}
		
		public static function resumeWatch(stage:Stage):void
		{
			last = getTimer();
			startWatching(stage);
		}
	}
}