
package
{
	import com.ghelton.GElement;
	
	import data.ArnikaData;
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Feb 13, 2012
	 */
	public class Ball extends GElement
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		private var _data:ArnikaData;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function Ball($data:ArnikaData)
		{
			_data = $data;
			super();
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------
		override protected function draw():void
		{
			var size:Number = _data.ballSize * _data.ballMass;
			var halfSize:Number = size * 0.5;
			graphics.beginFill(0);
			graphics.drawRoundRect(-halfSize, -halfSize, size, size, halfSize);
			graphics.endFill();
			this.y = halfSize;
		}
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		public function update():void
		{
			redraw();	
		}
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		
	}
}