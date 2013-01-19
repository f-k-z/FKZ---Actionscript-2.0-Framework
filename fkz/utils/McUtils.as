/**
 * @author François Gillet/FKZ
 * @date 2008_04_11
 * @description fonctions outils pour les MovieClip
 */

class fkz.utils.McUtils {
	
	private function McUtils(){}
	
	//renvoie les points d'un clip centré de maniére absolue sur le stage (sans le positionner
	public static function getMcCentre(mc:MovieClip):Object{
		var oBounds:Object = mc.getBounds();
		var oPosParent:Object = {x:mc._parent._x, y:mc._parent._y};
		mc._parent._parent.localToGlobal(oPosParent);
		var nPosx:Number = Stage.width/2-(oBounds.xMin+oBounds.xMax)/2;
		var nPosy:Number = Stage.height/2-(oBounds.yMin+oBounds.yMax)/2;
		var nX:Number = nPosx - oPosParent.x;
		var nY:Number = nPosy - oPosParent.y;
		var oRetour:Object = {x:nX, y:nY};
		return oRetour;
	}
	
	//centre un clip sur le Stage de maniére absolu quelque soit son centre ou son niveau d'imbrication
	public static function centreMC(mc:MovieClip){
		var oCoo:Object = this.getMcCentre(mc);
		mc._x = oCoo.x;
		mc._y = oCoo.y;
	}
	
	//lit un MovieClip à l'envers
	public static function reverseMc(mc) {
	mc._currentframe = mc._totalframes;
	mc.onEnterFrame = function(){
		if(this._currentframe>1) {
			this.prevFrame();
		} else if (this._currentframe == 1) {
			mc.onReverseFinished();
			delete this.onEnterFrame;
		}
	}
}
	
}