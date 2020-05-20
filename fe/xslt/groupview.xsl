<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <head>
                <script lang="javascript" src="../../../fe/js/groupview.js"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/groupview.css" />
                <title>Find your next Project</title>
            </head>
            <body onload="init()">
                <xsl:call-template name="groupChoice"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="groupChoice">
        <div class="groupChoiceContainer">
            <svg class="groupSpace" id="topics">
                <!-- One Circle for each Topic -->
                <xsl:for-each select="project_idea/bereiche/name">
                    <g>
                        <circle r="100" class="topicCircles">
                            <xsl:attribute name="onclick">xslOnClick(<xsl:value-of select="@id"/>)</xsl:attribute>
                        </circle>
                        <!--TODO outsource fontfamily to css -->
                        <text class="text topicTexts"  text-anchor="middle" fill="#FFFFFF">
                            <xsl:value-of select="name"/>
                        </text>
                    </g>
                </xsl:for-each>
                <!-- Base circle -->
                <g>
                    <circle id="baseCircle" r="200" cx="50%" cy="100%"/>
                    <text class="text" id="baseText" x="50%" y="95%" text-anchor="middle" fill="#FFFFFF">
                        Bereichswahl
                    </text>
                </g>
            </svg>
        </div>
    </xsl:template>

</xsl:stylesheet>