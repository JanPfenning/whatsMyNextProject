<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
                xmlns:svg="http://www.w3.org/2000/svg">
    <xsl:output
            method="html"
            doctype-system="./dtd.dtd"
            omit-xml-declaration="yes"
            encoding="UTF-8"
            indent="yes" />
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
            <svg:svg class="topicSpace" id="topics">
                <!-- One Circle for each Topic -->
                <xsl:for-each select="project_idea/topics/topic">
                    <svg:g>
                        <svg:circle r="100" class="topicCircles">
                            <xsl:attribute name="onclick">xslOnClick(<xsl:value-of select="@id"/>)</xsl:attribute>
                        </svg:circle>
                        <!--TODO outsource fontfamily to css -->
                        <svg:text class="text topicTexts"  text-anchor="middle" fill="#FFFFFF">
                            <xsl:value-of select="name"/>
                        </svg:text>
                    </svg:g>
                </xsl:for-each>
                <!-- Base circle -->
                <svg:g>
                    <svg:circle id="baseCircle" r="200" cx="50%" cy="100%"/>
                    <svg:text class="text" id="baseText" x="50%" y="95%" text-anchor="middle" fill="#FFFFFF">
                        Bereichswahl
                    </svg:text>
                </svg:g>
            </svg:svg>
        </div>
    </xsl:template>

</xsl:stylesheet>