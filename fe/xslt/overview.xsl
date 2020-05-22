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
                <!-- TODO this "1" has to be the id of the clicked topic before redirecting-->
                <xsl:for-each select="dataset/projects/project[groupID=1]">
                    <a><xsl:value-of select="name"/></a>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>