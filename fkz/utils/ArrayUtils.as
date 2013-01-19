/**
 * @author François Gillet/FKZ
 * @date 2008_04_11
 * @description fonctions outils pour les tableaux
 */

class fkz.utils.ArrayUtils {
	
	private function ArrayUtils(){}

	// trie un tableau aléatoirement
	public static function randArray (aTab:Array) {
		var nTaille = aTab.length;
		for (var i = 0; i<nTaille; i++) {
			var nRand:Number = Math.round(Math.random()*(nTaille-1));
			var tmp = aTab[i];
			aTab[i] = aTab[nRand];
			aTab[nRand] = tmp;
		}
	}
	
	// renvoie un tableau trié aléatoirement
	public static function getRandArray (aTab:Array):Array {
		var aTab2:Array = aTab.slice();
		var nTaille = aTab2.length;
		for (var i = 0; i<nTaille; i++) {
			var nRand:Number = Math.round(Math.random()*(nTaille-1));
			var tmp = aTab2[i];
			aTab2[i] = aTab2[nRand];
			aTab2[nRand] = tmp;
		}
		return aTab2;
	}
	
	//test si un element (object, number ou string) est présent dans un Array
	public static function searchInArray(oTest:Object, aTest:Array):Boolean{
		var bReturn:Boolean = false;
		for (var i=0; i<aTest.length; i++){
			if(oTest == aTest[i]) {
				bReturn = true;
				break;
			}
		}
		return bReturn
	}
}