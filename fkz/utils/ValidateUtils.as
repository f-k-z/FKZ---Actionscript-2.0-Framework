/**
 * @author François Gillet/FKZ
 * @date 2008_04_11
 * @description fonctions outils pour des tests de validation
 */

class fkz.utils.ValidateUtils {
	
	private function ValidateUtils(){}
	
	//test si une chaine de caractere est vide, indefini ou null
	public static function stringEmpty(sChaine:String):Boolean{
		var bReturn:Boolean = (sChaine == undefined || sChaine == null || sChaine == "") ? true : false ;
		return bReturn
	}
	
	//test si un mail est correctement écrit
	public static function validateMail(str:String):Boolean{
		if (str.length>=7) {
			if (str.indexOf("@")>0) {
				if ((str.indexOf("@")+2)<str.lastIndexOf(".")) {
					if (str.lastIndexOf(".")<(str.length-2)) {
						return true;
					}
				}
			}
		}
		return false;
	}	
	
	//test si un string est un nombre et verifie sa longueur : utile pr numero de tel, code postal ou année de naissance
	public static function validateStrLength(str:String, nTaille:Number) {
		if (str.length == nTaille) {
			if (isNaN(Number(str)) != true) {
				return true;
			}
		}
		return false;
	}
	
}