# Calendar

XSL transforms to create a [calendar](examples/calendar.svg) or [year planner](examples/yearplanner.svg) from XML in the format produced by [cakes.calendar.CalendarXml](https://github.com/knoxa/cakes/tree/main/src/cakes/calendar).

The calendar output includes JavaScript that lets you zoom in and out: from year view to month view by clicking on a month name, then to day view by clicking on a day; and back again. 

## Overlays

In both cases, the templates for _day_ include the statement:

    <xsl:apply-templates select="." mode="overlay"/>

This means you can customise the information presented on a day by creating you own stylesheet that imports either _year.xsl_ or _yearplanner.xsl_ and implementing a template:

    <xsl:template match="day" mode="overlay">
      ...
    </xsl:template>
    
[An example](examples/zeppelin.svg) overlay is created by the __zeppelin__ target in [build.xml](build.xml). This takes data on Zeppelin raids in WW1 and overlays it on a 1915 year planner.
