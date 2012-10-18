
package Emitter
{
	import com.ghelton.MathUtils;
	import com.ghelton.WatchTower;
	import com.ghelton.Watcher;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Jun 27, 2012
	 */
	public class Emitter
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		public static const MAX_PARTICLES:uint = 100;
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		private var _container:Sprite;
		private var _sets:Vector.<EmitterSet> = new <EmitterSet>[];
		private var _particles:Vector.<Particle> = new <Particle>[];
		private var _area:Rectangle;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function Emitter($container:Sprite, $area:Rectangle)
		{
			_container = $container;
			_area = $area;
			WatchTower.addWatcher(new Watcher(WatchTower.frameTime, onFrame));
			WatchTower.addWatcher(new Watcher(WatchTower.SECOND, onSecond));
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------	
		private function onFrame(dt:uint):void
		{
			var particle:Particle;
			var newSpeed:int;
			var keepParticle:Boolean;
			for each(particle in _particles)
			{
				keepParticle = particle.move(dt);
				if(!keepParticle)
				{
					_particles.splice(_particles.indexOf(particle), 1);
					_container.removeChild(particle.rep);
				}
			}
		}
		private function onSecond(dt:uint):void
		{
			var particle:Particle;
			if(_particles.length >= MAX_PARTICLES)
				return;
			
			var set:EmitterSet;
			var particleRep:MovieClip;
			var frame:uint;
			for each(set in _sets)
			{
				if(Math.random() > 0.9)
				{
					particleRep = new set.particleRep();
					particle = new Particle(particleRep, set.size, set.speed);
					particleRep.x = _area.x + (Math.random() * _area.width);
					particleRep.y = _area.height + particleRep.height;
					frame = MathUtils.randRange(0, particleRep.framesLoaded);
					particleRep.gotoAndStop(frame);
					_container.addChild(particleRep);
					_particles.push(particle);
				}	
			}
			
		}
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		public function addSet(set:EmitterSet):void
		{
			_sets.push(set);
		}
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}