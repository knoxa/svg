
function Canvas(evt) {

  this.viewbox = new ViewBox(evt.target);

  this.getCoordinates = function(evt) {	  
	return getCoordinates(evt, this.viewbox);
  };
  
  this.resize = function(viewbox) {
    viewbox.resize();
  };

  window.addEventListener("resize", this.resize(this.viewbox));
  
  return this;
}


function getCoordinates(evt, viewbox) {

  var bounds = viewbox.svg.getBoundingClientRect();
  
  var x = evt.offsetX / bounds.width * viewbox.width + viewbox.x;
  var y = evt.offsetY / bounds.height * viewbox.height + viewbox.y;

  return new Point(Math.round(x*1000)/1000, Math.round(y*1000)/1000);
}


function ViewBox(svgdoc) {
	
  this.svg = svgdoc;
  
  var v = svgdoc.getAttribute('viewBox');
  var list = v.split(' ');

  this.doc = svgdoc;
  this.x = parseInt(list[0]);
  this.y = parseInt(list[1]);
  this.width  = parseInt(list[2]);
  this.height = parseInt(list[3]);
  this.stretchX = 1.0;
  this.stretchY = 1.0;
  
  this.zoom = _getZoom(svgdoc) 
  
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
  
  viewbox.zoom =_getZoom(viewbox.doc);
}

function _getZoom(svgdoc) {
	
	  if ( svgdoc.parentElement == null )  return window.devicePixelRatio;
	  else return 1.0;
}


function moveElementTo(node, point) {

	// Get the list of transforms. Consolidate it so the list is of length 1.
	// Modify the Z,Y positions of the resulting transform.
	var list = node.transform.baseVal;
	list.consolidate();
	list[0].matrix.e = point.x; list[0].matrix.f = point.y;
}

function Point(x,y) {
	
  this.x = x;
  this.y = y;
  return this;
}
