/**
 * @author François Gillet/FKZ
 * @date 2008_04_29
 * @description un bouton tous bidon avec un mc :)
 */

class fkz.ui.Bouton extends MovieClip
{
	public function Bouton(){}
	
	public function onRollOver()
	{
		gotoAndPlay("over");
	}
	public function onDragOver()
	{
		gotoAndPlay("over");
	}
	public function onRollOut()
	{
		gotoAndPlay("out");
	}
	public function onDragOut()
	{
		gotoAndPlay("out");
	}
	
}