
package
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.ghelton.GElement;
	import com.ghelton.WatchTower;
	import com.ghelton.Watcher;
	import com.greensock.TweenLite;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.easing.Quad;
	
	import data.ArnikaData;
	
	import flash.events.Event;
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Feb 11, 2012
	 */
	public class Arnika extends GElement
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		private static const ROTATION_AMOUNT:Number = 0.0625;
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		private var _data:ArnikaData;
		private var _ball:Ball;
		private var _moveTweenVars:TweenLiteVars;
		private var _moveTween:TweenLite;
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function Arnika($data:ArnikaData)
		{
			_data = $data;
			super();
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		override protected function init(e:Event):void
		{
			//Arnika
//			_moveTweenVars = new TweenLiteVars();
//			_moveTweenVars.y(250);
//			_moveTweenVars.ease(Quad.easeOut);
//			_moveTween = TweenLite.to(this, 4, _moveTweenVars);
			this.y = 250;
			
			//Ball
			_ball = new Ball(_data);
			addChild(_ball);
			
			//Watchers			
			WatchTower.addWatcher(new Watcher(WatchTower.frameTime, onFrame));
		}
		
		override protected function draw():void
		{
			graphics.beginFill(0);
			graphics.drawRoundRect(-25, -50, 50, 50, 60);
			graphics.endFill();
		}
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		private function onFrame(dt:uint):void
		{
			var slice:Number = dt / WatchTower.SECOND;
			
			//ARNIKA
			var moveDistance:Number = _data.moveSpeed * slice;//distance arnika moves in 1 second
			this.x += moveDistance;
			
			//decay move speed
			var uSpeed:Number = Math.abs(_data.moveSpeed);
			if(uSpeed > 1)
			{
				var decay:Number = uSpeed * 0.03125;
				trace(decay);
				_data.moveSpeed += _data.moveSpeed > 0 ? -decay : decay;
			} else {
				_data.moveSpeed = 0;
			}
			this.rotation = (_data.startingX - this.x) * ROTATION_AMOUNT;
			
			//BALL
//			_ball.rotation += _data.ballMoveSpeed;
		}
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}