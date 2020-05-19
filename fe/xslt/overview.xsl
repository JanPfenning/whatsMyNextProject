<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xls="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="http://www.w3.org/1999/xhtml">

    <!-- Landing Template -->
    <xsl:template match="/">
        <html>
            <head>
                <script lang="javascript" src="../../../fe/js/overview.js"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/overview.css" />
                <title>Find your next Project</title>
            </head>
            <body onload="init()">
                <xsl:call-template name="topicChoice"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="topicChoice">
        <div class="topicChoiceContainer">
            <svg class="topicSpace" id="topics">
                <!-- One Circle for each Topic -->
                <xsl:for-each select="project_idea/topics/topic">
                    <g>
                        <!--TODO Make r dependent on topiccount-->
                        <circle r="100" class="topicCircles" fill="rgba(0,128,128, 1)"/>
                        <!--TODO Make fontsize Dependent on R and textlength -->
                        <!--TODO outsource fontfamily to css -->
                        <text class="topicTexts" font-family="Arial, Helvetica, sans-serif" font-size="30" text-anchor="middle" fill="#FFFFFF">
                            <xsl:value-of select="name"/>
                        </text>
                    </g>
                </xsl:for-each>
                <!-- Base circle -->
                <g>
                    <!--TODO Maker and fontsize dependent-->
                    <circle id="baseCircle" r="200" cx="50%" cy="100%" fill="rgba(254, 87,107,1)"/>
                    <text id="baseText" font-family="Arial, Helvetica, sans-serif" x="50%" y="95%" font-size="40" text-anchor="middle" fill="#FFFFFF">
                        Bereichswahl
                    </text>
                </g>
            </svg>
        </div>
    </xsl:template>

</xsl:stylesheet>