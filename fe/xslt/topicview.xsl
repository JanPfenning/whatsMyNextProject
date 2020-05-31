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
                <xsl:attribute name="style">
                    <xsl:value-of select="concat('background-image: url(',dataset/BackgroundURL,')')"/>
                </xsl:attribute>
                <xsl:call-template name="topicChoice"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="topicChoice">
        <div class="topicChoiceContainer">
            <xsl:for-each select="dataset/Bereiche/Bereich">
                <form action="../php/groups.php" method="GET">
                    <xsl:attribute name="id">
                        <xsl:value-of select="concat('form_',BereichID)"/>
                    </xsl:attribute>
                    <input type="hidden" name="BereichID">
                        <xsl:attribute name="value">
                            <xsl:value-of select="BereichID"/>
                        </xsl:attribute>
                    </input>
                </form>
            </xsl:for-each>
            <svg class="topicSpace" id="topics">
                <!-- One Circle for each Topic -->
                <xsl:for-each select="dataset/Bereiche/Bereich">
                    <g class="topicG">
                        <xsl:attribute name="onclick">
                            <xsl:value-of select="concat('xslOnClick(',BereichID,')')"/>
                        </xsl:attribute>
                        <circle r="100" class="topicCircles"/>
                        <text class="text topicTexts"  text-anchor="middle" fill="#FFFFFF">
                            <xsl:value-of select="BereichName"/>
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