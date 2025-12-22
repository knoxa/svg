<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:data="data" xmlns:xlink="http://www.w3.org/1999/xlink"
								version="1.0">

<xsl:import href="month.xsl"/>
<xsl:output method="xml" version="1.0" media-type="image/svg+xml" indent="yes"/>


<xsl:template match="/">
<svg viewBox="0 0 400 300" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
<style xmlns="http://www.w3.org/2000/svg" type="text/css">
    .background {fill:darkgrey; stroke:none}
    .weekday {fill:white; stroke:none}
    .weekend {fill:lightgrey; stroke:none}
</style>
<script>
<![CDATA[

var okToDayZoom = false;

function zoomMonth(node, viewbox) {

   //alert(viewbox);
   var current = node.getAttribute("viewBox");
   if (current == viewbox) {
      node.setAttribute("viewBox", '0 0 400 300');
      okToDayZoom = false;
   }
   else {
      node.setAttribute("viewBox", viewbox);
      okToDayZoom = true;
   }
 }

function zoomDay(evt, viewbox) {

  if (okToDayZoom) {
  
     var node = evt.target;
  
     while ( node.nodeName != 'svg' && node != document.documentElement ) {
	   node = node.parentNode;
     }

      var current = node.getAttribute("viewBox");
      if (current == viewbox)  node.setAttribute("viewBox", '0 0 71 78');
      else                     node.setAttribute("viewBox", viewbox);
  }
  
  evt.stopPropagation(); evt.preventDefault();
}

]]>
</script>
  <xsl:apply-templates/>
</svg>
</xsl:template>


<xsl:template match="year">
  <xsl:apply-templates select="month"/>
</xsl:template>


<xsl:template match="month">
 <xsl:variable name="x" select="(@monthOfYear mod 4)*100"/>
 <xsl:variable name="y" select="floor(@monthOfYear div 4)*100"/>
 <xsl:variable name="viewbox" select="concat($x, ' ', $y, ' 100 100')"/>
 <svg x="{$x}" y="{$y}" width="100" height="100" xmlns="http://www.w3.org/2000/svg" onclick="zoomMonth(document.documentElement, '{$viewbox}')">
   <xsl:apply-imports/>
   <rect x="0" y="0" width="100" height="100" style="stroke:white; fill:none"/>
 </svg>
</xsl:template>


</xsl:stylesheet>
