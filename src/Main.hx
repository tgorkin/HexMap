package;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import hexGame.HexMap;
import hexGame.Stats;
import hexGame.MapGenerator;

/**
 * ...
 * @author tgorkin
 */

class Main {
	
	static var map:HexMap;
	
	static function main() {
		var stage:Stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		
		map = new HexMap();
		map.init(30, 60);
		stage.addChild(map);
		
		MapGenerator.generateGuassian(map);
		
		stage.addChild( new Stats() );
	}
}