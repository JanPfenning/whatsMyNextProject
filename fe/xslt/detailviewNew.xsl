<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:n="http://localhost:63342/whatsMyNextProject/be/src/xml/dtdDetailNew.dtd"
                ><!--xmlns:svg="http://www.w3.org/2000/svg"-->

    <xsl:output
            method="html"
            doctype-public="-//W3C//DTD XHTML 1.1//EN"
            doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
            omit-xml-declaration="yes"
            encoding="UTF-8"
            indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <script lang="javascript" src="../../../fe/js/detailNew.js"/>
                <script lang="javascript" src="../../../fe/js/trigonometrics.js"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/detailNew.css"/>
            </head>
            <body onload="onInit()" onresize="onResize()">
                <!-- -->
                <xsl:attribute name="style">
                    <xsl:value-of select="concat('background-image: url(',n:dataset/n:BackgroundURL,')')"/>
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
                        <div id="forms">
                            <form action="topics.php" id="toTopics">
                            </form>
                            <form action="groups.php" id="toGroups">
                                <input type="hidden" name="ProjektID">
                                    <xsl:attribute name="value">
                                        <xsl:value-of select="n:dataset/n:Projekt/n:ProjektID"/>
                                    </xsl:attribute>
                                </input>
                            </form>
                            <form action="projects.php" id="toProjects">
                                <input type="hidden" name="GruppeID">
                                    <xsl:attribute name="value">
                                        <xsl:value-of select="n:dataset/n:Projekt/n:GruppeID"/>
                                    </xsl:attribute>
                                </input>
                            </form>
                        </div>
                    </div>
                    <div id="projectInformation" class="grid">
                        <div id="title">
                            <h1>
                                <xsl:value-of select="n:dataset/n:Projekt/n:ProjektName"/>
                            </h1>
                        </div>
                        <div id="picture">
                            <img id="projectImage">
                                <xsl:attribute name="src">
                                    <xsl:value-of select="concat('url(',n:dataset/n:Projekt/n:BildURL)"/>
                                </xsl:attribute>
                                <xsl:attribute name="alt">
                                    <xsl:value-of
                                            select="concat('picture of project: ',n:dataset/n:Projekt/n:ProjektName)"/>
                                </xsl:attribute>
                            </img>
                        </div>
                        <div id="tabInfo">
                            <div id="information">
                                <div id="description" class="tabcontent">
                                    <span>
                                        <xsl:value-of select="n:dataset/n:Projekt/n:Beschreibung"/>
                                    </span>
                                </div>
                                <div id="tools" class="tabcontent">
                                    <ul>
                                        <xsl:for-each select="n:dataset/n:Projekt/n:Werkzeugliste/n:Werkzeug">
                                            <li>
                                                <span class="identifier">
                                                    <xsl:value-of select="n:Name"/>
                                                </span>
                                                <span class="detail">
                                                    <xsl:value-of select="n:Beschreibung"/>
                                                </span>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </div>
                                <div id="materials" class="tabcontent">
                                    <ul>
                                        <xsl:for-each select="n:dataset/n:Projekt/n:Materialliste/n:Material">
                                            <li>
                                                <span class="identifier">
                                                    <xsl:value-of select="concat(n:Menge,' ',n:Einheit,' ',n:Name)"/>
                                                </span>
                                                <span class="detail">
                                                    <xsl:value-of select="n:Beschreibung"/>
                                                </span>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </div>
                                <button class="tablink" onclick="openInfo('description', this)" id="defaultOpen">
                                    Beschreibung
                                </button>
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
                                    <xsl:value-of select="n:dataset/n:Projekt/n:Wertliste/n:Wert1"/>
                                </div>
                                <div id="wissenschaftlich">
                                    <xsl:value-of select="n:dataset/n:Projekt/n:Wertliste/n:Wert2"/>
                                </div>
                                <div id="kosten">
                                    <xsl:value-of select="n:dataset/n:Projekt/n:Wertliste/n:Wert3"/>
                                </div>
                                <div id="komplexitaet">
                                    <xsl:value-of select="n:dataset/n:Projekt/n:Wertliste/n:Wert4"/>
                                </div>
                                <div id="voraussetzungen">
                                    <xsl:value-of select="n:dataset/n:Projekt/n:Wertliste/n:Wert5"/>
                                </div>
                                <div id="einstiegshuerde">
                                    <xsl:value-of select="n:dataset/n:Projekt/n:Wertliste/n:Wert6"/>
                                </div>
                            </div>
                            <svg id="radarChartSVG" height="300" width="400"/>
                        </div>
                        <div id="comments">
                            <xsl:for-each select="n:dataset/n:Projekt/n:Kommentarliste/n:KommentarView">
                                <div>
                                    <span class="Nick">
                                        <xsl:value-of select="n:Nick"/>
                                    </span>
                                    <span class="Message">
                                        <xsl:value-of select="n:Inhalt"/>
                                    </span>
                                </div>
                            </xsl:for-each>
                        </div>
                        <div id="likes">
                            <div id="star1">
                                <span class="Bewertungseinheit">1-Stern:&#160;&#160;&#160;</span>
                                <span>
                                    <xsl:value-of select="n:dataset/n:Projekt/n:Bewertungliste/n:Stern1"/>
                                </span>
                            </div>
                            <div id="star2">
                                <span class="Bewertungseinheit">2-Sterne:</span>
                                <span>
                                    <xsl:value-of select="n:dataset/n:Projekt/n:Bewertungliste/n:Stern2"/>
                                </span>
                            </div>
                            <div id="star3">
                                <span class="Bewertungseinheit">3-Sterne:</span>
                                <span>
                                    <xsl:value-of select="n:dataset/n:Projekt/n:Bewertungliste/n:Stern3"/>
                                </span>
                            </div>
                            <div id="star4">
                                <span class="Bewertungseinheit">4-Sterne:</span>
                                <span>
                                    <xsl:value-of select="n:dataset/n:Projekt/n:Bewertungliste/n:Stern4"/>
                                </span>
                            </div>
                            <div id="star5">
                                <span class="Bewertungseinheit">5-Sterne:</span>
                                <span>
                                    <xsl:value-of select="n:dataset/n:Projekt/n:Bewertungliste/n:Stern5"/>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>