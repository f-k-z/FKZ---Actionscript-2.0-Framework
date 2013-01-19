/**
 * @author François Gillet/FKZ
 * @date 2008_04_11
 * @description get a XML into an Array
 */

class fkz.xml.XML2Array
{
	public function XML2Array(){}
	
	//////////// renvoie objet copiant un XML \\\\\\\\\\\\
	
	public static function getObject(xmlData:XML):Object{
		var oData:Object = {};
		_getObject(xmlData.firstChild, oData);
		return oData;
	}
	
	//////////// copie un noeud dans un objet \\\\\\\\\\\\
	
	private static function _getObject(xmlData:XMLNode, oData:Object){
		oData._name = xmlData.nodeName;
		if(oData._name != null){
			oData._attributes = {};
			for(var i in xmlData.attributes){
				oData._attributes[i] = xmlData.attributes[i];
			}
			if(xmlData.firstChild.nodeValue == null){
				for(var i = 0; i < xmlData.childNodes.length; i++){
					var node:XMLNode = xmlData.childNodes[i];
					if(node.nodeName != null){
						if(oData[node.nodeName] == null){
							oData[node.nodeName] = [];
						}
						var obj:Object = {};
						obj._parent = oData[node.nodeName];
						oData[node.nodeName].push(obj);
						_getObject( node, obj );
					}
				}
			} else {
				oData._value = xmlData.firstChild.nodeValue;
			}
			// SHORTCUT : recopie les propriétés du premier élément du tableau dans le noeud parent
			if(oData._parent instanceof Array){
				for(var j in oData){
					if(j != "_parent"){
						oData._parent[j] = oData[j];
					}
				}
			}
		}
	}
	
	//////////// renvoie un XML copiant un objet \\\\\\\\\\\\
	
	public static function getXML(oData:Object):XML{
		var xmlData:XML = new XML();
		_getXML(oData, xmlData);
		return xmlData;
	}
	
	//////////// transforme un objet en XML \\\\\\\\\\\\
	
	private static function _getXML(oData:Object, rootElement:XMLNode)
	{
		var newElement:XMLNode = new XML().createElement(oData._name);
		rootElement.appendChild(newElement);
		for(var i in oData._attributes){
			newElement.attributes[i] = oData._attributes[i];
		}
		if(oData._value == null){
			var aData:Array = [];
			for (var i in oData){
				if(i.indexOf("_") == -1) aData.push(oData[i]);
			}
			aData.reverse();
			for (var i=0 ; i<aData.length; i++){
				if(aData[i] instanceof Array){
					for(var j=0; j<aData[i].length; j++){
						_getXML(aData[i][j], newElement);
					}
				}
			}
		}
		else {
			newElement.appendChild(new XML().createTextNode(oData._value));
		}
	}
}
