package hexGame;
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.Lib;

/**
 * ...
 * @author tgorkin
 */

class InputHandler {

	public var mousePos:Point;

	public var prevMousePos:Point;
	
	public var isMouseDown:Bool;
	
	public var mouseEvent:MouseEvent;
	
	private var m_target:InputTarget;
	
	public function new() {
		mousePos = new Point();
		prevMousePos = new Point();
	}
	
	public function init(target:InputTarget) {
		m_target = target;
		var displayObject:DisplayObject = cast(target, DisplayObject);
		
		displayObject.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		displayObject.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		displayObject.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		displayObject.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		displayObject.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		displayObject.addEventListener(MouseEvent.RELEASE_OUTSIDE, onMouseOut);
	}
	
	private function onMouseWheel(evt:MouseEvent) {
		mouseEvent = evt;
		m_target.onMouseWheel();
	}
	
	private function onMouseDown(evt:MouseEvent) {
		mouseEvent = evt;
		isMouseDown = true;
		m_target.onMouseDown();
	}
	
	private function onMouseUp(evt:MouseEvent) {
		mouseEvent = evt;
		isMouseDown = false;
		m_target.onMouseUp();
	}
	
	private function onMouseMove(evt:MouseEvent) {
		mouseEvent = evt;
		prevMousePos.x = mousePos.x;
		prevMousePos.y = mousePos.y;
		mousePos.x = evt.stageX;
		mousePos.y = evt.stageY;
		m_target.onMouseMove();
	}
	
	private function onMouseOver(evt:MouseEvent) {
		mouseEvent = evt;
	}
	
	private function onMouseOut(evt:MouseEvent) {
		mouseEvent = evt;
		isMouseDown = false;
	}
	
	public function getXDelta():Float {
		return mousePos.x - prevMousePos.x;
	}
	
	public function getYDelta():Float {
		return mousePos.y - prevMousePos.y;
	}
}