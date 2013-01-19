/**
 * @author François Gillet/FKZ
 * @date 2008_04_29
 * @description load an Image with draw a bmpData to avoid pixel
 */

import flash.display.BitmapData;
 
class fkz.load.BmpDataLoader extends MovieClipLoader
{	
	public var mcContainer:MovieClip;
	
	public function BmpDataLoader(){}
	
	public function loadBmp(url:String, container:MovieClip)
	{		
		mcContainer = container;
		var mcSubCont:MovieClip = mcContainer.createEmptyMovieClip("mcSubCont", mcContainer.getNextHighestDepth());
		var oListener:Object = new Object();
		oListener.container = mcSubCont;
		
		oListener.onLoadInit = function(target_mc:MovieClip){
			target_mc._x = -(target_mc._width/2);
			target_mc._y = -(target_mc._height/2);
	        var bmp:BitmapData = new BitmapData(target_mc._width, target_mc._height, true);
    	    target_mc.attachBitmap(bmp, target_mc.getNextHighestDepth(), "auto", true);
	        bmp.draw(target_mc);
		}
		
		this.addListener(oListener);
		this.loadClip(url, mcSubCont);
	}
}