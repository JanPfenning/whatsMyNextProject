<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xls="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="http://www.w3.org/1999/xhtml">

    <!-- Global Variables -->
    <xsl:variable name="svgWidth">500</xsl:variable>
    <xsl:variable name="svgHeight">500</xsl:variable>
    <xsl:variable name="svgCenterPointX"><xsl:value-of select="$svgWidth div 2"/></xsl:variable>
    <xsl:variable name="svgCenterPointY"><xsl:value-of select="$svgHeight div 2"/></xsl:variable>
    <xsl:variable name="averageSkill"><xsl:value-of select="2.5"/></xsl:variable>
    <xsl:variable name="projectCount">
        <xsl:value-of select="count(project_idea/project)"/>
    </xsl:variable>
    <xsl:variable name="topicCount">
        <xsl:value-of select="count(project_idea/topics/topic)"/>
    </xsl:variable>

    <!-- Landing Template -->
    <xsl:template match="/">
        <html>
            <head>
                <script lang="javascript" src="../../../fe/js/overview.js"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/overview.css" />
                <title>Find your next Project</title>
            </head>
            <body onload="init()">
                <!-- example code -->
                <div class="toolbar">
                    <button onclick="toDetail()"/>
                    <a href="./detail.xml">
                        <img src="https://upload.wikimedia.org/wikipedia/commons/0/06/OOjs_UI_icon_add.svg"/>
                    </a>
                    <a>Here will be a Toolbar</a>
                </div>
                <div class="testSpace">
                    <xsl:call-template name="topicChoice"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="topicChoice">
        <svg class="topicSpace" id="topics">
            <xsl:for-each select="project_idea/topics/topic">
                <xsl:variable name="x">
                    <xsl:value-of select="175*@id"/>
                </xsl:variable>
                <!--TODO Make r Dependent on projectcount-->
                <xsl:variable name="r">
                    <xsl:value-of select="105"/>
                </xsl:variable>
                <g>
                    <circle class="topicCircles" fill="rgba(0,128,128, 1)">
                        <xsl:attribute name="id">
                            <xsl:value-of select="concat('circle',@id)"/>
                        </xsl:attribute>
                        <xsl:attribute name="r">
                            <xsl:value-of select="$r"/>
                        </xsl:attribute>
                        <xsl:attribute name="cx">
                            <xsl:value-of select="$x"/>
                        </xsl:attribute>
                        <xsl:attribute name="cy">
                            <xsl:value-of select="$svgCenterPointY"/>
                        </xsl:attribute>
                        <xsl:attribute name="onclick">
                            toTopicProjects("<xsl:value-of select="name"/>")
                        </xsl:attribute>
                    </circle>
                    <!--TODO Make fontsoze Dependent on R and textlength-->
                    <text class="topicTexts" font-family="Arial, Helvetica, sans-serif" font-size="30" text-anchor="middle" fill="#FFFFFF">
                        <xsl:attribute name="id">
                            <xsl:value-of select="concat('text',@id)"/>
                        </xsl:attribute>
                        <xsl:attribute name="x">
                            <xsl:value-of select="$x"/>
                        </xsl:attribute>
                        <xsl:attribute name="y">
                            <xsl:value-of select="$svgCenterPointY"/>
                        </xsl:attribute>
                        <xsl:value-of select="name"/>
                    </text>
                </g>
            </xsl:for-each>
            <g>
                <!--TODO Maker and fontsize dependent-->
                <circle id="baseCircle" r="200" cx="50%" cy="100%" fill="rgba(254, 87,107,1)"/>
                <text id="baseText" font-family="Arial, Helvetica, sans-serif" x="50%" y="95%" font-size="40" text-anchor="middle" fill="#FFFFFF">
                    Bereichswahl
                </text>
            </g>
        </svg>
    </xsl:template>

    <!-- Calculate position on X-Axis for the Projectcircle-->
    <xsl:template name="x_val">
        <xsl:param name="duration"/>
        <xsl:param name="avgDur"/>
        <xsl:choose>
            <xsl:when test="number($duration) &gt;= $avgDur">
                <xsl:value-of select="$svgCenterPointX - 5 + round(($svgCenterPointX div $avgDur)*($duration - $avgDur))"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$svgCenterPointX + 5 - round(($svgCenterPointX div $avgDur)*($avgDur - $duration))"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Calculate position on Y-Axis for the Projectcircle-->
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

    <!-- Calculate Size of the Circle-->
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

    <!-- Calculate average duration (Helper for X-Axis calculation[x_val])-->
    <xsl:template name="calcAverageDur">
        <xsl:copy>
            <xsl:for-each select="project_idea">
                <xsl:value-of select="(sum(project/duration) div $projectCount)"/>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>

    <!-- Calculate average duration (Helper for Calculation of the size of the circle [getCircleSize])-->
    <xsl:template name="calcAverageLikes">
        <xsl:copy>
            <xsl:for-each select="project_idea">
                <xsl:value-of select="(sum(project/likes) div $projectCount)"/>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>