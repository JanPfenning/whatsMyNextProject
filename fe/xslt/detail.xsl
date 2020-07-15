<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:n="http://localhost:63342/meinCraft/be/src/dtd/details.dtd"
                >
                <!-- xmlns:n="http://localhost:63342/meinCraft/be/src/dtd/details.dtd" -->

    <xsl:output
            method="xml"
            doctype-public="-//W3C//DTD XHTML 1.1//EN"
            doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
            omit-xml-declaration="yes"
            encoding="UTF-8"
            indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    meinCraft | Details
                </title>
                <script lang="javascript" src="../../../fe/js/detail.js"/>
                <script lang="javascript" src="../../../fe/js/trigonometrics.js"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/newestDetail.css"/>
                <script lang="javascript" src="../../../fe/js/toolbar.js"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/toolbar.css" />
            </head>
            <body onload="onInit()">
                <!-- -->
                <xsl:attribute name="style">
                    <xsl:value-of select="concat('background-image: url(',n:dataset/n:BackgroundURL,')')"/>
                </xsl:attribute>
                <div id="toolbar">
                    <span class="barE navE ascendent" onclick="navToHome()">
                        Home
                    </span>
                    <span class="barE navE ascendent" onclick="navToTopics()">
                        Bereiche
                    </span>
                    <span class="barE navE ascendent" onclick="navToGroups()">
                        Gruppen
                    </span>
                    <span class="barE navE ascendent" onclick="navToProjects()">
                        Projekte
                    </span>
                    <span class="barE navE" id="current" onclick="navToDetail()">
                        Details
                    </span>
                    <span class="barE right" onclick="toImpressum()">
                        Impressum
                    </span>
                    <span class="barE right" onclick="toUber()">
                        Über
                    </span>
                    <!-- Kein projekt aus den Gruppenn zu erstellen -->
                    <span class="barE right" onclick="toCreateProject()">
                        Projekt einreichen
                    </span>
                    <div id="forms">
                        <form action="../../../fe/html/index.html" id="toHome"/>
                        <form action="../php/topics.php" id="toTopics"/>
                        <form action="../php/groups.php" id="toGroups">
                            <input type="hidden" name="GruppeID">
                                <xsl:attribute name="value">
                                    <xsl:value-of select="n:dataset/n:Projekt/n:GruppeID"/>
                                </xsl:attribute>
                            </input>
                        </form>
                        <form action="../php/projects.php" id="toProjects">
                            <input type="hidden" name="GruppeID">
                                <xsl:attribute name="value">
                                    <xsl:value-of select="n:dataset/n:Projekt/n:GruppeID"/>
                                </xsl:attribute>
                            </input>
                        </form>
                        <form action="../php/impressum.php" id="toImpressum"/>
                        <form action="../php/uber.php" id="toUber"/>
                        <form action="../php/createProjectFormular.php" id="toCreateProject">
                            <input type="hidden" name="GruppeID">
                                <xsl:attribute name="value">
                                    <xsl:value-of select="n:dataset/n:Projekt/n:GruppeID"/>
                                </xsl:attribute>
                            </input>
                        </form>
                    </div>
                </div>
                <div class="content">
                    <div class="header">
                        <xsl:value-of select="n:dataset/n:Projekt/n:ProjektName"/>
                    </div>
                    <div class="main">
                        <div class="leftSide">
                            <div id="picture">
                                <img class="picsLeft" id="projectImage">
                                    <xsl:attribute name="src">
                                        <xsl:choose>
                                            <xsl:when test="n:dataset/n:Projekt/n:BildURL != ''">
                                                    <xsl:value-of select="concat('url(.',n:dataset/n:Projekt/n:BildURL)"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="'url(../../../../../fe/img/noIMG.jpg'"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:attribute>
                                    <xsl:attribute name="alt">
                                        <xsl:value-of
                                                select="concat('picture of project: ',n:dataset/n:Projekt/n:ProjektName)"/>
                                    </xsl:attribute>
                                </img>
                            </div>
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
                                <svg:svg id="radarChartSVG" height="300" width="400"/>
                            </div>
                            <div class="header2"><h2>Bewertungen</h2></div>
                            <div class="rating">
                                <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><p><xsl:value-of select="concat('(',n:dataset/n:Projekt/n:Bewertungliste/n:Stern1,')')"/></p><br />
                                <span>★</span><span>★</span><span>★</span><span>★</span><span>☆</span><p><xsl:value-of select="concat('(',n:dataset/n:Projekt/n:Bewertungliste/n:Stern2,')')"/></p><br />
                                <span>★</span><span>★</span><span>★</span><span>☆</span><span>☆</span><p><xsl:value-of select="concat('(',n:dataset/n:Projekt/n:Bewertungliste/n:Stern3,')')"/></p><br />
                                <span>★</span><span>★</span><span>☆</span><span>☆</span><span>☆</span><p><xsl:value-of select="concat('(',n:dataset/n:Projekt/n:Bewertungliste/n:Stern4,')')"/></p><br />
                                <span>★</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><p><xsl:value-of select="concat('(',n:dataset/n:Projekt/n:Bewertungliste/n:Stern5,')')"/></p>
                            </div>
                            <!--<div id="buttongroup">
                                <button>Download</button>
                                <button>Share</button>
                            </div>-->
                        </div>
                        <div class="rightSide">
                            <div class="header2"><h2>Materialien</h2></div>
                            <div class="texts"><ul>
                                <xsl:for-each select="n:dataset/n:Projekt/n:Materialliste/n:Material">
                                    <li class="identifier">
                                        <xsl:value-of select="concat(n:Menge,' ',n:Einheit,' ',n:Name)"/>
                                        <!--<span class="detail"><xsl:value-of select="n:Beschreibung"/></span>-->
                                    </li>
                                </xsl:for-each>
                            </ul></div>
                            <div class="header2"><h2>Werkzeuge</h2></div>
                            <div class="texts"><ul>
                                <xsl:for-each select="n:dataset/n:Projekt/n:Werkzeugliste/n:Werkzeug">
                                    <li><xsl:value-of select="n:Name"/></li>
                                </xsl:for-each>
                            </ul></div>
                            <div class="header2"><h2>Beschreibung</h2></div>
                            <div class="texts">
                                <xsl:value-of select="n:dataset/n:Projekt/n:Beschreibung"/>
                            </div>
                        </div>
                        <div class="commentSection">
                            <div class="header2"><h2>Kommentare</h2></div>
                            <xsl:for-each select="n:dataset/n:Projekt/n:Kommentarliste/n:KommentarView">
                                <div class="user1">
                                    <img class="userImg" src="https://upload.wikimedia.org/wikipedia/commons/d/d3/User_Circle.png" width="32px" height="32px" alt="User image"/>
                                    <div class="name"><p><xsl:value-of select="n:Nick"/></p></div>
                                    <div class="commentText"><p><xsl:value-of select="n:Inhalt"/></p></div>
                                </div>
                            </xsl:for-each>
                            <div class="comment">
                                <form method="post" action="../../../be/src/php/commentProject.php">
                                    <input type="hidden">
                                        <xsl:attribute name="value">
                                            <xsl:value-of select="n:dataset/n:Projekt/n:ProjektID"/>
                                        </xsl:attribute>
                                    </input>
                                    <div><label id="nickLabel" for="nick">Nickname</label></div>
                                    <div><input type="text" id="nick"></input></div>
                                    <div><label id="commentLabel" for="comment">Kommentar</label></div>
                                    <div><input type="text" id="comment"></input></div>
                                    <button type="submit">Submit</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>