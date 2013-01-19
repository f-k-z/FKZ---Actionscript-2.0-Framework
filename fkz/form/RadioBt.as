/**
 * @author François Gillet/FKZ
 * @date 2008_04_11
 * @description Radio Button de formulaire
 */

class fkz.form.RadioBt extends MovieClip {

	public var selected:Boolean
	
	public function RadioBt() {
		selected = false;
		this.gotoAndStop(1);
	}
	
	public function onRelease() {
		if(!selected) select();
		else unSelect();
		onReleaseBt();
	}
	
	public function select() {
		selected = true;
		this.gotoAndStop(2);
	}
	
	public function unSelect() {
		selected = false;
		this.gotoAndStop(1);
	}
	
	//listener
	public function onReleaseBt() {}
}