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
                <script lang="javascript" src="../../../fe/js/overview.js"/>
                <script lang="javascript" src="../../../fe/js/trigonometrics.js"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/overview.css" />
                <title>Find your next Project</title>
            </head>
            <body>
                <xsl:for-each select="dataset/Projekte/ProjektView">
                    <form action="../php/detail.php" method="GET">
                        <xsl:attribute name="id">
                            <xsl:value-of select="concat('form_',ProjektID)"/>
                        </xsl:attribute>
                        <input type="hidden" name="ProjektID">
                            <xsl:attribute name="value">
                                <xsl:value-of select="ProjektID"/>
                            </xsl:attribute>
                        </input>
                    </form>
                </xsl:for-each>
                <xsl:for-each select="dataset/Projekte/ProjektView">
                    <div class="projekt">
                        <xsl:attribute name="onclick">
                            <xsl:value-of select="concat('xslOnClick(',ProjektID,')')"/>
                        </xsl:attribute>
                        <p><xsl:value-of select="ProjektName"/></p>
                    </div>
                    <div class="projektKurzbeschreibung">
                        <p>
                            <xsl:value-of select="Kurzbeschreibung"/>
                        </p>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>