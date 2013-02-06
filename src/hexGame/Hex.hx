package hexGame;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.text.TextField;

/**
 * Individual hexagon in the hex map
 * @author tgorkin
 */

class Hex extends MovieClip {
	
	/** Constant for sine of a 60 degree angle */
	public static var SIN_60:Float = Math.sqrt(3) / 2;
	
	/** Edge length of the hexagon */
	private var m_edgeLength:UInt;
	
	/** Current fill color of the hexagon */
	private var m_fillColor:UInt;
	
	/** X index of this hexagon in the map */
	private var m_xIndex:UInt;
	
	/** Y index of this hexagon in the map */
	private var m_yIndex:UInt;

	/**
	 * Constructor
	 * @param	edgeLength	edge length to size the hexagon
	 * @param	fillColor	initial fill color for the hexagon
	 * @param	xIndex		x index of this hexagon in the map
	 * @param	yIndex		y index of this hexagon in the map
	 */
	public function new(edgeLength:UInt, fillColor:UInt=0xFFFFFF, xIndex:UInt, yIndex:UInt) {
		super();
		m_edgeLength = edgeLength;
		m_fillColor = fillColor;
		m_xIndex = xIndex;
		m_yIndex = yIndex;
		drawHex();
		drawIndices();
		
		// attach mouse event listeners
		this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
	}
	
	/**
	 * Draws the hexagon edges and fill using flash graphics commands
	 */
	private function drawHex() {
		graphics.clear();
		
		graphics.lineStyle(2, 0x000000, 0.7 );
		graphics.beginFill(m_fillColor);
		
		graphics.moveTo( -m_edgeLength, 0 );
		graphics.lineTo( -m_edgeLength / 2, SIN_60 * m_edgeLength );
		graphics.lineTo( m_edgeLength / 2, SIN_60 * m_edgeLength );
		graphics.lineTo( m_edgeLength, 0 );
		graphics.lineTo( m_edgeLength / 2, -SIN_60 * m_edgeLength );
		graphics.lineTo( -m_edgeLength / 2, -SIN_60 * m_edgeLength );
		graphics.lineTo( -m_edgeLength, 0 );
		
		graphics.endFill();
	}
	
	/**
	 * Adds a text field to display the x/y indicies on the hex map
	 */
	private function drawIndices() {
		var tf:TextField = new TextField();
		tf.text = m_xIndex + "," + m_yIndex;
		addChild(tf);
	}
	
	/**
	 * Method to draw a closed shape from arbitrary array of points
	 * Deprecated
	 * @param	points	array of points to draw
	 */
	private function drawPoints(points:Array<Point>) {
		var p:Point = points[0];
		graphics.moveTo(p.x, p.y);
		var pIndex:Int = 1;
		while ( pIndex < points.length) {
			p = points[pIndex];
			graphics.lineTo(p.x, p.y);
			pIndex++;
		}
		p = points[0];
		graphics.lineTo(p.x, p.y);
	}
	
	/**
	 * Handle mouse over events
	 * @param	evt	
	 */
	private function onMouseOver(evt:MouseEvent) {
		this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 100, 100, 100, 0);
	}
	
	/**
	 * Handle mouse out events
	 * @param	evt
	 */
	private function onMouseOut(evt:MouseEvent) {
		this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
	}
	
	/**
	 * Sets the fill color of the hexagon, clears and redraws the hexagon shape
	 * @param	color	new fill color
	 */
	public function setColor(color:UInt) {
		m_fillColor = color;
		drawHex();
	}
}