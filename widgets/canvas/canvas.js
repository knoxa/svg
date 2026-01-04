
function Canvas(evt) {

  this.viewbox = new ViewBox(evt.target);

  this.getViewBox = new Function ( "return this.viewbox" );
  
  this.getCoordinates = function(evt) {	  
	return getCoordinates(evt, this.viewbox);
  };
  
  this.resize = function(viewbox) {
    viewbox.resize();
  };

  window.addEventListener("resize", this.resize(this.viewbox));
}


function getCoordinates(evt, viewbox) {

  var doc = evt.target.ownerDocument.documentElement;

  var bounds = viewbox.svg.getBoundingClientRect();
  var left = evt.target.ownerDocument.scrollingElement.scrollLeft + bounds.left;
  var top  = evt.target.ownerDocument.scrollingElement.scrollTop  - bounds.top;

  var x = evt.offsetX / bounds.width * viewbox.width;
  var y = evt.offsetY / bounds.height * viewbox.height;

  return new Point(Math.round(x*1000)/1000, Math.round(y*1000)/1000);
}


function ViewBox(svgdoc) {
	
  ratio = svgdoc.preserveAspectRatio;

  if ( ratio.baseVal.meetOrSlice == SVGPreserveAspectRatio.SVG_PRESERVEASPECTRATIO_NONE ) {
	  
	  console.log('preserveAspectRatio: none');
  }
  
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

	var transform = getSvgTransform(node);
	
	if (transform) {
		
		transform.xTranslate = point.x; transform.yTranslate = point.y;
		node.setAttribute('transform', transform.getSvgTransformString());
	}
	else {
		
		var t = 'translate(' + point.x +',' + point.y + ')';
		node.setAttribute('transform', t);
	}
}

//////

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


function Transform() {

	this.xTranslate = 0; this.yTranslate = 0;
	this.xScale = 1; this.yScale = 1;
	this.xSkew = 0; this.ySkew = 0;
	this.rotate = 0;
	
	this.getSvgTransformString = new Function ( "return _getSvgTransformString(this)" );
	
	return this;
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

//////////////////////

function Point(x,y) {
	
  this.x = x;
  this.y = y;
  return this;
}
