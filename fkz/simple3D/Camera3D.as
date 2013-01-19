/**
 * @author François Gillet/FKZ
 * @date 2008_04_24
 * @description Camera 3D for sprite 2D
 */

import fkz.simple3D.World3D;
import mx.transitions.Tween;

class fkz.simple3D.Camera3D extends Object {

	public var x:Number;
	public var y:Number;
	public var z:Number;
	
	public var world:World3D;
	
	private var tX:Tween;
	private var tY:Tween;
	private var tZ:Tween;
	
	
	public function Camera3D(nX:Number, nY:Number, nZ:Number) {
		x = nX;
		y = nY;
		z = nZ;
	}
	
	public function zoom(x:Number, y:Number, z:Number, duration:Number, ease) {
		var _this:Camera3D = this;
		
		tX.stop();
		tX = new Tween(this, "x", ease, this.x, x, duration, true);
		tY.stop();
		tY = new Tween(this, "y", ease, this.y, y, duration, true);
		tZ.stop();
		tZ = new Tween(this, "z", ease, this.z, z, duration, true);
		
		tX.onMotionChanged = function() {
			_this.world.updateDisplay();
			_this.onZoom();
		}
		
		tY.onMotionFinished = function() {
			_this.onZoomFinished();
		}
	}
	
	public function activateArrowNavigation(mc:MovieClip, vit:Number){
		var _this:Camera3D = this;
		mc.onEnterFrame = function() {
			if (Key.isDown(Key.UP)) {
				_this.z += vit;
				_this.world.updateDisplay();
				
			}
			if (Key.isDown(Key.DOWN)) {
				_this.z -= vit;
				_this.world.updateDisplay();
			}
			if (Key.isDown(Key.LEFT)) {
				_this.x -= vit;
				_this.world.updateDisplay();
			}
			if (Key.isDown(Key.RIGHT)) {
				_this.x += vit;
				_this.world.updateDisplay();
			}
			if (Key.isDown(Key.PGUP)) {
				_this.y -= vit;
				_this.world.updateDisplay();
			}
			if (Key.isDown(Key.PGDN)) {
				_this.y += vit;
				_this.world.updateDisplay();
			}
		};
	}
	
	//listener
	
	public function onZoom() { }
	public function onZoomFinished(){}
}