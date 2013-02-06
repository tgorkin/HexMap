package hexGame;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Stage;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.Lib;

/**
 * ...
 * @author tgorkin
 */

class HexMap extends MovieClip, implements InputTarget {

	public static var HEX_EDGE_LENGTH:UInt = 30;
	
	private var m_isMouseDown:Bool;
	
	private var m_inputHandler:InputHandler;
	
	public var cells:Array<Array<Hex>>;
	
	public var xLength:Int;
	
	public var yLength:Int;
	
	public function new() {
		super();
		m_isMouseDown = false;
	}
	
	public function init(xCount:Int, yCount:Int) {
		//var xHexCount:Int = Std.int(stage.stageWidth / ( 3 * HEX_EDGE_LENGTH ) ) + 1;
		//var yHexCount:Int = Std.int(stage.stageHeight / ( HEX_EDGE_LENGTH * Hex.SIN_60 ) ) + 1;
		
		xLength = xCount;
		yLength = yCount;
		
		cells = new Array<Array<Hex>>();
		for ( i in 0...xCount) cells[i] = new Array<Hex>();
		
		var hex:Hex;
		var xPos:Float = 0, yPos:Float = 0;
		for ( yIdx in 0...yCount) {
			xPos = 0;
			if ( yIdx % 2 == 1 ) {
				xPos += HEX_EDGE_LENGTH * 1.5;
			}
			for ( xIdx in 0...xCount) {
				hex = new Hex(HEX_EDGE_LENGTH, 0xFFFFFF, xIdx, yIdx);
				hex.x = xPos;
				hex.y = yPos;
				addChild( hex );
				cells[xIdx][yIdx] = hex;
				xPos += HEX_EDGE_LENGTH * 3;
			}
			yPos += HEX_EDGE_LENGTH * Hex.SIN_60;
		}
		
		m_inputHandler = new InputHandler();
		m_inputHandler.init(this);
	}
	
	public function onMouseDown() {
	}
	
	public function onMouseUp() {
	}
	
	public function onMouseMove() {
		if ( m_inputHandler.isMouseDown ) {
			this.x += m_inputHandler.getXDelta();
			this.y += m_inputHandler.getYDelta();
		}
	}
	
	public function onMouseWheel() {
		var transformMat:Matrix = this.transform.matrix;
		var newScale:Float = 1 + m_inputHandler.mouseEvent.delta * 0.03;
		var mousePos:Point = m_inputHandler.mousePos;
		
		transformMat.tx -= mousePos.x;
		transformMat.ty -= mousePos.y;
		transformMat.scale( newScale, newScale);
		transformMat.tx += mousePos.x;
		transformMat.ty += mousePos.y;
		
		this.transform.matrix = transformMat;
	}
}