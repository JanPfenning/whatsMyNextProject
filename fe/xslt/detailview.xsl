<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--xmlns:n="./dtd.dtd" xmlns="http://www.w3.org/1999/xhtml"-->
    <!--<xsl:output
            method="html"
            doctype-system="./dtd.dtd"
            omit-xml-declaration="yes"
            encoding="UTF-8"
            indent="yes" />-->
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
                        <xsl:variable name="projectID">
                            <xsl:value-of select="'1'"/>
                        </xsl:variable>

                        <div id="titleArea">
                            <a id="title">
                                <xsl:value-of select="dataset/projects/project[@id=$projectID]/name"/>
                            </a>
                        </div>
                        <div id="pictureArea">
                            <img id="projectImage" style="border-radius: 8px;">
                                <xsl:attribute name="src">
                                    <xsl:value-of select="dataset/projects/project[@id=$projectID]/picture"/>
                                </xsl:attribute>
                                <xsl:attribute name="alt">
                                    <xsl:value-of select="concat('picture of project: ',project_idea/project[@id=$projectID]/name)"/>
                                </xsl:attribute>
                            </img>
                        </div>
                        <div id="radarChartArea">
                            <!-- Contains info about the radarchart values for the taken project -->
                            <div id="projectMatrix" style="display:none;">
                                <div id="unterhaltsam">
                                    <xsl:value-of select="dataset/projects/project[@id=$projectID]/values/fun"/>
                                </div>
                                <div id="wissenschaftlich">
                                    <xsl:value-of select="dataset/projects/project[@id=$projectID]/values/scientific"/>
                                </div>
                                <div id="kosten">
                                    <xsl:value-of select="dataset/projects/project[@id=$projectID]/values/costs"/>
                                </div>
                                <div id="komplexitaet">
                                    <xsl:value-of select="dataset/projects/project[@id=$projectID]/values/complexity"/>
                                </div>
                                <div id="voraussetzungen">
                                    <xsl:value-of select="dataset/projects/project[@id=$projectID]/values/requirements"/>
                                </div>
                                <div id="einstiegshuerde">
                                    <xsl:value-of select="dataset/projects/project[@id=$projectID]/values/accessibility"/>
                                </div>
                            </div>
                            <svg id="radarChartSVG" width="100%" height="300">
                                <polygon class="hexPoly" id="polygon1"/>
                                <polygon class="hexPoly" id="polygon2"/>
                                <polygon class="hexPoly" id="polygon3"/>
                                <polygon class="hexPoly" id="polygon4"/>
                                <polygon class="hexPoly" id="polygon5"/>
                                <polygon class="hexPoly" id="polygon6"/>
                                <polygon class="hexPoly" id="polygon7"/>
                                <polygon class="hexPoly" id="polygon8"/>
                                <polygon class="hexPoly" id="polygon9"/>
                                <polygon class="hexPoly" id="polygon10"/>
                                <polygon class="heyPolyValues" id="polygonValues"/>
                                <text id="text1">Fun</text>
                                <text id="text2">Scientific</text>
                                <text id="text3">Costs</text>
                                <text id="text4">Complexity</text>
                                <text id="text5">Requirements</text>
                                <text id="text6">Accessibility</text>
                            </svg>
                        </div>
                        <div id="materialArea">
                            <a id="materialHeader">Matierialien</a>
                            <div id="materials">
                                <xsl:for-each select="dataset/projects/project[@id=$projectID]/materials/material">
                                    <div>
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="concat('material_',name)"/>
                                        </xsl:attribute>
                                        <a>
                                            <span><xsl:value-of select="amount"/></span>x <xsl:value-of select="name"/>
                                        </a>
                                    </div>
                                </xsl:for-each>
                            </div>
                        </div>
                        <div id="toolArea">
                            <a id="toolHeader">Tools</a>
                            <div id="toolList">
                                <xsl:for-each select="dataset/projects/project[@id=$projectID]/tools/tool">
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
                                <xsl:value-of select="dataset/projects/project[@id=$projectID]/beschreibung"/>
                            </div>
                        </div>
                        <div id="commentArea">
                            <a id="commentHeader">Comments</a>
                            <xsl:for-each select="dataset/projects/project[@id=$projectID]/feedback/comments/comment">
                                <div>
                                    <xsl:attribute name="id">
                                        <xsl:value-of select="concat('comment_',id)"/>
                                    </xsl:attribute>
                                    <div>
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="concat('comment_',id,'_author')"/>
                                        </xsl:attribute>
                                        <a>
                                            <xsl:value-of select="username"/>
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
                                            <xsl:value-of select="rating"/>
                                        </a>
                                    </div>
                                </div>
                            </xsl:for-each>
                        </div>
                        <div id="likeArea">
                            <a id="likeHeader"> Likes </a>
                            <div id="star1">
                                <xsl:value-of select="concat('1-Star: ',dataset/projects/project[@id=$projectID]/feedback/rating/star1)"/>
                            </div>
                            <div id="star2">
                                <xsl:value-of select="concat('2-Star: ',dataset/projects/project[@id=$projectID]/feedback/rating/star2)"/>
                            </div>
                            <div id="star3">
                                <xsl:value-of select="concat('3-Star: ',dataset/projects/project[@id=$projectID]/feedback/rating/star3)"/>
                            </div>
                            <div id="star4">
                                <xsl:value-of select="concat('4-Star: ',dataset/projects/project[@id=$projectID]/feedback/rating/star4)"/>
                            </div>
                            <div id="star5">
                                <xsl:value-of select="concat('5-Star: ',dataset/projects/project[@id=$projectID]/feedback/rating/star5)"/>
                            </div>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>