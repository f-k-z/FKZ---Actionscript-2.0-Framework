/**
 * @author François Gillet/FKZ
 * @date 2008_04_11
 * @description fonctions outils pour des opérations mathématiques
 */

class fkz.utils.MathUtils {
	
	private function MathUtils(){}
	
	//renvoie un chiffre aleatoirement dans un interval entre un minimum et un maximum
	public static function randRange(min:Number, max:Number):Number {
		var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
		return randomNum;
	}
	
	//renvoie la distance entre deux point
	public static function getVectorDistance(xa:Number, ya:Number, xb:Number, yb:Number):Number {
		var nDist:Number = Math.sqrt(Math.pow((xb-xa), 2)+Math.pow((yb-ya), 2));
		return nDist;
	}
	
	//renvoie le pourcentage d'une valeur entre deux bornes
	public static function valToPourcent(v:Number, borneIn:Number, borneOut:Number):Number{
		if(v>borneOut || v<borneIn){ trace ("!!! MathUtils ERROR !!! : la valeur que vous avez choisi est plus grande que sa borne de sortie ou plus petite que sa borne d'entrée !!!!"); }
		var valeurTrans:Number = Math.round((v-borneOut)/(borneIn-borneOut)*100);
		return valeurTrans;
	}

}