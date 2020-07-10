<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:n="http://localhost:63342/meinCraft/be/src/dtd/groups.dtd"
>

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
                    <xsl:for-each select="n:dataset/n:Gruppen/n:Gruppe">
                        <form action="../php/projects.php" method="GET">
                            <xsl:attribute name="id">
                                <xsl:value-of select="concat('form_',n:GruppeID)"/>
                            </xsl:attribute>
                            <input type="hidden" name="GruppeID">
                                <xsl:attribute name="value">
                                    <xsl:value-of select="n:GruppeID"/>
                                </xsl:attribute>
                            </input>
                        </form>
                    </xsl:for-each>
                </div>
                <div id="toolbar">
                    <span class="barE navE ascendent" onclick="navToHome()">
                        Home
                    </span>
                    <span class="barE navE ascendent" onclick="navToTopics()">
                        Bereiche
                    </span>
                    <span class="barE navE" id="current" onclick="navToGroups()">
                        Gruppen
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
                                    <xsl:value-of select="n:dataset/n:Gruppen/n:Gruppe[1]/n:BereichID"/>
                                </xsl:attribute>
                            </input>
                        </form>
                        <form action="../php/projects.php" id="toProjects">
                            <input type="hidden" name="GruppeID">
                                <xsl:attribute name="value">
                                    <xsl:value-of select="n:dataset/n:Gruppen/n:Gruppe[1]/n:GruppeID"/>
                                </xsl:attribute>
                            </input>
                        </form>
                        <form action="../php/impressum.php" id="toImpressum"/>
                        <form action="../php/uber.php" id="toUber"/>
                        <form action="../php/createProjectFormular.php" id="toCreateProject">
                            <input type="hidden" name="GruppeID">
                                <xsl:attribute name="value">
                                    <xsl:value-of select="n:dataset/n:Gruppen/n:Gruppe[1]/n:GruppeID"/>
                                </xsl:attribute>
                            </input>
                        </form>
                    </div>
                </div>
                <div id="content">
                    <xsl:attribute name="style">
                        <xsl:value-of select="concat('background-image: url(',n:dataset/n:BackgroundURL,')')"/>
                    </xsl:attribute>
                    <svg:svg id="topicSelection" width="100%" height="100%"> <!--16/9-->
                        <xsl:for-each select="n:dataset/n:Gruppen/n:Gruppe">
                            <svg:g class="topicG">
                                <xsl:attribute name="onclick">
                                    <xsl:value-of select="concat('xslOnClick(',n:GruppeID,')')"/>
                                </xsl:attribute>
                                <svg:circle class="topicCircle"/>
                                <svg:text class="circleText" text-anchor="middle">
                                    <xsl:value-of select="n:GruppeName"/>
                                </svg:text>
                            </svg:g>
                        </xsl:for-each>
                        <!-- Base circle -->
                        <svg:g id="baseG">
                            <svg:circle id="baseCircle" r="150" cx="50%" cy="100%"/>
                            <svg:text id="baseCircleText" class="circleText" text-anchor="middle" x="50%" y="95%">Gruppenwahl</svg:text>
                        </svg:g>
                    </svg:svg>
                </div>
                <div id="footer"></div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>