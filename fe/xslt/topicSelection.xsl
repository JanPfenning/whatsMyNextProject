<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--xmlns:n="./dtd.dtd" xmlns="http://www.w3.org/1999/xhtml" xmlns:svg="http://www.w3.org/2000/svg"-->
    <!--https://www.w3schools.com/xml/ref_xsl_el_output.asp-->
    <!--<xsl:output
            method="html"
            doctype-system="./dtd.dtd"
            omit-xml-declaration="yes"
            encoding="UTF-8"
            indent="yes" />-->
    <xsl:template match="/">
        <html>
            <head>
                <script lang="javascript" src="../../../fe/js/topicSelection.js"/>
                <script lang="javascript" src="../../../fe/js/trigonometrics.js"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/topicSelection.css" />
            </head>
            <body onload="init()">
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
                <div id="toolbar">
                    <a class="toolbarText"> Bereiche </a>
                    <!--<a class="toolbarText"> Gruppen </a>
                    <a class="toolbarText"> Projekte </a>
                    <a class="toolbarText"> Details </a>-->
                </div>
                <div id="content">
                    <xsl:attribute name="style">
                        <xsl:value-of select="concat('background-image: url(',dataset/BackgroundURL,')')"/>
                    </xsl:attribute>
                    <svg id="topicSelection" width="100%" height="100%"> <!--16/9-->
                        <xsl:for-each select="dataset/Bereiche/Bereich">
                            <g>
                                <xsl:attribute name="onclick">
                                    <xsl:value-of select="concat('xslOnClick(',BereichID,')')"/>
                                </xsl:attribute>
                                <circle class="topicCircle"/>
                                <text class="circleText" text-anchor="middle">
                                    <xsl:value-of select="BereichName"/>
                                </text>
                            </g>
                        </xsl:for-each>
                        <!-- Base circle -->
                        <g>
                            <circle id="baseCircle" r="150" cx="50%" cy="100%"/>
                            <text id="baseCircleText" class="circleText" text-anchor="middle" x="50%" y="95%">Bereichswahl</text>
                        </g>
                    </svg>
                </div>
                <div id="footer"></div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>