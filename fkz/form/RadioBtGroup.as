/**
 * @author François Gillet/FKZ
 * @date 2008_04_11
 * @description Group de Radio Button : la valeur courante du group est indexé sur le nom des radio bt
 */

import fkz.form.RadioBt;
 
class fkz.form.RadioBtGroup {

	public var crtVar:String;
	
	private var crtBt:RadioBt;
	private var aGroup:Array;
	private var lgStartVar:Number; //longueur
	
	
	public function RadioBtGroup(group:Array, lgSub:Number) {
		aGroup = group;
		lgStartVar = lgSub;
		for (var i = 0; i < aGroup.length; i++)
			_initBt(aGroup[i]);
	}
	
	private function _initBt(rBt:RadioBt) {
		var _this:RadioBtGroup = this;
		rBt.onReleaseBt = function() {
			_this.crtBt = this;
			_this._unSelectGroup();
			_this.crtVar = this._name.substring(_this.lgStartVar, this._name.length);
			_this.onChangedState();
		}
	}
	
	private function _unSelectGroup() {
		for (var i = 0; i < aGroup.length; i++) {
			if(aGroup[i] != crtBt)
				aGroup[i].unSelect();
		}
	}
	
	//listener
	public function onChangedState() {}
	
}