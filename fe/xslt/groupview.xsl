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
                <!--<link rel="stylesheet" type="text/css" href="../../../fe/css/groupview.css" />-->
                <title>Find your next Project</title>
            </head>
            <body>
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
                <xsl:for-each select="dataset/Gruppen/Gruppe">
                    <div>
                        <xsl:attribute name="onclick">
                            <xsl:value-of select="concat('xslOnClick(',GruppeID,')')"/>
                        </xsl:attribute>
                        <p><xsl:value-of select="GruppeName"/></p>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="groupChoice">
        <div class="groupChoiceContainer">

        </div>
    </xsl:template>

</xsl:stylesheet>