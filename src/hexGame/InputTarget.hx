package hexGame;

/**
 * Interface for a class that receives input events from an input handler
 * @see hexGame.InputHandler
 * @author tgorkin
 */

interface InputTarget {

	public function onMouseDown():Void;
	
	public function onMouseUp():Void;
	
	public function onMouseMove():Void;
	
	public function onMouseWheel():Void;
	
}