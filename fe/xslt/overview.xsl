<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xslt="http://www.w3.org/1999/XSL/Transform" xmlns:xls="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/overview.css" />
                <title>Find your next Project</title>
            </head>
            <body>
                <div class="toolbar">

                </div>
                <div class="coordinateSpace">
                    <xsl:call-template name="generateSVG"/>
                </div>
                <div class="projectOverviewPane">
                    <xsl:for-each select="project_idea/project">
                        <div>
                            <a><xsl:value-of select="@id"/></a>
                        </div>
                    </xsl:for-each>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:variable name="svgWidth">500</xsl:variable>
    <xsl:variable name="svgHeight">500</xsl:variable>
    <xsl:variable name="svgCenterPointX"><xsl:value-of select="$svgWidth div 2"/></xsl:variable>
    <xsl:variable name="svgCenterPointY"><xsl:value-of select="$svgHeight div 2"/></xsl:variable>
    <xsl:variable name="averageSkill"><xsl:value-of select="2.5"/></xsl:variable>
    <xsl:variable name="projectCount">
        <xsl:value-of select="count(project_idea/project)"/>
    </xsl:variable>

    <xsl:template name="generateSVG">
        <xsl:variable name="avgDuration">
            <xsl:call-template name="calcAverageDur"/>
        </xsl:variable>
        <xsl:variable name="avgLikes">
            <xsl:call-template name="calcAverageLikes"/>
        </xsl:variable>

        <svg class="coordinateSys" xmlns="http://www.w3.org/2000/svg">
            <!--Y-Axis -->
            <line stroke="rgba(0,128,128, 1)" fill="none" style="stroke-width:1">
                <xsl:attribute name="x1"><xsl:value-of select="$svgCenterPointX"/></xsl:attribute>
                <xsl:attribute name="y1">0</xsl:attribute>
                <xsl:attribute name="x2"><xsl:value-of select="$svgCenterPointX"/></xsl:attribute>
                <xsl:attribute name="y2"><xsl:value-of select="$svgHeight"/></xsl:attribute>
            </line>
            <text>
                <xsl:attribute name="x"><xsl:value-of select="$svgCenterPointX - 130"/></xsl:attribute>
                <xsl:attribute name="y"><xsl:value-of select="0 + 25"/></xsl:attribute>
                Skill-Anforderung
            </text>
            <!--X-Axis -->
            <line stroke="rgba(0,128,128, 1)" fill="none" style="stroke-width:1">
                <xsl:attribute name="x1">0</xsl:attribute>
                <xsl:attribute name="y1"><xsl:value-of select="$svgCenterPointY"/></xsl:attribute>
                <xsl:attribute name="x2"><xsl:value-of select="$svgWidth"/></xsl:attribute>
                <xsl:attribute name="y2"><xsl:value-of select="$svgCenterPointY"/></xsl:attribute>
            </line>
            <text>
                <xsl:attribute name="x"><xsl:value-of select="$svgWidth - 30"/></xsl:attribute>
                <xsl:attribute name="y"><xsl:value-of select="$svgCenterPointY + 15"/></xsl:attribute>
                Dauer
            </text>
            <text>
                <xsl:attribute name="x"><xsl:value-of select="$svgCenterPointX + 5"/></xsl:attribute>
                <xsl:attribute name="y"><xsl:value-of select="$svgCenterPointY + 15"/></xsl:attribute>
                <xsl:value-of select="concat('(',$avgDuration,'h ,',$averageSkill,'&#9733;)')"/>
            </text>
            <xsl:for-each select="project_idea/project">

                <xsl:variable name="x_val">
                    <xsl:call-template name="x_val">
                        <xsl:with-param name="duration" select="duration"/>
                        <xsl:with-param name="avgDur" select="number($avgDuration)"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="y_val">
                    <xsl:call-template name="y_val">
                        <xsl:with-param name="skill" select="skill"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="likeRadius">
                    <xsl:call-template name="getCircleSize">
                        <xsl:with-param name="likes" select="likes"/>
                        <xsl:with-param name="avgLikes" select="$avgLikes"/>
                    </xsl:call-template>
                </xsl:variable>
                <circle stroke="rgba(0,128,128, 255)" fill="rgba(0,128,128, 255)">
                    <xsl:attribute name="r">
                        <xsl:value-of select="$likeRadius"/>
                    </xsl:attribute>
                    <xsl:attribute name="cx">
                        <xsl:value-of select="$x_val"/>
                    </xsl:attribute>
                    <xsl:attribute name="cy">
                        <xsl:value-of select="$y_val"/>
                    </xsl:attribute>
                    <xsl:value-of select="@id"/>
                </circle>
            </xsl:for-each>
        </svg>
    </xsl:template>

    <!-- Calculate position for each Projectidea-->

    <xsl:template name="x_val">
        <xsl:param name="duration"/>
        <xsl:param name="avgDur"/>
        <!-- -->
        <xsl:choose>
            <xsl:when test="number($duration) &gt;= $avgDur">
                <xsl:value-of select="$svgCenterPointX - 5 + round(($svgCenterPointX div $avgDur)*($duration - $avgDur))"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$svgCenterPointX + 5 - round(($svgCenterPointX div $avgDur)*($avgDur - $duration))"/>
            </xsl:otherwise>
        </xsl:choose>
        <!-- -->
    </xsl:template>

    <xsl:template name="y_val">
        <xsl:param name="skill"/>
        <xsl:choose>
            <xsl:when test="number($skill) &gt;= $averageSkill">
                <xsl:value-of select="$svgCenterPointY + 5 - round(($svgCenterPointY div $averageSkill)*($skill - $averageSkill))"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$svgCenterPointY - 5 + round(($svgCenterPointY div $averageSkill)*($averageSkill - $skill))"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="getCircleSize">
        <xsl:param name="likes"/>
        <xsl:param name="avgLikes"/>
        <xsl:choose>
            <xsl:when test="number($likes) &gt; $avgLikes">
                <xsl:value-of select="ceiling(5 div $avgLikes * $likes)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="ceiling(5 div $avgLikes * $likes)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="calcAverageDur">
        <xsl:copy>
            <xsl:for-each select="project_idea">
                <xsl:value-of select="(sum(project/duration) div $projectCount)"/>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>

    <xsl:template name="calcAverageLikes">
        <xsl:copy>
            <xsl:for-each select="project_idea">
                <xsl:value-of select="(sum(project/likes) div $projectCount)"/>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>