/**
 * @author François Gillet/FKZ
 * @date 2008_04_24
 * @description load an XML and Call XML2Array to convert him into an Object
 */

import fkz.xml.XML2Array;
 
class fkz.xml.FkzXML
{
	
	public var originalXML:XML;
	
	private var oData:Object;
	
	public function FkzXML(XMLpath:String) {
		var _this:FkzXML = this;
		originalXML = new XML();
		originalXML.ignoreWhite = true;
		originalXML.onLoad = function(s:Boolean) {
			if (s) _this._loadedXML();
			else trace("ERROR : XML : "+XMLpath+" is not loaded");
		}
		originalXML.load(XMLpath);
	}
	
	public function get data():Object {
		return oData;
	}
	
	private function _loadedXML() {
		oData = XML2Array.getObject(originalXML);
		onXMLloaded();
	}
	
	//listener
	public function onXMLloaded() { };

}