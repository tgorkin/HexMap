package ;


/**
 * ...
 * @author tgorkin
 */

class Main {
	
	static var map:HexMap;
	
	static function main() {
		map = new HexMap();
		map.init();
		map.start();
	}
}