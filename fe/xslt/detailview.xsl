<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <head>
                <script lang="javascript" src="../../../fe/js/Chart.js"/>
                <script lang="javascript" src="../../../fe/js/detail.js"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/detail.css" />
            </head>
            <body onLoad="onInit()">

                <xsl:variable name="projectID">
                    <xsl:value-of select="'p1'"/>
                </xsl:variable>

                <div id="titleArea">
                    <a id="title">
                        <xsl:value-of select="project_idea/project[@id=$projectID]/name"/>
                    </a>
                </div>
                <div id="pictureArea">
                    <img id="projectImage" style="border-radius: 8px;">
                        <xsl:attribute name="src">
                            <xsl:value-of select="project_idea/project[@id=$projectID]/bild"/>
                        </xsl:attribute>
                        <xsl:attribute name="alt">
                            <xsl:value-of select="concat('picture of project: ',project_idea/project[@id=$projectID]/name)"/>
                        </xsl:attribute>
                    </img>
                </div>
                <canvas id="radarChart"/>
                <xsl:for-each select="project_idea/project[@id=$projectID]">
                    <!-- Contains info about the radarchart values for the taken project -->
                    <div id="projectMatrix" style="display:none;">
                        <div id="unterhaltsam">
                            <xsl:value-of select="werte/unterhaltsam"/>
                        </div>
                        <div id="wissenschaftlich">
                            <xsl:value-of select="werte/wissenschaftlich"/>
                        </div>
                        <div id="kosten">
                            <xsl:value-of select="werte/kosten"/>
                        </div>
                        <div id="komplexitaet">
                            <xsl:value-of select="werte/komplexitaet"/>
                        </div>
                        <div id="voraussetzungen">
                            <xsl:value-of select="werte/voraussetzungen"/>
                        </div>
                        <div id="einstiegshuerde">
                            <xsl:value-of select="werte/einstiegshuerde"/>
                        </div>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>