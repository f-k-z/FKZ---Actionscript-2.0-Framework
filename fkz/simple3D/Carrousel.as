/**
 * @author Harold Urcun (add methods getNextItem and GetPreviousItme by François Gillet/FKZ)
 * @date 2008_04_29
 * @description carroussel 4 Kurokawa
 */

//import mx.effects.Tween;
import mx.transitions.Tween;
import mx.transitions.easing.*;
import gs.TweenFilterLite;
import fkz.utils.MathUtils;
import com.gskinner.geom.ColorMatrix;
import flash.filters.ColorMatrixFilter;

class fkz.simple3D.Carrousel {
	
	public var holder_mc:MovieClip;
	public var itemList:Array;
	private var oBase:Object;
	public var numOfItems:Number;
	public var radiusX:Number;
	public var radiusY:Number;
	public var minScale:Number;
	public var maxScale:Number;
	public var Angle:Number;
	public var curAngle:Number;
	public var curItem:Number;
	public var rTween:Tween;
	public var speed:Number;
	public var iTween:Tween;
	private var bRotate:Boolean;
	
	public var addListener:Function;
	public var broadcastMessage:Function;
	public var onSetItem:Function;
	public var onRotationFinished:Function;
	
	function Carrousel (target:MovieClip, pos:Object, radius:Object, itemsNumber:Number, depth:Number, holder:MovieClip) {
		oBase = { time:1, transition:Strong.easeInOut };
		holder_mc = holder || target.createEmptyMovieClip('carrousel_'+depth, depth);
		
		holder_mc._x = pos.x, holder_mc._y = pos.y;
		radiusX = radius.x, radiusY = radius.y;
		minScale = 60;
		maxScale = 100;
		Angle = 360*100;
		curAngle = Angle;
		speed = 0;
		curItem = 0;
		AsBroadcaster.initialize(this);
		addListener(this);
		numOfItems = itemsNumber;
		itemList = [];
		bRotate = false;
	}
	
	function get crtId():Number {
		return curItem;
	}
	
	function scroll (s:Number) {
		
		rTween.stop();
		var scope = this;
		
		holder_mc.onEnterFrame = function(){
			
			scope.speed += (s-scope.speed)/20;
			scope.Angle += scope.speed;

			scope.placeItems();
			
		}
		
	}
	
	function startMouseControl() {
		
		rTween.stop();
		var scope = this;
		var maxSpeed = 0.8;
		
		holder_mc.onEnterFrame = function(){
			
			//scope.radiusY += (this._ymouse/7-scope.radiusY)/20;	
			scope.speed += (-this._xmouse/300-scope.speed)/9;
			if (scope.speed > maxSpeed){
				scope.speed = maxSpeed;
			} else if (scope.speed < -maxSpeed){
				scope.speed = -maxSpeed;
			};
			scope.Angle += scope.speed;

			scope.placeItems();
			
		}
		
	}
	
	function stopMouseControl() {
		
		var scope = this;
		
		holder_mc.onEnterFrame = function(){
			
			scope.speed *= 0.9;
			scope.Angle += scope.speed;
			
			if (Math.abs(scope.speed)<0.1) {
				scope.speed = 0;
				delete this.onEnterFrame;
				broadcastMessage('onRotationFinished');
			}
			
			scope.placeItems();
			
		}
		
	}
	
	function introduceItems() {
		var nextRadius = radiusX;
		var ease = (ease)? ease : Strong.easeInOut;
		var duration = (duration)? duration : 20;
		iTween.stop();
		iTween = new Tween(this, 'radiusX', ease, 0, nextRadius, duration);
		var scope = this;
		iTween.onMotionChanged = function() {
			scope.placeItems();
		}
	}
	
	function placeItems() {
		for (var i = 0; i < numOfItems; i++) {
			var curItem = holder_mc['item_'+i];
			var rA = (curItem.angle+((90-Angle)%360))*Math.PI/180;
			curItem._x = Math.cos(rA)*radiusX;
			curItem._y = Math.sin(rA) * radiusY;
			//curItem._rotation = Math.cos(rA)*25;
			var scale = (Math.sin(rA) + 1) / 2;
			/*BRIGHTNESS*/
			var brightnessValue = MathUtils.valToPourcent( minScale + (maxScale - minScale) * scale, minScale, maxScale);
			var cm:ColorMatrix = new ColorMatrix();
			cm.adjustBrightness(brightnessValue*3);
			curItem.filters = [new ColorMatrixFilter(cm)];
			curItem._xscale = curItem._yscale = minScale + (maxScale - minScale) * scale;
			curItem.show = (curItem._xscale == maxScale) ? true : false;
			//curItem.b = (100-(curItem._xscale+1))/7;
			//curItem.filters = [new BlurFilter(curItem.b, curItem.b, 2)];
			curItem.swapDepths(Math.round(curItem._xscale) + 100);
		}
	}
	
	function rotateTo (a:Number, ease, duration) {
		if (!bRotate) {
			bRotate = true;
			var ease = (ease)? ease : Strong.easeInOut;
			var duration = (duration)? duration : 20;
			delete holder_mc.onEnterFrame;
			rTween.stop();
			rTween = new Tween(this, 'Angle', ease, Angle, a, duration);
			var scope = this;
			rTween.onMotionChanged = function() {
				scope.placeItems();
			}
			rTween.onMotionFinished = function() {
				scope.bRotate = false;
				scope.broadcastMessage('onRotationFinished');
			}
		}
	}
	
	function getItem (id:Number) {
		var a = holder_mc['item_'+id].angle;
		var curLap = Angle-Angle%360;
		var step = (Angle<0)? -360+(Angle-(curLap+a)) : Angle-(curLap+a);
		var step = Angle-(curLap+a);		
		if (step>180) {
			curLap += 360;
		} else if (step<-180) {
			curLap -= 360;
		}
		curItem = id;
		curAngle = curLap + a;
		rotateTo(curLap + a);
		broadcastMessage('onGetItem', id);
	}
	
	/*function slideOtherItems(id) {
		var _this = this;
		var mc = holder_mc['item_' + id];
		var aIt = getOtherItems(id);
		Tweener.addTween(mc, { _x:mc._x - 250, base:oBase, onComplete:function(){ _this.broadcastMessage('onSlideFinished')}} );
		Tweener.addTween(holder_mc.sphere, { _x:holder_mc.sphere._x + 250, base:oBase } );
		Tweener.addTween(holder_mc.reflet, {_x:holder_mc.reflet._x+250, base:oBase});
		for (var i = 0; i < aIt.length; i++) {
			var nX = 155 + (i * 210);
			Tweener.addTween(aIt[i].clip, {_x:aIt[i].nx+nX, base:oBase});
		}
	}
	
	function backOtherItems(id) {
		var _this = this;
		var mc = holder_mc['item_' + id];
		var aIt = getOtherItems(id);
		Tweener.addTween(mc, { _x:mc._x + 250, base:oBase, onComplete:function(){ _this.broadcastMessage('onBackFinished')}} );
		Tweener.addTween(holder_mc.sphere, { _x:holder_mc.sphere._x - 250, base:oBase } );
		Tweener.addTween(holder_mc.reflet, {_x:holder_mc.reflet._x-250, base:oBase});
		for (var i = 0; i < aIt.length; i++) {
			var nX = 155 + (i * 210);
			Tweener.addTween(aIt[i].clip, {_x:aIt[i].nx-nX, base:oBase});
		}
	}*/
	
	//renvoie les autres items
	function getOtherItems(id):Array {
		var aItems = [];
		for (var i = 0; i < numOfItems; i++) {
			if (i != id) {
				aItems.push({clip:holder_mc['item_' + i], nx:holder_mc['item_' + i]._x});
			}
		}
		aItems.sortOn("nx", Array.DESCENDING | Array.NUMERIC);
		return aItems;
	}
	
	function getNextItem () {
		if (!bRotate) {
			holder_mc['item_' + curItem].btn.enabled = false;
			if (curItem > 0) curItem--;
			else curItem = numOfItems - 1;
			var step = 360/numOfItems;
			curAngle -= step;
			rotateTo(curAngle);
		}
	}
	
	function getPreviousItem () {
		if (!bRotate) {
			holder_mc['item_' + curItem].btn.enabled = false;
			if (curItem < numOfItems ) curItem++;
			else curItem = 0;
			var step = 360/numOfItems;
			curAngle += step;
			rotateTo(curAngle);
		}
	}
	
	function generate () {
		for (var i = 0; i<numOfItems; i++) {
			var curItem = holder_mc.createEmptyMovieClip("item_"+i, i+1);
			curItem.id = i;
			curItem.angle = i*Math.round(360/numOfItems);
			//curItem.b = 0;
			//curItem.filters = [new BlurFilter(curItem.b, curItem.b, 2)];			
			itemList.push(curItem);
			broadcastMessage('onSetItem', curItem);
			
		}
		//introduceItems();
		placeItems();
		
	}
	
}