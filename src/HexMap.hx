package;
import flash.display.MovieClip;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.MouseEvent;
import flash.Lib;

/**
 * ...
 * @author tgorkin
 */

class HexMap {

	private static var HEX_EDGE_LENGTH:UInt = 30;
	
	public var stage:Stage;
	
	private var m_map:MovieClip;
	
	private var m_isMouseDown:Bool;
	
	public function new() {
		m_map = new MovieClip();
		m_isMouseDown = false;
	}
	
	public function init() {
		stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		stage.addChild(m_map);
		
		m_map.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		m_map.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		m_map.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		m_map.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	
	public function start() {
		var xHexCount:Int = Std.int(stage.stageWidth / ( 3 * HEX_EDGE_LENGTH ) ) + 1;
		var yHexCount:Int = Std.int(stage.stageHeight / ( HEX_EDGE_LENGTH * Hex.SIN_60 ) ) + 1;
		var hex:Hex;
		var xPos:Float = 0, yPos:Float = 0;
		for ( yCount in 0...yHexCount) {
			xPos = 0;
			if ( yCount % 2 == 1 ) {
				xPos += HEX_EDGE_LENGTH * 1.5;
			}
			for ( xCount in 0...xHexCount) {
				hex = new Hex(HEX_EDGE_LENGTH, 0xFFFFFF);
				hex.x = xPos;
				hex.y = yPos;
				m_map.addChild( hex );
				xPos += HEX_EDGE_LENGTH * 3;
			}
			yPos += HEX_EDGE_LENGTH * Hex.SIN_60;
		}
	}
	
	private function onMouseWheel(evt:MouseEvent) {
		m_map.scaleX = m_map.scaleX + evt.delta *0.001;
		m_map.scaleY = m_map.scaleY + evt.delta *0.001;
	}
	
	private function onMouseDown(evt:MouseEvent) {
		m_isMouseDown = true;
	}
	
	private function onMouseUp(evt:MouseEvent) {
		m_isMouseDown = false;
	}
	
	private function onMouseMove(evt:MouseEvent) {
		if ( m_isMouseDown ) {
			m_map.x += evt.localX;
			m_map.y = evt.localY;
		}
	}
}