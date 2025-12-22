<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns="http://www.w3.org/2000/svg"
                xmlns:data="data" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.0">

<xsl:output method="xml" version="1.0" media-type="image/svg+xml" indent="no"/>

<xsl:variable name="monthNames" select="document('')//data:month"/>


<xsl:template match="/">
<!--
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 257.5" preserveAspectRatio="none" onload="showToday()">
-->
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 257.5" preserveAspectRatio="none">
  <style type="text/css">
    .background {fill:grey; stroke:none}
    .weekday {fill:bisque; stroke:none}
    .weekend {fill:sandybrown; stroke:none}
  </style>
  <defs>
    <circle id="leave" class="weekend" r="3" cy="9.5" cx="4.5"/>
    <polygon id="event" points="4.5,5  2,9.5 4.5,14 7,9.5" />
    <polygon id="event1" points="2,7  7,7 7,12 2,12" style="fill:black"/>
    <g id="shield" transform="scale(0.05,0.05)">
      <path d="M0,35 Q 35,25 35,-35 h-70 Q -35,25 0,35 z"/>
    </g>
  </defs>
  <!-- <script language="javascript" xlink:href="calendar.js" /> -->
  <rect width="384" height="257.5" class="background"/>
  <xsl:apply-templates/>
  <xsl:apply-templates select="//g"/>
</svg>
</xsl:template>


<xsl:template match="year">
  <g transform="translate(1,10)">
    <xsl:call-template name="rowLabels"/>
  </g>
  <g transform="translate(378.5,10)">
    <xsl:call-template name="rowLabels"/>
  </g>
  <g transform="translate(6.5,1)">
    <xsl:call-template name="columnLabels"/>
    <g transform="translate(0,7)" onclick="hiliteDay(evt.getTarget().getParentNode())">
      <xsl:apply-templates select="month"/>
    </g>
    <g transform="translate(0,250)">
      <xsl:call-template name="columnLabels"/>
    </g>
  </g>
</xsl:template>


<xsl:template match="month">
    <xsl:apply-templates select="day"/>
</xsl:template>


<xsl:template match="day">
<xsl:variable name="class">
  <xsl:choose>
    <xsl:when test="@dayOfWeek=0 or @dayOfWeek=6">weekend</xsl:when>
    <xsl:when test="PH">weekend</xsl:when>
    <xsl:otherwise>weekday</xsl:otherwise>
  </xsl:choose>
</xsl:variable>
<g id="{@id}" transform="translate({(@dayOfWeek+(@weekOfMonth*7))*10+1},{../@monthOfYear*20+2})" class="{$class}">
  <rect width="9" height="19" />
  <xsl:apply-templates select="." mode="overlay"/>
  <text x="8.5" y="2" style="font-size:2px; fill:black; stroke:none; text-anchor:end"><xsl:value-of select="position()"/></text>
</g>
</xsl:template>


<xsl:template match="g">
<g transform="translate({(../@dayOfWeek+(../@weekOfMonth*7))*10+1+6.5+1.5},{../../@monthOfYear*20+2})">
  <xsl:copy-of select="."/>
</g>
</xsl:template>


<xsl:template name="rowLabels">
  <g class="weekday">
    <g transform="translate(0,0)">
      <rect width="4.5" height="19" />
      <text y="7" style="font-size:3px; fill:black; text-anchor:middle"><tspan x="2">J</tspan><tspan dy="3" x="2">A</tspan><tspan dy="3" x="2">N</tspan></text>
    </g>
    <g transform="translate(0,20)">
      <rect width="4.5" height="19" />
      <text x="2" y="7" style="font-size:3px; fill:black; text-anchor:middle">F<tspan dy="3" x="2">E</tspan><tspan dy="3" x="2">B</tspan></text>
    </g>
    <g transform="translate(0,40)">
      <rect width="4.5" height="19" />
      <text x="2" y="7" style="font-size:3px; fill:black; text-anchor:middle">M<tspan dy="3" x="2">A</tspan><tspan dy="3" x="2">R</tspan></text>
    </g>
    <g transform="translate(0,60)">
      <rect width="4.5" height="19" />
      <text x="2" y="7" style="font-size:3px; fill:black; text-anchor:middle">A<tspan dy="3" x="2">P</tspan><tspan dy="3" x="2">R</tspan></text>
    </g>
    <g transform="translate(0,80)">
      <rect width="4.5" height="19" />
      <text x="2" y="7" style="font-size:3px; fill:black; text-anchor:middle">M<tspan dy="3" x="2">A</tspan><tspan dy="3" x="2">Y</tspan></text>
    </g>
    <g transform="translate(0,100)">
      <rect width="4.5" height="19" />
      <text x="2" y="7" style="font-size:3px; fill:black; text-anchor:middle">J<tspan dy="3" x="2">U</tspan><tspan dy="3" x="2">N</tspan></text>
    </g>
    <g transform="translate(0,120)">
      <rect width="4.5" height="19" />
      <text x="2" y="7" style="font-size:3px; fill:black; text-anchor:middle">J<tspan dy="3" x="2">U</tspan><tspan dy="3" x="2">L</tspan></text>
    </g>
    <g transform="translate(0,140)">
      <rect width="4.5" height="19" />
      <text x="2" y="7" style="font-size:3px; fill:black; text-anchor:middle">A<tspan dy="3" x="2">U</tspan><tspan dy="3" x="2">G</tspan></text>
    </g>
    <g transform="translate(0,160)">
      <rect width="4.5" height="19" />
      <text x="2" y="7" style="font-size:3px; fill:black; text-anchor:middle">S<tspan dy="3" x="2">E</tspan><tspan dy="3" x="2">P</tspan></text>
    </g>
    <g transform="translate(0,180)">
      <rect width="4.5" height="19" />
      <text x="2" y="7" style="font-size:3px; fill:black; text-anchor:middle">O<tspan dy="3" x="2">C</tspan><tspan dy="3" x="2">T</tspan></text>
    </g>
    <g transform="translate(0,200)">
      <rect width="4.5" height="19" />
      <text x="2" y="7" style="font-size:3px; fill:black; text-anchor:middle">N<tspan dy="3" x="2">O</tspan><tspan dy="3" x="2">V</tspan></text>
    </g>
    <g transform="translate(0,220)">
      <rect width="4.5" height="19" />
      <text x="2" y="7" style="font-size:3px; fill:black; text-anchor:middle">D<tspan dy="3" x="2">E</tspan><tspan dy="3" x="2">C</tspan></text>
    </g>
  </g>
</xsl:template>


<xsl:template name="columnLabels">
  <xsl:call-template name="weekLabels"/>
  <g transform="translate(70,0)">
    <xsl:call-template name="weekLabels"/>
  </g>
  <g transform="translate(140,0)">
    <xsl:call-template name="weekLabels"/>
  </g>
  <g transform="translate(210,0)">
    <xsl:call-template name="weekLabels"/>
  </g>
  <g transform="translate(280,0)">
    <xsl:call-template name="weekLabels"/>
  </g>
  <g transform="translate(351,1)" class="weekend">
    <rect width="9" height="4.5" />
    <text x="4.5" y="3" style="font-size:3px; fill:black; text-anchor:middle">Sun</text>
  </g>
  <g transform="translate(361,1)" class="weekday">
    <rect width="9" height="4.5" />
    <text x="4.5" y="3" style="font-size:3px; fill:black; text-anchor:middle">Mon</text>
  </g>
</xsl:template>


<xsl:template name="weekLabels">
  <g class="weekday">
    <g transform="translate(1,1)" class="weekend">
      <rect width="9" height="4.5" />
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
</xsl:template>


</xsl:stylesheet>
