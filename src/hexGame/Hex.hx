package hexGame;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.text.TextField;

/**
 * ...
 * @author tgorkin
 */

class Hex extends MovieClip {
	
	public static var SIN_60:Float = Math.sqrt(3) / 2;
	
	private var m_edgeLength:UInt;
	
	private var m_fillColor:UInt;
	
	private var m_xIndex:UInt;
	
	private var m_yIndex:UInt;

	public function new(edgeLength:UInt, fillColor:UInt=0xFFFFFF, xIndex:UInt, yIndex:UInt) {
		super();
		m_edgeLength = edgeLength;
		m_fillColor = fillColor;
		m_xIndex = xIndex;
		m_yIndex = yIndex;
		drawEdges();
		drawIndices();
		
		this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
	}
	
	private function drawEdges() {
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
	
	private function drawIndices() {
		var tf:TextField = new TextField();
		tf.text = m_xIndex + "," + m_yIndex;
		addChild(tf);
	}
	
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
	
	private function onMouseOver(evt:MouseEvent) {
		this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 100, 100, 100, 0);
	}
	
	private function onMouseOut(evt:MouseEvent) {
		this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
	}
	
	public function setColor(color:UInt) {
		m_fillColor = color;
		drawEdges();
	}
}