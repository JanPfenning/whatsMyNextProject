<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <head>
                <script lang="javascript" src="../../../fe/js/detailNew.js"/>
                <script lang="javascript" src="../../../fe/js/trigonometrics.js"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/detailNew.css" />
            </head>
            <body onLoad="onInit()" onresize="onResize()">
                <xsl:attribute name="style">
                    <xsl:value-of select="concat('background-image: url(',dataset/BackgroundURL,')')"/>
                </xsl:attribute>
                <div id="backgroundOverlay">
                    <div id="toolbar">
                        <span class="barE navBut" onclick="navToTopics()">
                            Bereiche
                        </span>
                        <span class="barE navBut" onclick="navToGroups()">
                            Gruppen
                        </span>
                        <span class="barE navBut" onclick="navToProjects()">
                            Projekte
                        </span>
                        <span class="barE" id="current">
                            Details
                        </span>
                        <span id="forms">
                            <form action="topics.php" id="toTopics"/>
                            <form action="groups.php" id="toGroups">
                                <input type="hidden" name="ProjektID">
                                    <xsl:attribute name="value">
                                        <xsl:value-of select="dataset/Projekt/ProjektID"/>
                                    </xsl:attribute>
                                </input>
                            </form>
                            <form action="projects.php" id="toProjects">
                                <input type="hidden" name="GruppeID">
                                    <xsl:attribute name="value">
                                        <xsl:value-of select="dataset/Projekt/GruppeID"/>
                                    </xsl:attribute>
                                </input>
                            </form>
                        </span>
                    </div>
                    <div id="projectInformation" class="grid">
                        <div id="title">
                            <h1>
                                <xsl:value-of select="dataset/Projekt/ProjektName"/>
                            </h1>
                        </div>
                        <div id="picture">
                            <img id="projectImage">
                                <xsl:attribute name="src">
                                    <xsl:value-of select="concat('url(',dataset/Projekt/BildURL)"/>
                                </xsl:attribute>
                                <xsl:attribute name="alt">
                                    <xsl:value-of select="concat('picture of project: ',dataset/Projekt/ProjektName)"/>
                                </xsl:attribute>
                            </img>
                        </div>
                        <div id="tabInfo">
                            <div id="information">
                                <div id="description" class="tabcontent">
                                    <span>
                                        <xsl:value-of select="dataset/Projekt/Beschreibung"/>
                                    </span>
                                </div>
                                <div id="tools" class="tabcontent">
                                    <ul>
                                        <xsl:for-each select="dataset/Projekt/Werkzeugliste/Werkzeug">
                                            <li>
                                                <span class="identifier">
                                                    <xsl:value-of select="Name"/>
                                                </span>
                                                <span class="detail">
                                                    <xsl:value-of select="Beschreibung"/>
                                                </span>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </div>
                                <div id="materials" class="tabcontent">
                                    <ul>
                                        <xsl:for-each select="dataset/Projekt/Materialliste/Material">
                                            <li>
                                                <span class="identifier">
                                                    <xsl:value-of select="concat(Menge,' ',Einheit,' ',Name)"/>
                                                </span>
                                                <span class="detail">
                                                    <xsl:value-of select="Beschreibung"/>
                                                </span>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </div>
                                <button class="tablink" onclick="openInfo('description', this)" id="defaultOpen">Beschreibung</button>
                                <button class="tablink" onclick="openInfo('tools', this)">Werkzeug</button>
                                <button class="tablink" onclick="openInfo('materials', this)">Material</button>
                            </div>
                        </div>
                        <!--<div id="buttongroup">
                            <button>Download</button>
                            <button>Share</button>
                        </div>-->
                        <div id="radarChartArea" class="contentArea">
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
                            <svg id="radarChartSVG" height="300" width="400"/>
                        </div>
                        <div id="comments">
                            <xsl:for-each select="dataset/Projekt/Kommentarliste/KommentarView">
                                <div>
                                    <span class="Nick">
                                        <xsl:value-of select="Nick"/>
                                    </span>
                                    <span class="Message">
                                        <xsl:value-of select="Inhalt"/>
                                    </span>
                                </div>
                            </xsl:for-each>
                        </div>
                        <div id="likes">
                            <div id="star1">
                                <span class="Bewertungseinheit">1-Stern:&#160;&#160;&#160;</span>
                                <span>
                                    <xsl:value-of select="dataset/Projekt/Bewertungliste/Stern1"/>
                                </span>
                            </div>
                            <div id="star2">
                                <span class="Bewertungseinheit">2-Sterne: </span>
                                <span>
                                    <xsl:value-of select="dataset/Projekt/Bewertungliste/Stern2"/>
                                </span>
                            </div>
                            <div id="star3">
                                <span class="Bewertungseinheit">3-Sterne: </span>
                                <span>
                                    <xsl:value-of select="dataset/Projekt/Bewertungliste/Stern3"/>
                                </span>
                            </div>
                            <div id="star4">
                                <span class="Bewertungseinheit">4-Sterne: </span>
                                <span>
                                    <xsl:value-of select="dataset/Projekt/Bewertungliste/Stern4"/>
                                </span>
                            </div>
                            <div id="star5">
                                <span class="Bewertungseinheit">5-Sterne: </span>
                                <span>
                                    <xsl:value-of select="dataset/Projekt/Bewertungliste/Stern5"/>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>