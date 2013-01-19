/**
 * @author François Gillet/FKZ
 * @date 2008_04_11
 * @description fonctions outils pour les conversion
 */

class fkz.utils.ConvertUtils {
	
	private function ConvertUtils(){}
	
	//convertit un String "true" ou "false" en un boolean
	public static function convertToBoolean(str:String):Boolean{
		var bBool:Boolean;
		if(str == "true"){
			bBool = true;
		}
		else if(str == "false"){
			bBool = false;
		}
		else{
			trace ("!!! ConvertUtils ERROR !!! : la chaîne de caractère que vous voulez convertir ne peut pas être convertit en booleen car elle n'est pas sous la forme \"true\" ou \"false\"");
		}
		return bBool;
	}
}