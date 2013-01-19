/**
 * @author François Gillet/FKZ
 * @date 2008_04_24
 * @description sprite 2D (MC)
 */

import fkz.simple3D.World3D;
import mx.transitions.Tween;

class fkz.simple3D.Sprite2D extends MovieClip {
	
	public var world:World3D
	
	public var x:Number;
	public var y:Number;
	public var z:Number;
	public var scale:Number;
	public var u:Number;
	public var v:Number;
	
	private var tX:Tween;
	private var tY:Tween;
	private var tZ:Tween;
	
	public function Sprite2D() {
		x = y = z = 0;
	}
	
	
	public function slide(x:Number, y:Number, z:Number, duration:Number, ease) {
		var _this:Sprite2D = this;
		
		tX.stop();
		tX = new Tween(this, "x", ease, this.x, x, duration, true);
		tY.stop();
		tY = new Tween(this, "y", ease, this.y, y, duration, true);
		tZ.stop();
		tZ = new Tween(this, "z", ease, this.z, z, duration, true);
		
		tX.onMotionChanged = function() {
			_this.world.updateDisplay();
			_this.onSlide();
		}
		
		tY.onMotionFinished = function() {
			_this.onSlideFinished();
		}
	}
	
	//listener
	
	public function onSlide() { }
	public function onSlideFinished(){}
	
}