/**
 * @author François Gillet/FKZ
 * @date 2008_04_24
 * @description World 3D for sprite 2D
 */

import fkz.simple3D.Camera3D;
import flash.filters.BlurFilter;
 
class fkz.simple3D.World3D extends Object {
	
	public var nWidth:Number;
	public var nHeight:Number;
	public var cam:Camera3D;
	
	private var nFx:Number;
	private var nFy:Number;
	private var aMcElements:Array; //Elements of the World
	private var nAngle:Number; 

	public function World3D(w:Number, h:Number, a:Number) {
		setDimensions(w, h, a);
	}
	
	public function setDimensions(w:Number, h:Number, a:Number) {
		nWidth = w;
		nHeight = h;
		nAngle = a;
		_generateFactor()
	}
	
	public function set camera(c:Camera3D) {
		this.cam = c;
		this.cam.world = this;
	}
	
	public function set elements(a:Array) {
		if (a != null){
			aMcElements = a;
			for (var i=0; i<aMcElements.length; i++) {
				aMcElements[i].world = this;
			}
		}
		else
			aMcElements = [];
	}
	
	public function addElement(mc:MovieClip) {
		aMcElements.push(mc);
		mc.world = this;
	}
	
	//mise à jour des coordonnées de tous les mc dans le repere
	public function updateDisplay() {
		//aMcElements.sortOn(["z"]); trie par z (ne marche pas)
		for (var i=0; i<aMcElements.length; i++) {
			_projElements(aMcElements[i]);
		}
	}
	
	private function _generateFactor() {
		nFx = this.nWidth / (2 * Math.tan(this.nAngle));
		nFy = this.nHeight / (2 * Math.tan(this.nAngle));
	}
	
	private function _projElements(sprite:MovieClip) {
		sprite._visible = (cam.z - sprite.z <= -0.5) ? true : false;
		if(sprite._visible){
			sprite.u = nFx * (cam.x - sprite.x) / (cam.z - sprite.z) + this.nWidth / 2;
			sprite.v = nFy * (cam.y - sprite.y) / (cam.z - sprite.z) + this.nHeight / 2;
			sprite._x = Math.round(sprite.u);
			sprite._y = Math.round(sprite.v);
			sprite.scale = Math.round(100 / (sprite.z - cam.z));
			sprite._yscale = sprite._xscale = sprite.scale;
			sprite.swapDepths(sprite.scale*100);
			sprite.filters = [new BlurFilter(sprite.z-(cam.z+2), sprite.z-(cam.z+2), 2)];
		}
	}
}