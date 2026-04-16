<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:data="data"
                xmlns:svg="http://www.w3.org/2000/svg"
								version="1.0">

<xsl:output method="xml" version="1.0" media-type="image/svg+xml" indent="yes"/>

<xsl:variable name="monthNames" select="document('')//data:month"/>


<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="month">
<svg viewBox="0 0 71 78" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
<rect width="71" height="11" style="fill:grey"/>
<g class="weekend" transform="translate(1,1)">
  <rect width="69" height="9"/>
  <xsl:variable name="month" select="number(@monthOfYear)+1"/>
  <text x="34.5" y="7" style="font-size:7px; fill:black; text-anchor:middle"><xsl:value-of select="$monthNames[$month]"/></text>
</g>
<g transform="translate(0,11)">
  <rect width="71" height="6" style="fill:grey; stroke:none"/>
  <g class="weekday">
    <g transform="translate(1,1)">
      <rect width="9" height="4.5" class="weekend"/>
      <text x="4.5" y="3" style="font-size:3px; fill:black; text-anchor:middle">Sun</text>
    </g>
    <g transform="translate(11,1)">
      <rect width="9" height="4.5" />
      <text x="4.5" y="3" style="font-size:3px; fill:black; text-anchor:middle">Mon</text>
    </g>
    <g transform="translate(21,1)">
      <rect width="9" height="4.5" />
      <text x="4.5" y="3" style="font-size:3px; fill:black; text-anchor:middle">Tue</text>
    </g>
    <g transform="translate(31,1)">
      <rect width="9" height="4.5" />
      <text x="4.5" y="3" style="font-size:3px; fill:black; text-anchor:middle">Wed</text>
    </g>
    <g transform="translate(41,1)">
      <rect width="9" height="4.5" />
      <text x="4.5" y="3" style="font-size:3px; fill:black; text-anchor:middle">Thu</text>
    </g>
    <g transform="translate(51,1)">
      <rect width="9" height="4.5" />
      <text x="4.5" y="3" style="font-size:3px; fill:black; text-anchor:middle">Fri</text>
    </g>
    <g transform="translate(61,1)">
      <rect width="9" height="4.5" class="weekend"/>
      <text x="4.5" y="3" style="font-size:3px; fill:black; text-anchor:middle">Sat</text>
    </g>
  </g>
  <g transform="translate(0,6)">
    <rect width="71" height="61" style="fill:grey"/>
    <g class="weekend">
      <xsl:apply-templates select="day"/>
    </g>
  </g>
</g>
</svg>
</xsl:template>


<xsl:template match="day">
<xsl:variable name="xmnth" select="(../@monthOfYear mod 4)*100"/>
<xsl:variable name="ymnth" select="floor(../@monthOfYear div 4)*100"/>
<xsl:variable name="dayclass">
  <xsl:choose>
    <xsl:when test="@dayOfWeek=0 or @dayOfWeek=6">weekend</xsl:when>
    <xsl:when test="PH">weekend</xsl:when>
    <xsl:otherwise>weekday</xsl:otherwise>
  </xsl:choose>
</xsl:variable>
<xsl:variable name="xday" select="@dayOfWeek*10+1"/>
<xsl:variable name="yday" select="@weekOfMonth*10+1"/>
<xsl:variable name="viewbox" select="concat($xday, ' ', $yday + 17, ' 9 9')"/>
<svg:g id="{@id}" transform="translate({$xday},{$yday})" onclick="zoomDay(evt, '{$viewbox}')">
  <svg:rect width="9" height="9" class="{$dayclass}" />
  <xsl:apply-templates select="." mode="overlay"/>
  <svg:text x="8.5" y="2" style="font-size:2px; fill:black; text-anchor:end"><xsl:value-of select="position()"/></svg:text>
</svg:g>
</xsl:template>


<data:month>January</data:month>
<data:month>February</data:month>
<data:month>March</data:month>
<data:month>April</data:month>
<data:month>May</data:month>
<data:month>June</data:month>
<data:month>July</data:month>
<data:month>August</data:month>
<data:month>September</data:month>
<data:month>October</data:month>
<data:month>November</data:month>
<data:month>December</data:month>

</xsl:stylesheet>
