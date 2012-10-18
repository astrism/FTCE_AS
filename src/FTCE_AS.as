
package
{
	import Emitter.Emitter;
	import Emitter.EmitterSet;
	
	import Shaders.Rock;
	
	import Walls.WallConfig;
	import Walls.WallElement;
	import Walls.WallStyle;
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.ghelton.WatchTower;
	import com.ghelton.Watcher;
	import com.greensock.plugins.DynamicPropsPlugin;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import data.ArnikaData;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	[SWF(width="640", height="960", version_major="10", frameRate="60")]
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Feb 11, 2012
	 */
	public class FTCE_AS extends Sprite
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		private var _wallStyle:WallStyle;
		private var _leftConfig:WallConfig;
		private var _leftWall:WallElement;
		private var _rightConfig:WallConfig;
		private var _rightWall:WallElement;
		private var _arnika:Arnika;
		private var _arnikaData:ArnikaData;
		private var _backgroundAni:MovieClip;
//		private var _arnikaController:ArnikaController;
		private var _wallSize:Point;
		private var _emitter:Emitter;
		
		private var _wallOffset:Number = 0;
		private var _fallSpeed:Number = 5;
		private var _moveTime:Number = 1000;
		private var _moveEnd:Number;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function FTCE_AS()
		{
			super();
			MonsterDebugger.initialize(this);
			TweenPlugin.activate([DynamicPropsPlugin]);
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			TweenPlugin.activate([DynamicPropsPlugin, TransformAroundCenterPlugin]);
			
			_wallSize = new Point(stage.stageWidth, stage.stageHeight);
			var blockSize:Point = new Point(200, 50);
			var blockJitter:Point = new Point(150, 20);
			var rockShader:Rock = new Rock();
			_wallStyle = new WallStyle(0x000000);
			
			_leftConfig = new WallConfig(_wallSize, blockSize, blockJitter, WallConfig.WALL_FACE_RIGHT);
			_leftWall = new WallElement(new Point(0, 0), _leftConfig, _wallStyle, rockShader);
			
			_rightConfig = new WallConfig(_wallSize, blockSize, blockJitter, WallConfig.WALL_FACE_LEFT);
			var rightOrigin:Point = new Point(_wallSize.x, 0);
			_rightWall = new WallElement(rightOrigin, _rightConfig, _wallStyle, rockShader);
			
			_arnikaData = new ArnikaData();
			_arnikaData.startingX = _wallSize.x / 2;
			_arnika = new Arnika(_arnikaData);
			_arnika.x = _arnikaData.startingX;
			_arnika.y = -250;
			
			addChild(_leftWall);
			addChild(_rightWall);
			addChild(_arnika);
			
			// EMITTER
			var reallySmallSet:EmitterSet = new EmitterSet(ReallySmallStuff, 1);
			var smallSet:EmitterSet = new EmitterSet(MediumStuff, 3);
			var mediumSet:EmitterSet = new EmitterSet(SmallStuff, 2);
			
			var emitterArea:Rectangle = new Rectangle(
				blockSize.x, //x
				0, //y
				stage.stageWidth - (blockSize.x * 2), //width
				stage.stageHeight
			);
			_emitter = new Emitter(this, emitterArea);
			_emitter.addSet(reallySmallSet);
			_emitter.addSet(smallSet);
			_emitter.addSet(mediumSet);

			stage.addEventListener(Event.RESIZE, resizeStage);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			WatchTower.addWatcher(new Watcher(WatchTower.frameTime, onFrame));
			WatchTower.addWatcher(new Watcher(WatchTower.SECOND, onSecond));
			WatchTower.startWatching(stage);
		}
		
		
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		private function onFrame(dt:uint):void
		{
			_leftWall.update(_wallOffset, _fallSpeed);
			_rightWall.update(_wallOffset, _fallSpeed);
			
		}
		
		private function onSecond(dt:uint):void
		{
			var slice:Number = dt / WatchTower.SECOND;
			_fallSpeed += 0.005 * slice;
//			_arnikaData.ballMass += 1 * slice;
		}
		
		private function resizeStage(e:Event):void
		{
			_wallSize.x = stage.stageWidth;
			_wallSize.y = stage.stageHeight;
		}
		
		private function onMove(dir:Number):void
		{
			var speedDiff:Number = dir * (1 / _arnikaData.ballMass);
			var newSpeed:Number = _arnikaData.moveSpeed + speedDiff;
			var uNewSpeed:Number = Math.abs(newSpeed);

			if(uNewSpeed < _arnikaData.maxSpeed)
				_arnikaData.moveSpeed = newSpeed; //valid move
		}
		
		private function onRotate(dir:Number):void
		{
			var uRot:Number = Math.abs(_arnikaData.ballMoveSpeed);
			var rotDiff:Number = Math.max(uRot, 1) / _arnikaData.ballMass;
			var newRot:Number = _arnikaData.ballMoveSpeed + dir * rotDiff;
			var uNewRot:Number = Math.abs(newRot);
			if(uNewRot < _arnikaData.ballMaxSpeed)
				_arnikaData.ballMoveSpeed = newRot;
		}
		
		private function gapSize():Number
		{
			return _rightWall.innerEdge - _leftWall.innerEdge;
		}
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		private function onKeyUp(e:KeyboardEvent):void
		{
			
		}
		
		private function onKeyDown(e:KeyboardEvent):void {
			
			if(e.keyCode == 65 || e.keyCode == 37) //A Key OR Left Arrow Key
			{
				onMove(-10);
				onRotate(-10);
			}
			if(e.keyCode == 39 || e.keyCode == 68) //D Key OR Right Arrow Key
			{
				onMove(10);
				onRotate(10);
			}				
			
			
			if(e.keyCode == 27) //Esc Key
				WatchTower.pauseWatching(stage);
			
		}
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}