# Canvas

A background canvas that detects click events.

* *getCoordinates()* - Convert event location to coordinates in the SVG document.
* *moveNodeTo()* - Move an SVG element to the given coordinates.

## Issues 

1. The document displayed in the browser might be SVG (MIME type image/svg+xml) or HTML (MIME type text/html) with embedded SVG.
Differences in behaviour between these two cases needs working through.

1. You can play around with _viewPort_,  _viewBox_ and _preserveAspectRatio_.
How these affect behaviour of the canvas widget needs working through.

1. The relationship between browser zooming and scrolling, and SVG view zooming and panning, is not well understood.
If you set width or height of containing HTML element to a percentage, it remains the same percentage of the zoomed HTML page. The effect is that the SVG doesn't appear to zoom. 
What behaviour do you want? There might be differing requirements on how an embedded SVG element behaves in the context of a larger HTML document.

1. Manipulating SVG transforms. The method used is to get the **baseVal** *SVGTransformList*, consolidate it to give one *SVGTransform* item, then modify the **e** and **f** elements of the *SVGMatrix* for this item. This assumes other code isn't depending on this being a list of separate transforms.


## References 

1. How [preserveAspectRatio](https://www.digitalocean.com/community/tutorials/svg-preserve-aspect-ratio) works.
1. [SVG Trasformation Matrix](https://docs.aspose.com/svg/net/drawing-basics/transformation-matrix/)

## See Also
1. [Animation](https://jenkov.com/tutorials/svg/svg-animation.html)
1. [Tutorials](https://www.petercollingridge.co.uk/tutorials/svg/)