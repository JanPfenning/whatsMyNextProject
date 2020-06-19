<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--xmlns:n="./dtd.dtd" xmlns="http://www.w3.org/1999/xhtml" xmlns:svg="http://www.w3.org/2000/svg"-->
    <!--<xsl:output
            method="html"
            doctype-system="./dtd.dtd"
            omit-xml-declaration="yes"
            encoding="UTF-8"
            indent="yes" />-->
    <xsl:template match="/">
        <html>
            <head>
                <script lang="javascript" src="../../../fe/js/groups.js"/>
                <script lang="javascript" src="../../../fe/js/trigonometrics.js"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/groups.css" />
                <title>Find your next Project</title>
            </head>
            <body onload="init()">
                <xsl:for-each select="dataset/Gruppen/Gruppe">
                    <form action="../php/projects.php" method="GET">
                        <xsl:attribute name="id">
                            <xsl:value-of select="concat('form_',GruppeID)"/>
                        </xsl:attribute>
                        <input type="hidden" name="GruppeID">
                            <xsl:attribute name="value">
                                <xsl:value-of select="GruppeID"/>
                            </xsl:attribute>
                        </input>
                    </form>
                </xsl:for-each>
                <div id="toolbar">
                    <span class="barE navBut" onclick="navToTopics()">
                        Bereiche
                    </span>
                    <span class="barE" id="current">
                        Gruppen
                    </span>
                    <div id="forms">
                        <form action="../../src/php/topics.php" id="toTopics"></form>
                    </div>
                </div>
                <div id="content">
                    <xsl:attribute name="style">
                        <xsl:value-of select="concat('background-image: url(',dataset/BackgroundURL,')')"/>
                    </xsl:attribute>
                    <svg class="groupSpace" id="groups" viewport="0 0 100 100">
                        <xsl:for-each select="dataset/Gruppen/Gruppe">
                            <g class="groupG">
                                <xsl:attribute name="onclick">
                                    <xsl:value-of select="concat('xslOnClick(',GruppeID,')')"/>
                                </xsl:attribute>
                                <circle r="100" class="groupCircles"/>
                                <text class="text groupTexts"  text-anchor="middle" fill="#FFFFFF">
                                    <xsl:value-of select="GruppeName"/>
                                </text>
                            </g>
                        </xsl:for-each>
                        <!-- Base circle -->
                        <g>
                            <circle id="baseCircle" r="200" cx="50%" cy="100%"/>
                            <text class="text" id="baseText" x="50%" y="95%" text-anchor="middle" fill="#FFFFFF">Gruppenwahl</text>
                        </g>
                    </svg>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="groupChoice">
        <div class="groupChoiceContainer">

        </div>
    </xsl:template>

</xsl:stylesheet>