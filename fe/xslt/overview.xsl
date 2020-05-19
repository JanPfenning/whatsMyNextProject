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
                <div class="coordinateSpace">
                    <xsl:call-template name="generateSVG"/>
                </div>
                <div class="testSpace">
                    <xsl:call-template name="topicChoice"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- Callable Templates -->
    <xsl:template name="generateSVG">
        <!-- Local variables - must be defined at this point and not globally because it works like this :) -->
        <xsl:variable name="avgDuration">
            <xsl:call-template name="calcAverageDur"/>
        </xsl:variable>
        <xsl:variable name="avgLikes">
            <xsl:call-template name="calcAverageLikes"/>
        </xsl:variable>
        <svg class="coordinateSys" xmlns="http://www.w3.org/2000/svg">
            <!--Y-Axis -->
            <line class="axis" fill="none" style="stroke-width:1">
                <xsl:attribute name="x1"><xsl:value-of select="$svgCenterPointX"/></xsl:attribute>
                <xsl:attribute name="y1">0</xsl:attribute>
                <xsl:attribute name="x2"><xsl:value-of select="$svgCenterPointX"/></xsl:attribute>
                <xsl:attribute name="y2"><xsl:value-of select="$svgHeight"/></xsl:attribute>
            </line>
            <!-- Y-Axis text -->
            <text class="svgText">
                <xsl:attribute name="x"><xsl:value-of select="$svgCenterPointX - 130"/></xsl:attribute>
                <xsl:attribute name="y"><xsl:value-of select="0 + 25"/></xsl:attribute>
                Skill-Anforderung
            </text>
            <!--X-Axis -->
            <line class="axis" fill="none" style="stroke-width:1">
                <xsl:attribute name="x1">0</xsl:attribute>
                <xsl:attribute name="y1"><xsl:value-of select="$svgCenterPointY"/></xsl:attribute>
                <xsl:attribute name="x2"><xsl:value-of select="$svgWidth"/></xsl:attribute>
                <xsl:attribute name="y2"><xsl:value-of select="$svgCenterPointY"/></xsl:attribute>
            </line>
            <!-- X-Axis text -->
            <text class="svgText">
                <xsl:attribute name="x"><xsl:value-of select="$svgWidth - 30"/></xsl:attribute>
                <xsl:attribute name="y"><xsl:value-of select="$svgCenterPointY + 15"/></xsl:attribute>
                Dauer
            </text>
            <!-- Center Point text (Average duration, Average difficulty) -->
            <text class="svgText">
                <xsl:attribute name="x"><xsl:value-of select="$svgCenterPointX + 5"/></xsl:attribute>
                <xsl:attribute name="y"><xsl:value-of select="$svgCenterPointY + 15"/></xsl:attribute>
                <xsl:value-of select="concat('(',$avgDuration,'h ,',$averageSkill,'&#9733;)')"/>
            </text>
            <xsl:for-each select="project_idea/project">
                <!-- Calculate positoin and size of the circle -->
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
                <!-- Actual Circle with metadata above -->
                <form method="post" action="./detail.xml">
                    <xls:attribute name="id">
                        <xsl:value-of select="concat('toDetailForm',@id)"/>
                    </xls:attribute>
                    <input type="hidden" name="id" value="{@id}"/>
                </form>
                <circle stroke="rgba(0,128,128, 255)" fill="rgba(0,128,128, 255)">
                    <xsl:attribute name="onclick">
                        toDetail(<xsl:value-of select="string(@id)"/>);
                    </xsl:attribute>
                    <xsl:attribute name="id">
                        circle<xsl:value-of select="string(@id)"/>
                    </xsl:attribute>
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

    <xsl:template name="topicChoice">
        <svg class="topicSpace" id="topics">
            <xsl:for-each select="project_idea/topics/topic">
                <xsl:variable name="alpha">
                    <xsl:call-template name="get_alpha">
                        <xsl:with-param name="position" select="@id"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="x">
                    <xsl:value-of select="175*@id"/>
                </xsl:variable>
                <xsl:variable name="r">
                    <xsl:value-of select="60"/>
                </xsl:variable>
                <text>
                    <xsl:call-template name="get_y">
                        <xsl:with-param name="alpha" select="$alpha"/>
                        <xsl:with-param name="rad" select="$r"/>
                    </xsl:call-template>
                </text>
                <g>
                    <circle stroke="rgba(0,128,128, 1)" fill="rgba(0,128,128, 1)">
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
                    <text text-anchor="middle" fill="#FFFFFF">
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
                <circle id="baseCircle" r="120" cx="50%" cy="100%" stroke="rgba(0,128,128, 1)" fill="rgba(0,128,128, 1)"/>
                <text id="baseText" x="50%" y="95%" text-anchor="middle" fill="#FFFFFF">
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

    <!-- Calculate the angle for each topic at the topic Page-->
    <xsl:template name="get_alpha">
        <xsl:param name="position"/>
        <xsl:value-of select="180 - $position*(180 div $projectCount)"/>
    </xsl:template>

    <!-- TODO calculate sin(alpha)*c to get X -->
    <xsl:template name="get_x">
        <xsl:param name="alpha"/>
        <!--<script type="text/javascript">
            var a = "<xsl:value-of select='$alpha'/>";
            getX(a);
        </script>-->
    </xsl:template>

    <!-- TODO calculate cos(alpha)*c to get X -->
    <xsl:template name="get_y">
        <xsl:param name="alpha"/>
        <xsl:param name="rad"/>
        <msxsl:script language="javaScript">
            return(sin(<xsl:value-of select="$alpha"/>) * <xsl:value-of select="$rad"/>);
        </msxsl:script>
    </xsl:template>

</xsl:stylesheet>