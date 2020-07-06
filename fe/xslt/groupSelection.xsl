<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    meinCRAFT
                </title>
                <script lang="javascript" src="../../../fe/js/topicSelection.js"/>
                <script lang="javascript" src="../../../fe/js/toolbar.js"/>
                <script lang="javascript" src="../../../fe/js/trigonometrics.js"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/topicSelection.css" />
                <link rel="stylesheet" type="text/css" href="../../../fe/css/toolbar.css" />
            </head>
            <body onload="init()">
                <!-- Redirect forms for circles-->
                <div>
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
                </div>
                <div id="toolbar">
                    <span class="barE navE ascendent" onclick="navToTopics()">
                        Bereiche
                    </span>
                    <span class="barE navE" id="current" onclick="navToGroups()">
                        Gruppen
                    </span>
                    <span class="barE navE descendent">
                        Projekte
                    </span>
                    <span class="barE navE descendent">
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
                        <form action="../php/topics.php" id="toTopics"/>
                        <form action="../php/groups.php" id="toGroups">
                            <input type="hidden" name="GruppeID">
                                <xsl:attribute name="value">
                                    <xsl:value-of select="dataset/Gruppen/Gruppe[1]/BereichID"/>
                                </xsl:attribute>
                            </input>
                        </form>
                        <form action="../php/projects.php" id="toProjects">
                            <input type="hidden" name="GruppeID">
                                <xsl:attribute name="value">
                                    <xsl:value-of select="dataset/Gruppen/Gruppe[1]/GruppeID"/>
                                </xsl:attribute>
                            </input>
                        </form>
                        <form action="../php/impressum.php" id="toImpressum"/>
                        <form action="../php/uber.php" id="toUber"/>
                        <form action="../php/createProjectFormular.php" id="toCreateProject">
                            <input type="hidden" name="GruppeID">
                                <xsl:attribute name="value">
                                    <xsl:value-of select="dataset/Gruppen/Gruppe[1]/GruppeID"/>
                                </xsl:attribute>
                            </input>
                        </form>
                    </div>
                </div>
                <div id="content">
                    <xsl:attribute name="style">
                        <xsl:value-of select="concat('background-image: url(',dataset/BackgroundURL,')')"/>
                    </xsl:attribute>
                    <svg id="topicSelection" width="100%" height="100%"> <!--16/9-->
                        <xsl:for-each select="dataset/Gruppen/Gruppe">
                            <g class="topicG">
                                <xsl:attribute name="onclick">
                                    <xsl:value-of select="concat('xslOnClick(',GruppeID,')')"/>
                                </xsl:attribute>
                                <circle class="topicCircle"/>
                                <text class="circleText" text-anchor="middle">
                                    <xsl:value-of select="GruppeName"/>
                                </text>
                            </g>
                        </xsl:for-each>
                        <!-- Base circle -->
                        <g id="baseG">
                            <circle id="baseCircle" r="150" cx="50%" cy="100%"/>
                            <text id="baseCircleText" class="circleText" text-anchor="middle" x="50%" y="95%">Gruppenwahl</text>
                        </g>
                    </svg>
                </div>
                <div id="footer"></div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>