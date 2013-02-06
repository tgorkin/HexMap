package hexGame;

/**
 * ...
 * @author tgorkin
 */

class MapGenerator {

	static public function generateLand(hexMap:HexMap) {
		var middleX:Int = Std.int(hexMap.xLength / 2);
		var middleY:Int = Std.int(hexMap.yLength / 2);
		
		hexMap.cells[middleX][middleY].setColor(0x00FF00);
	}
	
	static public function generateGuassian(hexMap:HexMap) {
		var middleX:Int = Std.int(hexMap.xLength / 2);
		var middleY:Int = Std.int(hexMap.yLength / 2);
		var middleHex:Hex = hexMap.cells[middleX][middleY];
		
		var hex:Hex;
		var z:Float;
		var amp:Float = 0xFFFFFF;
		var xSpread:Float = 100.0;
		var ySpread:Float = 100.0;
		for (x in 0...hexMap.xLength) {
			for (y in 0...hexMap.yLength) {
				hex = hexMap.cells[x][y];
				var nx:Float = Math.pow(hex.x - middleHex.x, 2);
				var dx:Float = 2 * Math.pow(xSpread, 2);
				var ny:Float = Math.pow(hex.y - middleHex.y, 2);
				var dy:Float = 2 * Math.pow(ySpread, 2);
				var t:Float = nx / dx + ny / dy;
				var u:Float = Math.exp( -1 * t );
				z = amp * Math.exp( -1 *
					( Math.pow(hex.x - middleHex.x, 2) / ( 2 * Math.pow(xSpread, 2) ) + Math.pow(hex.y - middleHex.y, 2) / ( 2 * Math.pow(ySpread, 2) ) ) 
				);
				/*
				 * trace(z);
				trace(nx);
				trace(dx);
				trace(ny);
				trace(dy);
				trace(t);
				trace(u);
				*/
				hex.setColor( Std.int(z) );
			}
		}
	}
}