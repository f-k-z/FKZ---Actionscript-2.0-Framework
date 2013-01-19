/**
 * @author François Gillet/FKZ
 * @date 2008_04_11
 * @description gestion des resize du Stage
 */

class fkz.stage.StageManager{
	
	//instance
	private static var _stageManager:StageManager;
	
	//propriétées
	
	/*tableau contenant toutes les fonctions pour le resize du site : 
	* contient des objets de forme {scope, func, args}*/
	var aFunc:Array; 
	
	///////////////////////////////////CONSTRUCTEUR (Singleton)
	private function StageManager() {
		aFunc = [];
		//alignement par defaut
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		//création du listener appelé pendant le resize
		var sListener:Object = new Object();
		sListener.onResize = function(){
			_stageManager.resizeElements()
		}
		Stage.addListener(sListener);
	}
	
	static function getInstance():StageManager {
		if(!_stageManager) _stageManager= new StageManager();
		return _stageManager;
	}
	
	//////////////////////Setter & Getter
	
	//renvoie le tableau d'enregistrement
	function get registerArray():Array{
		return aFunc;
	}
	
	//////////////////////METHODES
	
	//enregistre une fonction
	function addFunction(oFunct:Object){
		aFunc.push(oFunct);
	}
	
	
	//définit les paramétres du stage
	function setParam(sAlign:String, sScale:String){
		Stage.align = sAlign;
		Stage.scaleMode = sScale;
	}
	
	//déclenche toutes les fonctions enregistrées dans le resize manager
	function resizeElements(){
		for(var i=0; i<aFunc.length; i++){
			aFunc[i].scope[aFunc[i].func].apply(aFunc[i].scope, aFunc[i].args);
		}
	}
	
	/////////////////////////////////DEBUG
	//sert au debug : trace les fonctions enregistrées dans le Stage Manager
	function toDebug(){
		trace("/////////////////////// DEBUG : Stage Manager ");
		trace("Stage Manager : Parametres : ");
		trace("- Stage.align : "+Stage.align);
		trace("- Stage.scaleMode : "+Stage.scaleMode);
		trace("Stage Manager : Fonctions managées par le StageManager :");
		for(var i=0; i<aFunc.length; i++){
			if(aFunc[i].args){
				trace("- scope : "+aFunc[i].scope+" function : "+aFunc[i].func+" arguments : "+aFunc[i].args);
			}
			else{
				trace("- scope : "+aFunc[i].scope+" function : "+aFunc[i].func);
			}
		}
		trace("///////////////////////");
	}
}