<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:template match="/">
	<xsl:for-each select="rss/channel/item">
<xsl:value-of select="title"/><xsl:text> </xsl:text><xsl:value-of select="link"/>
<xsl:text><!-- line break -->
</xsl:text>
	</xsl:for-each>
	<xsl:text><!-- line break -->
</xsl:text>
    </xsl:template>
</xsl:stylesheet>
