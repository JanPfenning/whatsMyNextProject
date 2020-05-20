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
                <!--<script lang="javascript" src="../../../fe/js/groupview.js"/>-->
                <!--<link rel="stylesheet" type="text/css" href="../../../fe/css/groupview.css" />-->
                <title>Find your next Project</title>
            </head>
            <body>
                <xsl:call-template name="groupChoice"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="groupChoice">
        <div class="groupChoiceContainer">
            <xsl:for-each select="project_idea/bereiche/bereich[@id=1]/gruppen/gruppe">
                <a><xsl:value-of select="name"/></a>
            </xsl:for-each>
        </div>
    </xsl:template>

</xsl:stylesheet>