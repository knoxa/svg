
_Canvas_viewbox = new ViewBox();

function Canvas() {

  this.icon    = document.getElementById("icon");
  this.resize     = new Function ( "_Canvas_viewbox.resize()" );
  this.getViewBox = new Function ( "return _Canvas_viewbox" );
  this.click      = new Function ( "evt", "placeIconAt(this.icon, getCoordinates(evt))" );
}


function placeIconAt(icon, point) {

  var node = icon.cloneNode(true);
  var t = 'translate(' + point.x +',' + point.y + ')';
  node.setAttribute('transform', t);
  
  // add it to the picture
  document.documentElement.appendChild(node);
  
  return node;
}


function getCoordinates(evt) {

  var doc = evt.target.ownerDocument.documentElement;
  var viewbox = _Canvas_viewbox;
  
  /*
    Translate the X,Y position of a mouse click to X,Y co-ordinates on the picture:
    - Get the X,Y position within the SVG viewer client window.
    - Subtract the current translation of the viewport (to allow for panning)
    - Divide by the scale factor (to allow for zooming)
    - [if necessary] allow for any stretching caused by using preserveAspectRatio="none" without
       specifying a viewport width. In this case, the SVG picture will stretch in the X and Y directions
       to fill the SVGViewer window. Need to divide viewBox width (see viewBox attribute) by the width of 
       the Viewer window and ViewBox height by the height of the Viewer window.
    - Add in any x,y offset for the top left corner of the viewBox
  */

  var x = viewbox.x + (evt.clientX - doc.currentTranslate.x)/doc.currentScale * viewbox.stretchX;
  var y = viewbox.y + (evt.clientY - doc.currentTranslate.y)/doc.currentScale * viewbox.stretchY;
  return new Point(Math.round(x*100)/100, Math.round(y*100)/100);

}


function ViewBox() {
  var v = document.documentElement.getAttribute('viewBox');
  var list = v.split(' ');

  this.x = parseInt(list[0]);
  this.y = parseInt(list[1]);
  this.width  = parseInt(list[2]);
  this.height = parseInt(list[3]);
  this.stretchX = 1.0;
  this.stretchY = 1.0;
  
  this.resize = new Function ( "_ViewBox_resize (this)" );
  this.resize();

  return this;
}


function _ViewBox_resize(viewbox) {


  var w = document.documentElement.getAttribute('width');
  
  if (w != viewbox.width) {
	  
    viewbox.stretchX = viewbox.width/innerWidth;
    viewbox.stretchY = viewbox.height/innerHeight;
  }
}

function moveNodeTo(node, point) {

	var transform = getSvgTransform(node);
	
	if (transform) {
		
		transform.xTranslate = point.x; transform.yTranslate = point.y;
		drag.target.setAttribute('transform', transform.getSvgTransformString());
	}
	else {
		
		var t = 'translate(' + point.x +',' + point.y + ')';
		node.setAttribute('transform', t);
	}
}


//////////////////////

function Point(x,y) {
	
  this.x = x;
  this.y = y;
  return this;
}


////////////

function Transform() {

	this.xTranslate = 0; this.yTranslate = 0;
	this.xScale = 1; this.yScale = 1;
	this.xSkew = 0; this.ySkew = 0;
	this.rotate = 0;
	
	this.getSvgTransformString = new Function ( "return _getSvgTransformString(this)" );
	
	return this;
}


function getSvgTransform(target) {

	const regexTranslate = /translate\((.+?)\)/;
	const regexRotate = /rotate\((.+?)\)/;
	const regexScale = /scale\((.+?)\)/;
	
	var transform = new Transform();
	
	var tfm = target.getAttribute('transform');
	
	if (tfm) {
	
		const matchTranslate = tfm.match(regexTranslate);
		const matchRotate = tfm.match(regexRotate);
		const matchScale = tfm.match(regexScale);
	
		if (matchTranslate) {
			var t = matchTranslate[1].split(",");
			transform.xTranslate = t[0]; transform.yTranslate = t[1];
		}
	
		if (matchRotate) {
			transform.rotate = matchRotate[1];
		}
		
			
		if (matchScale) {
			var s = matchScale[1].split(",");
			transform.xScale = s[0]; transform.yScale = s[1];
		}	
	}
	
	return transform;
}


function _getSvgTransformString(transform) {
	
	// construct a string for the SVG transform attribute.
	
	var result = '';

	result = result + 'translate(' + transform.xTranslate + ',' + transform.yTranslate + ')';

	if ( transform.xScale != 1 ||  transform.yScale != 1 ) {
		result = result + ' scale(' + transform.xScale + ',' + transform.yScale + ')';
	}

	if ( transform.rotate != 0 ) {
		result = result + ' rotate(' + transform.rotate + ')';	
	}

	return result;
}
