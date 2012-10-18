
package com.ghelton
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * Basic Element that supports cleanup
	 *
	 * @author G$
	 * @since Feb 11, 2012
	 */
	public class GElement extends Sprite
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function GElement()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, initComplete, false, 0, true);
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		protected var _drawn:Boolean = false;
		
		private function initComplete(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initComplete);
			init(e);
			addedToStage(e);
			draw();
			_drawn = true;
		}
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		protected function init(e:Event):void
		{
			//initializes children, adds children to stage, instantiates timers
		}
		
		protected function removedFromStage(e:Event):void
		{
			// - removes EventListeners, stops & resets timers, cleans up mem intensive objects
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
		}
		
		protected function addedToStage(e:Event):void
		{
			// - adds EventListeners, plays timers, 
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage, false, 0, true);
			//sub classes must call redraw manually if it is needed
		}
		
		public function destruct():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			// calls destruct on children
			// does not remove children from stage
			// destruction of super class happens after calling destruct on children
			if(parent != null)
				parent.removeChild(this);
		}
		
		protected final function redraw():void
		{
			if(_drawn)
			{
				clear();
				draw();
			}
		}
		
		protected function clear():void
		{
			graphics.clear();
		}
		
		protected function draw():void
		{
			// positions children, render current state, draws graphics
		}
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}