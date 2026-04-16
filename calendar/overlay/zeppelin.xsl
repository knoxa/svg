<?xml version="1.0"?>
<xsl:stylesheet xmlns="http://www.w3.org/2000/svg" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="../xsl/yearplanner.xsl"/>

<xsl:variable name="data" select="document('zepp.xml')"/>

<xsl:template match="/">
	<xsl:message><xsl:value-of select="count($data//item)"/></xsl:message>
	<xsl:apply-imports/>
</xsl:template>

<xsl:template match="day" mode="overlay">
	<xsl:apply-templates select="$data//item[./@date = current()/@id]"/>
</xsl:template>


<xsl:template match="item">
	<xsl:message><xsl:value-of select="text"/></xsl:message>
  <a href="{concat('https://tigersmuseum.github.io/history/events/ww1/rowe.xhtml#', @id)}"><circle cx="4.5" cy="9.5" r="1.5" style="fill:red; stroke:none"/></a>
</xsl:template>

</xsl:stylesheet>
