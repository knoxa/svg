# Canvas

This widget provides a background canvas that detects click events.

* *getCoordinates()* - Convert the events location to coordinates in the SVG document.
* *moveNodeTo()* - Move an SVG element to the given coordinates.


## Issues 

1. SVG document in browser (M, and SVG document embedded in HTML.
The document displayed in the browser might be SVG (MIME type image/svg+xml) or HTML (MIME type text/html).
Differences in behaviour between these two cases needs working through.

1. There will be only one canvas for an SVG document in the browser.
There will be more than one canvas if there is more than one SVG document embedded in a HTML page.
Need to work on encapsulation for canvas widgets so that they can coexist on the same HTML page (albeit in separate SVG documents) 

1. You can play around with _viewPort_,  _viewBox_ and _preserveAspectRatio_.
How these affect behaviour of the canvas widget needs working through.

1. The relationship between browser zooming and scrolling, and SVG view zooming and panning, is not well understood.
If you set width or height of containing HTML element to a percentage, it remains the same percentage of the zoomed HTML page. The effect is that the SVG doesn't appear to zoom. 
What behaviour do you want? There might be differing requirements on how an embedded SVG element behaves in the context of a larger HTML document.


## References 

1. How [preserveAspectRatio](https://www.digitalocean.com/community/tutorials/svg-preserve-aspect-ratio) works.

