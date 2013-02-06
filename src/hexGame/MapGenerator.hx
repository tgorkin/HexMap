package hexGame;

/**
 * Static helper functions for generating terrain on a hex map
 * @author tgorkin
 */

class MapGenerator {

	/**
	 * Test method to color the center of a hexmap
	 * @param	hexMap
	 */
	static public function colorCenter(hexMap:HexMap) {
		var middleX:Int = Std.int(hexMap.xLength / 2);
		var middleY:Int = Std.int(hexMap.yLength / 2);
		
		hexMap.cells[middleX][middleY].setColor(0x00FF00);
	}
	
	/**
	 * Generates a 2D guassian distribution starting at the map center
	 * @param	hexMap
	 */
	static public function generateGuassian(hexMap:HexMap) {
		var middleX:Int = Std.int(hexMap.xLength / 2);
		var middleY:Int = Std.int(hexMap.yLength / 2);
		var middleHex:Hex = hexMap.cells[middleX][middleY];
		
		var hex:Hex;
		var z:Float;
		var amp:Float = 0xFFFFFF;
		var xSpread:Float = 100.0;
		var ySpread:Float = 100.0;
		var nx:Float, dx:Float, ny:Float, dy:Float;
		for (x in 0...hexMap.xLength) {
			for (y in 0...hexMap.yLength) {
				hex = hexMap.cells[x][y];
				nx = Math.pow(hex.x - middleHex.x, 2);
				dx = 2 * Math.pow(xSpread, 2);
				ny = Math.pow(hex.y - middleHex.y, 2);
				dy = 2 * Math.pow(ySpread, 2);
				z = amp * Math.exp( -1 * ( nx / dx + ny / dy ) );
				hex.setColor( Std.int(z) );
			}
		}
	}
}