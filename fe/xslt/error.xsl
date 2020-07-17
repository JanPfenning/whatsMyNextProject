<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:n="http://localhost:63342/meinCraft/be/src/dtd/error.dtd"
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
                <meta charset="UTF-8"/>
                <title>meinCraft | Error</title>
                <script lang="javascript" src="../../../fe/js/error.js"/>
                <link rel="shortcut icon" href="../../../fe/img/favicon.ico"/>
                <link rel="stylesheet" type="text/css" href="../../../fe/css/error.css" />
            </head>
            <body>
                <div id="buttons">
                    <div id="errorText">
                        <xsl:value-of select="n:dataset/n:Errormessage"/>
                    </div>
                    <form name="toMainMenu" id="toMainMenuForm" action="../../be/src/php/index.php">
                        <button class="button" type="submit" id="toMainMenu">Zum Hauptmenu</button>
                    </form>
                    <form name="quitTab" action="../../be/src/php/index.php">
                        <button class="button" type="submit" id="quit">Verlassen</button>
                    </form>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>