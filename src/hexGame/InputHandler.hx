package hexGame;
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.Lib;

/**
 * Generic input handler for delegating input events to an InputTarget and maintaining state
 * @author tgorkin
 */

class InputHandler {

	/** Current position of the mouse */
	public var mousePos:Point;

	/** Previous position of the mouse*/
	public var prevMousePos:Point;
	
	/** Whether the left mouse button is down */
	public var isMouseDown:Bool;
	
	/** Last mouse event handled */
	public var mouseEvent:MouseEvent;
	
	/** Target to delegate the input events to */
	private var m_target:InputTarget;
	
	/**
	 * Constructor
	 */
	public function new() {
		mousePos = new Point();
		prevMousePos = new Point();
	}
	
	/**
	 * Initializes the input handler, binding it to and input target
	 * @param	target	input target to delegate events to
	 */
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
	
	/**
	 * Handles mouse wheel events
	 * @param	evt
	 */
	private function onMouseWheel(evt:MouseEvent) {
		mouseEvent = evt;
		m_target.onMouseWheel();
	}
	
	/**
	 * Handles mouse down events
	 * @param	evt
	 */
	private function onMouseDown(evt:MouseEvent) {
		mouseEvent = evt;
		isMouseDown = true;
		m_target.onMouseDown();
	}
	
	/**
	 * Handles mouse up events
	 * @param	evt
	 */
	private function onMouseUp(evt:MouseEvent) {
		mouseEvent = evt;
		isMouseDown = false;
		m_target.onMouseUp();
	}

	/**
	 * Handles mouse move events
	 * @param	evt
	 */
	private function onMouseMove(evt:MouseEvent) {
		mouseEvent = evt;
		prevMousePos.x = mousePos.x;
		prevMousePos.y = mousePos.y;
		mousePos.x = evt.stageX;
		mousePos.y = evt.stageY;
		m_target.onMouseMove();
	}
	
	/**
	 * Handles mouse over events
	 * @param	evt
	 */
	private function onMouseOver(evt:MouseEvent) {
		mouseEvent = evt;
	}
	
	/**
	 * Handles mouse out events
	 * @param	evt
	 */
	private function onMouseOut(evt:MouseEvent) {
		mouseEvent = evt;
		isMouseDown = false;
	}
	
	/**
	 * Get delta in x direction the mouse moved between events
	 * @return	x delta of the mouse in screen space
	 */
	public function getXDelta():Float {
		return mousePos.x - prevMousePos.x;
	}
	
	/**
	 * Get delta in y direction the mouse moved between events
	 * @return	y delta of the mouse in screen space
	 */
	public function getYDelta():Float {
		return mousePos.y - prevMousePos.y;
	}
}