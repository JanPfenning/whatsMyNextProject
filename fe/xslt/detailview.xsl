<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <head>
                <script lang="javascript" src="../../../fe/js/detail.js"/>
                <script lang="javascript" src="../../../fe/js/trigonometrics.js"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/detail.css" />
            </head>
            <body onLoad="onInit()">
                <xsl:attribute name="style">
                    <xsl:value-of select="concat('background-image: url(',dataset/BackgroundURL,')')"/>
                </xsl:attribute>
                <div id="area">
                    <div id="content">
                        <div id="titleArea">
                            <a id="title">
                                <xsl:value-of select="dataset/Projekt/ProjektName"/>
                            </a>
                        </div>
                        <div id="left">
                            <div id="pictureArea" class="contentArea">
                                <img id="projectImage" style="border-radius: 8px;">
                                    <xsl:attribute name="src">
                                        <xsl:value-of select="dataset/Projekt/BildURL"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="alt">
                                        <xsl:value-of select="concat('picture of project: ',dataset/Projekt/ProjektName)"/>
                                    </xsl:attribute>
                                </img>
                            </div>
                            <div id="radarChartArea" class="contentArea">
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
                        </div>
                        <div id="right">
                            <div id="materialArea" class="contentArea">
                                <h2 id="materialHeader">Materialien</h2>
                                <div id="materials">
                                    <ul>
                                        <xsl:for-each select="dataset/Projekt/Materialliste/Material">
                                            <li class="material">
                                                <xsl:attribute name="id">
                                                    <xsl:value-of select="concat('material_',Name)"/>
                                                </xsl:attribute>
                                                <span class="a">
                                                    <xsl:value-of select="concat(Menge,' ',Einheit,' ',Name)"/>
                                                </span>
                                                <span class="materialDetail">
                                                    <xsl:value-of select="Beschreibung"/>
                                                </span>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </div>
                            </div>
                            <div id="toolArea" class="contentArea">
                                <h2 id="toolHeader">Werkzeuge</h2>
                                <div id="toolList">
                                    <ul>
                                        <xsl:for-each select="dataset/Projekt/Werkzeugliste/Werkzeug">
                                            <li class="tool">
                                                <xsl:attribute name="id">
                                                    <xsl:value-of select="concat('tool_',Name)"/>
                                                </xsl:attribute>
                                                <span class="a"><xsl:value-of select="Name"/></span>
                                                <span class="toolDetail"><xsl:value-of select="Beschreibung"/></span>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </div>
                            </div>
                            <div id="commentArea" class="contentArea">
                                <a id="commentHeader">Kommentare</a>
                                <xsl:for-each select="dataset/Projekt/Kommentarliste/KommentarView">
                                    <div>
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="concat('comment_',KommentarViewID)"/>
                                        </xsl:attribute>
                                        <div>
                                            <xsl:attribute name="id">
                                                <xsl:value-of select="concat('comment_',KommentarViewID,'_author')"/>
                                            </xsl:attribute>
                                            <a>
                                                <xsl:value-of select="Nick"/>
                                            </a>
                                        </div>
                                        <div>
                                            <xsl:attribute name="id">
                                                <xsl:value-of select="concat('comment_',KommentarViewID,'_text')"/>
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
                            <div id="likeArea" class="contentArea">
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


                        <div id="descriptionArea" class="contentArea">
                            <a id="descriptionHeader">Beschreibung</a>
                            <div id="description">
                                <xsl:value-of select="dataset/Projekt/Beschreibung"/>
                            </div>
                        </div>


                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>