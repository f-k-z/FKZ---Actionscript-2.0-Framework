/**
 * @author François Gillet/FKZ
 * @date 2008_04_11
 * @description scroll content with or without easing
 * @install require the package Tweener
 */

import caurina.transitions.Tweener;
import fkz.utils.MathUtils;
import mx.transitions.easing.*;

class fkz.scroll.SimpleScroll {
	
	//ui
	var mcMain:MovieClip;
	var mcTop:MovieClip;
	var mcDown:MovieClip;
	var mcScroll:MovieClip;
	var mcContainer:MovieClip; 
	var mcMask:MovieClip;
	var bEasing:Boolean;
	//val
	var nMaxY:Number;
	var nbIn:Number;
	var nbOut:Number;
	var nLimite:Number;
	var nInc:Number;
	
	/* construct :
	* - mc_scroll : mc for scroll
	* - mc_container : mc to scroll
	* - mc_mask : mc mask
	* - easing : true or false
	* - lgScroll : length of the scrollBar, position top of the scroll is his _y and of his bottom is his _y+lgScroll
	*/
	public function SimpleScroll(mc_scroll:MovieClip, mc_container:MovieClip, mc_mask:MovieClip, easing:Boolean, lgScroll:Number) {
		mcScroll = mc_scroll;
		mcContainer = mc_container; 
		mcMain = mcContainer._parent;
		mcMask = mc_mask;
		mcMask.cacheAsBitmap = true;
		mcContainer.cacheAsBitmap = true;
		mcContainer.setMask(mcMask);
		bEasing = easing;
		nLimite = mcContainer._y;
		nbIn = mc_scroll._y;
		nbOut =  mc_scroll._y+lgScroll;
		refresh();
		_initScroll();
		_initMouseWheel();
	}
	
	/* set scroll button for top & down
	*  - incValue : incrementation value
	*/
	public function setBtScroll(mc_top:MovieClip, mc_down:MovieClip, incValue:Number){
		mcTop = mc_top;
		mcDown = mc_down;
		nInc = incValue;
		_initBtScroll();
	}
	
	/* refresh the scroll (if the height of the container are changing)  */
	public function refresh(){
		nMaxY = (mcContainer._height - mcMask._height) + 20;
	}
	
	private function _initScroll() {
		var _this = this;
		mcScroll.onPress = function(){
			startDrag(this, false, this._x, _this.nbIn, this._x, _this.nbOut);
			_this._scrollText();
		}
		mcScroll.onRelease = mcScroll.onReleaseOutside = function(){
			stopDrag();
			_this._stopScrollText();
		}
	}
	
	private function _initBtScroll() {
		var _this = this;
		mcDown.onPress = function() {
			this.onEnterFrame = function(){
				_this._incScroll(-_this.nInc);
			}
		}
		mcTop.onPress = function() {
			this.onEnterFrame = function(){
				_this._incScroll(_this.nInc);
			}
		}
		
		mcTop.onRelease = mcTop.onReleaseOutside = mcDown.onRelease = mcDown.onReleaseOutside = function() {
			delete this.onEnterFrame;
		}
	}
	
	private function _initMouseWheel() {
		var _this = this;
		var mouseListener:Object = new Object();
		mouseListener.onMouseWheel = function(delta) {
			_this._incScroll(delta);
		}
		Mouse.addListener(mouseListener);
	}
	
	private function _incScroll(value:Number) {
		var nextY:Number = mcScroll._y - value;
		if (nextY > nbIn && nextY < nbOut) {
			if(bEasing)
				Tweener.addTween(mcScroll, { _y:nextY, time:0.4, transition:Strong.easeOut } );
			else
				mcScroll._y = nextY;
			_displaceScroll(nextY);
		}
		else if (nextY < nbIn) {
			if(bEasing)
				Tweener.addTween(mcScroll, { _y:nbIn, time:0.4, transition:Strong.easeOut } );
			else
				mcScroll._y = nbIn;
			_displaceScroll(nbIn);
		}
		else if (nextY > nbOut) {
			if(bEasing)
				Tweener.addTween(mcScroll, { _y: nbOut, time:0.4, transition:Strong.easeOut } );
			else
				mcScroll._y =  nbOut;
				_displaceScroll(nbOut);
		}
	}
	
	private function _scrollText() {
		var _this = this;
		mcMain.onEnterFrame = function(){
			_this._displaceScroll(mcScroll._y);
		}
	}

	private function _displaceScroll(posi:Number){
		var pourc = MathUtils.valToPourcent(posi, nbIn, nbOut);
		var realPourc = 100-pourc;
		var nextY = Math.round(nLimite - (nMaxY * (realPourc / 100)));
		if(bEasing)
			Tweener.addTween(mcContainer, { _y:nextY, time:0.6, transition:Strong.easeOut } );
		else
			mcContainer._y = nextY;
	}

	private function _stopScrollText(){
		delete mcMain.onEnterFrame;
	}
	
}