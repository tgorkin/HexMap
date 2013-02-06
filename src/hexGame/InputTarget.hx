package hexGame;

/**
 * ...
 * @author tgorkin
 */

interface InputTarget {

	public function onMouseDown():Void;
	
	public function onMouseUp():Void;
	
	public function onMouseMove():Void;
	
	public function onMouseWheel():Void;
	
}