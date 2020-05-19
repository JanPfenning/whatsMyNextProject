<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <head>
                <script lang="javascript" src="../../../fe/js/Chart.js"/>
                <script lang="javascript" src="../../../fe/js/detail.js"/>
            </head>
            <body onLoad="onInit()">
                <canvas id="radarChart"/>
                <xsl:for-each select="project_idea/project[@id='p1']">
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