package;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import hexGame.HexMap;
import hexGame.Stats;
import hexGame.MapGenerator;

/**
 * Main entry point for application
 * @author tgorkin
 */

class Main {
	
	/**
	 * static method that executes when the application starts
	 */
	static function main() {
		var stage:Stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		
		var map = new HexMap();
		map.init(30, 60);
		stage.addChild(map);
		
		MapGenerator.generateGuassian(map);
		
		stage.addChild( new Stats() );
	}
}