package hexGame;
import flash.display.MovieClip;
import flash.geom.Matrix;
import flash.geom.Point;

/**
 * Map of regular hexagons, display object with hexagons as children
 * @author tgorkin
 */

class HexMap extends MovieClip, implements InputTarget {

	/** Constant for the length of hexagon edges */
	public static var HEX_EDGE_LENGTH:UInt = 30;

	/** Input handler for mouse events */
	private var m_inputHandler:InputHandler;
	
	/** 2D array data structure containing the map cells organized according to their spatial relationship */
	public var cells:Array<Array<Hex>>;
	
	/** Number of hexagons in x direction */
	public var xLength:Int;
	
	/** Number of hexagons in y direction */
	public var yLength:Int;
	
	/**
	 * Constructor
	 */
	public function new() {
		super();
	}
	
	/**
	 * Initialization method, creates the hexagons display objects and adds them as children
	 * @param	xCount	num of hexagons in the x direction
	 * @param	yCount	num of hexagons in the y direction
	 */
	public function init(xCount:Int, yCount:Int) {
		// Deprecated code used to determine x/y count using stage dimensions
		// var xHexCount:Int = Std.int(stage.stageWidth / ( 3 * HEX_EDGE_LENGTH ) ) + 1;
		// var yHexCount:Int = Std.int(stage.stageHeight / ( HEX_EDGE_LENGTH * Hex.SIN_60 ) ) + 1;
		
		xLength = xCount;
		yLength = yCount;
		
		// create data structure for hexagons
		cells = new Array<Array<Hex>>();
		for ( i in 0...xCount) cells[i] = new Array<Hex>();
		
		// create and position hexagons
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
		
		// setup input handler
		m_inputHandler = new InputHandler();
		m_inputHandler.init(this);
	}
	
	/**
	 * Handle mouse down events
	 */
	public function onMouseDown() {
	}
	
	/**
	 * Handle mouse up events
	 */
	public function onMouseUp() {
	}
	
	/**
	 * Handle mouse move events
	 */
	public function onMouseMove() {
		// drag to pan the map if the mouse is down
		if ( m_inputHandler.isMouseDown ) {
			this.x += m_inputHandler.getXDelta();
			this.y += m_inputHandler.getYDelta();
		}
	}
	
	/**
	 * Handle mouse wheel events
	 */
	public function onMouseWheel() {
		// construct a transform to scale around the point of the mouse
		var transformMat:Matrix = this.transform.matrix;
		var newScale:Float = 1 + m_inputHandler.mouseEvent.delta * 0.03; // constant to scale down zoom sensitivity
		var mousePos:Point = m_inputHandler.mousePos;
		
		transformMat.tx -= mousePos.x;
		transformMat.ty -= mousePos.y;
		transformMat.scale( newScale, newScale);
		transformMat.tx += mousePos.x;
		transformMat.ty += mousePos.y;
		
		this.transform.matrix = transformMat;
	}
}