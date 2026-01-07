
function _Drag_down (evt) {

  drag.dragging = true;
  if (!drag.target)  drag.target = evt.target.parentNode;
  
  var xy = getPosition(drag.target);

  //alert("("+xy.x + "," + xy.y + ")");
  //alert("("+drag.target.getCTM().e+ "," + drag.target.getCTM().f + ")");
  
  var p = _Canvas_viewbox.getCoordinates(evt);
  //drag.offset.x = drag.target.getCTM().e - p.x;
  //drag.offset.y = drag.target.getCTM().f - p.y;
  drag.offset.x = xy.x - p.x;
  drag.offset.y = xy.y - p.y;

  var style = drag.target.style;
  style.setProperty('pointer-events', 'none');

  drag.downCallback(drag.target);
}


function _Drag_move (evt) {

  if (drag.dragging) { 
    var p = _Canvas_viewbox.getCoordinates(evt);

    //var newX = p.x + drag.offset.x;
    //var newY = p.y + drag.offset.y;
    var newX = p.x;
    var newY = p.y;
    
    var newp =  new Point(newX, newY);

    moveElementTo(drag.target, newp);
//	var transform = getSvgTransform(drag.target);
//	transform.xTranslate = newX; transform.yTranslate = newY;
//	drag.target.setAttribute('transform', transform.getSvgTransformString());
    drag.moveCallback(drag.target, newX, newY);
  }
}


function _Drag_up(evt) {

  if (drag.dragging) {
    var style = drag.target.style;
    style.setProperty('pointer-events', 'all');
    
    drag.upCallback(evt);
    drag.dropCallback(drag.target, evt.target);

    drag.dragging = false;
    drag.target = null;
  }
}


function Drag() {

  // initialize
  
  var MARKER_NS = 'http://knoxa.github.io/svg/marker';
  var nodelist, i, node;
  
  nodelist = document.getElementsByTagNameNS(MARKER_NS, 'drag.background');
  
  for (i = 0; i < nodelist.length; i++) {
  
    node = nodelist.item(i).parentNode;
    node.addEventListener("mousemove", _Drag_move, false);
	node.addEventListener("mouseup",   _Drag_up,   false);    
  }
  
  nodelist = document.getElementsByTagNameNS(MARKER_NS, 'drag.draggable');
  
  for (i = 0; i < nodelist.length; i++) {
  
    node = nodelist.item(i).parentNode;
    node.addEventListener("mousedown", _Drag_down, false);
    node.addEventListener("mousemove", _Drag_move, false);
    node.addEventListener("mouseup",   _Drag_up,   false);
  }
  
  this.down = _Drag_down;
  this.move = _Drag_move;
  this.up   = _Drag_up;
  
  this.target   = null;
  this.dragging = false;
  this.offset   = new Point(0,0);
  this.upCallback   = new Function(""); // can be overridden
  this.downCallback = new Function(""); // can be overridden
  this.moveCallback = new Function(""); // can be overridden
  this.dropCallback = new Function(""); // can be overridden
}


//////////////////////

function Point(x,y) {
this.x = x;
this.y = y;
return this;
}


function getPosition(node) {

  var list = node.transform.baseVal;
  list.consolidate();
  var position = new Point(0.0, 0.0);

  if ( list.length = 1 ) {
	
	var transform = list[0].matrix;
	position.x = transform.e; position.y = transform.f;
  }

  return position;
}
