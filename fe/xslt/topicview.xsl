<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--xmlns:n="./dtd.dtd" xmlns="http://www.w3.org/1999/xhtml" xmlns:svg="http://www.w3.org/2000/svg"-->
    <!--https://www.w3schools.com/xml/ref_xsl_el_output.asp-->
    <!--<xsl:output
            method="html"
            doctype-system="./dtd.dtd"
            omit-xml-declaration="yes"
            encoding="UTF-8"
            indent="yes" />-->
    <!-- Landing Template -->
    <xsl:template match="/">
        <html>
            <head>
                <script lang="javascript" src="../../../fe/js/topics.js"/>
                <script lang="javascript" src="../../../fe/js/trigonometrics.js"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/topics.css" />
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
                <xsl:for-each select="dataset/topics/topic">
                    <g>
                        <circle r="100" class="topicCircles">
                            <!--<xsl:attribute name="onclick">xslOnClick(<xsl:value-of select="@id"/>)</xsl:attribute>-->
                        </circle>
                        <text class="text topicTexts"  text-anchor="middle" fill="#FFFFFF">
                            <xsl:value-of select="name"/>
                        </text>
                    </g>
                </xsl:for-each>
                <!-- Base circle -->
                <g>
                    <circle id="baseCircle" r="200" cx="50%" cy="100%"/>
                    <text class="text" id="baseText" x="50%" y="95%" text-anchor="middle" fill="#FFFFFF">Bereichswahl</text>
                </g>
            </svg>
        </div>
    </xsl:template>

</xsl:stylesheet>