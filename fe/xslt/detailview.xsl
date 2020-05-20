<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output
            method="html"
            doctype-system="./dtd.dtd"
            omit-xml-declaration="yes"
            encoding="UTF-8"
            indent="yes" />
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
                <div id="radarChartArea">
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
                </div>
                <div id="materialArea">
                    <a id="materialHeader">Matierialien</a>
                    <div id="materials">
                        <xsl:for-each select="project_idea/project[@id=$projectID]/materialien/material">
                            <div>
                                <xsl:attribute name="id">
                                    <xsl:value-of select="concat('material_',name)"/>
                                </xsl:attribute>
                                <a>
                                    <span><xsl:value-of select="anzahl"/></span>x <xsl:value-of select="name"/>
                                </a>
                            </div>
                        </xsl:for-each>
                    </div>
                </div>
                <div id="toolArea">
                    <a id="toolHeader">Tools</a>
                    <div id="toolList">
                        <xsl:for-each select="project_idea/project[@id=$projectID]/werkzeuge/werkzeug">
                                <div>
                                    <xsl:attribute name="id">
                                        <xsl:value-of select="concat('tool_',name)"/>
                                    </xsl:attribute>
                                    <a><xsl:value-of select="name"/></a>
                                </div>
                        </xsl:for-each>
                    </div>
                </div>
                <div id="descriptionArea">
                    <a id="descriptionHeader">Beschreibung</a>
                    <div id="description">
                        <xsl:value-of select="project_idea/project[@id=$projectID]/beschreibung"/>
                    </div>
                </div>
                <div id="commentArea">
                    <a id="commentHeader">Comments</a>
                    <xsl:for-each select="project_idea/project[@id=$projectID]/rueckmeldungen/kommentare/kommentar">
                        <div>
                            <xsl:attribute name="id">
                                <xsl:value-of select="concat('comment_',id)"/>
                            </xsl:attribute>
                            <div>
                                <xsl:attribute name="id">
                                    <xsl:value-of select="concat('comment_',id,'_author')"/>
                                </xsl:attribute>
                                <a>
                                    <xsl:value-of select="benutzername"/>
                                </a>
                            </div>
                            <div>
                                <xsl:attribute name="id">
                                    <xsl:value-of select="concat('comment_',id,'_text')"/>
                                </xsl:attribute>
                                <a>
                                    <xsl:value-of select="text"/>
                                </a>
                            </div>
                            <div>
                                <xsl:attribute name="id">
                                    <xsl:value-of select="concat('comment_',id,'_likes')"/>
                                </xsl:attribute>
                                <a>
                                    <xsl:value-of select="bewertung"/>
                                </a>
                            </div>
                        </div>
                    </xsl:for-each>
                </div>
                <div id="likeArea">
                    <a id="likeHeader"> Likes </a>
                    <div id="star1">
                        <xsl:value-of select="concat('1-Star: ',project_idea/project[@id=$projectID]/rueckmeldungen/bewertungen/stern1)"/>
                    </div>
                    <div id="star2">
                        <xsl:value-of select="concat('2-Star: ',project_idea/project[@id=$projectID]/rueckmeldungen/bewertungen/stern2)"/>
                    </div>
                    <div id="star3">
                        <xsl:value-of select="concat('3-Star: ',project_idea/project[@id=$projectID]/rueckmeldungen/bewertungen/stern3)"/>
                    </div>
                    <div id="star4">
                        <xsl:value-of select="concat('4-Star: ',project_idea/project[@id=$projectID]/rueckmeldungen/bewertungen/stern4)"/>
                    </div>
                    <div id="star5">
                        <xsl:value-of select="concat('5-Star: ',project_idea/project[@id=$projectID]/rueckmeldungen/bewertungen/stern5)"/>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>