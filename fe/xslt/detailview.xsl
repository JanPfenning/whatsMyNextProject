<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <head>
                <script lang="javascript" src="../../../fe/js/detail.js"/>
                <script lang="javascript" src="../../../fe/js/trigonometrics.js"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/detail.css" />
            </head>
            <body onLoad="onInit()">
                <div id="area">
                    <div id="content">
                        <div id="titleArea">
                            <a id="title">
                                <xsl:value-of select="dataset/Projekt/Name"/>
                            </a>
                        </div>
                        <div id="pictureArea">
                            <img id="projectImage" style="border-radius: 8px;">
                                <xsl:attribute name="src">
                                    <xsl:value-of select="dataset/Projekt/Bild"/>
                                </xsl:attribute>
                                <xsl:attribute name="alt">
                                    <xsl:value-of select="concat('picture of project: ',dataset/Projekt/Name)"/>
                                </xsl:attribute>
                            </img>
                        </div>
                        <div id="radarChartArea">
                            <!-- Contains info about the radarchart values for the taken project -->
                            <div id="projectMatrix" style="display:none;">
                                <div id="unterhaltsam">
                                    <xsl:value-of select="dataset/Projekt/Wertliste/Wert1"/>
                                </div>
                                <div id="wissenschaftlich">
                                    <xsl:value-of select="dataset/Projekt/Wertliste/Wert2"/>
                                </div>
                                <div id="kosten">
                                    <xsl:value-of select="dataset/Projekt/Wertliste/Wert3"/>
                                </div>
                                <div id="komplexitaet">
                                    <xsl:value-of select="dataset/Projekt/Wertliste/Wert4"/>
                                </div>
                                <div id="voraussetzungen">
                                    <xsl:value-of select="dataset/Projekt/Wertliste/Wert5"/>
                                </div>
                                <div id="einstiegshuerde">
                                    <xsl:value-of select="dataset/Projekt/Wertliste/Wert6"/>
                                </div>
                            </div>
                            <svg id="radarChartSVG" width="400" height="300"/>
                        </div>
                        <div id="materialArea">
                            <a id="materialHeader">Matierialien</a>
                            <div id="materials">
                                <ul>
                                    <xsl:for-each select="dataset/Projekt/Materialliste/Material">
                                        <li>
                                            <xsl:attribute name="id">
                                                <xsl:value-of select="concat('material_',Name)"/>
                                            </xsl:attribute>
                                            <a>
                                                <xsl:value-of select="concat(Menge,' ',Einheit,' ',Name)"/>
                                            </a>
                                        </li>
                                    </xsl:for-each>
                                </ul>
                            </div>
                        </div>
                        <div id="toolArea">
                            <a id="toolHeader">Werkzeuge</a>
                            <div id="toolList">
                                <ul>
                                    <xsl:for-each select="dataset/Projekt/Werkzeugliste/Werkzeug">
                                        <li>
                                            <xsl:attribute name="id">
                                                <xsl:value-of select="concat('tool_',Name)"/>
                                            </xsl:attribute>
                                            <a><xsl:value-of select="Name"/></a>
                                        </li>
                                    </xsl:for-each>
                                </ul>
                            </div>
                        </div>
                        <div id="descriptionArea">
                            <a id="descriptionHeader">Beschreibung</a>
                            <div id="description">
                                <xsl:value-of select="dataset/Projekt/Beschreibung"/>
                            </div>
                        </div>
                        <div id="commentArea">
                            <a id="commentHeader">Kommentare</a>
                            <xsl:for-each select="dataset/Projekt/KommentarView/Kommentar">
                                <div>
                                    <xsl:attribute name="id">
                                        <xsl:value-of select="concat('comment_',KommentarID)"/>
                                    </xsl:attribute>
                                    <div>
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="concat('comment_',KommentarID,'_author')"/>
                                        </xsl:attribute>
                                        <a>
                                            <xsl:value-of select="NutzerID"/>
                                        </a>
                                    </div>
                                    <div>
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="concat('comment_',KommentarID,'_text')"/>
                                        </xsl:attribute>
                                        <a>
                                            <xsl:value-of select="Inhalt"/>
                                        </a>
                                    </div>
                                    <!--<div>
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="concat('comment_',id,'_likes')"/>
                                        </xsl:attribute>
                                        <a>
                                            -Gefällt <xsl:value-of select="likes"/> Personen
                                        </a>
                                    </div>-->
                                </div>
                            </xsl:for-each>
                        </div>
                        <div id="likeArea">
                            <a id="likeHeader"> Likes </a>
                            <div id="star1">
                                <xsl:value-of select="concat('1-Star: ',dataset/Projekt/Bewertungliste/Stern1)"/>
                            </div>
                            <div id="star2">
                                <xsl:value-of select="concat('2-Star: ',dataset/Projekt/Bewertungliste/Stern2)"/>
                            </div>
                            <div id="star3">
                                <xsl:value-of select="concat('3-Star: ',dataset/Projekt/Bewertungliste/Stern3)"/>
                            </div>
                            <div id="star4">
                                <xsl:value-of select="concat('4-Star: ',dataset/Projekt/Bewertungliste/Stern4)"/>
                            </div>
                            <div id="star5">
                                <xsl:value-of select="concat('5-Star: ',dataset/Projekt/Bewertungliste/Stern5)"/>
                            </div>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>