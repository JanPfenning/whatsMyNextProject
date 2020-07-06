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
                <script lang="javascript" src="../../../fe/js/overview.js"/>
                <script lang="javascript" src="../../../fe/js/trigonometrics.js"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/projectOverview.css" />
                <script lang="javascript" src="../../../fe/js/toolbar.js"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/toolbar.css" />
                <title>Find your next Project</title>
            </head>
            <body>
                <div id="toolbar">
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
                        <form action="../php/topics.php" id="toTopics"/>
                        <form action="../php/groups.php" id="toGroups">
                            <input type="hidden" name="GruppeID">
                                <xsl:attribute name="value">
                                    <xsl:value-of select="dataset/Projekte/ProjektView[1]/GruppeID"/>
                                </xsl:attribute>
                            </input>
                        </form>
                        <form action="../php/projects.php" id="toProjects">
                            <input type="hidden" name="GruppeID">
                                <xsl:attribute name="value">
                                    <xsl:value-of select="dataset/Projekte/ProjektView[1]/GruppeID"/>
                                </xsl:attribute>
                            </input>
                        </form>
                        <form action="../php/impressum.php" id="toImpressum"/>
                        <form action="../php/uber.php" id="toUber"/>
                        <form action="../php/createProjectFormular.php" id="toCreateProject">
                            <input type="hidden" name="GruppeID">
                                <xsl:attribute name="value">
                                    <xsl:value-of select="dataset/Projekte/ProjektView[1]/GruppeID"/>
                                </xsl:attribute>
                            </input>
                        </form>
                    </div>
                </div>
                <div class="content">
                    <xsl:attribute name="style">
                        <xsl:value-of select="concat('background-image: url(',dataset/BackgroundURL,')')"/>
                    </xsl:attribute>
                    <div class="headline"><h1>Projektübersicht</h1></div>
                    <div class="flexContainer">
                        <xsl:for-each select="dataset/Projekte/ProjektView">
                            <div class="projectField" data-hover="sehr geil">
                                <xsl:attribute name="onclick">
                                    <xsl:value-of select="concat('xslOnClick(',ProjektID,')')"/>
                                </xsl:attribute>
                                <xsl:attribute name="data-hover">
                                    <xsl:value-of select="Kurzbeschreibung"/>
                                </xsl:attribute>
                                <xsl:value-of select="ProjektName"/>
                            </div>
                        </xsl:for-each>
                    </div>
                    <xsl:for-each select="dataset/Projekte/ProjektView">
                        <form action="../php/detail.php" method="GET">
                            <xsl:attribute name="id">
                                <xsl:value-of select="concat('form_',ProjektID)"/>
                            </xsl:attribute>
                            <input type="hidden" name="ProjektID">
                                <xsl:attribute name="value">
                                    <xsl:value-of select="ProjektID"/>
                                </xsl:attribute>
                            </input>
                        </form>
                    </xsl:for-each>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>