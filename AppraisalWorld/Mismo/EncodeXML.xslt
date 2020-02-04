<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" use-character-maps="Apos"/>
	<xsl:character-map name="Apos">
		<xsl:output-character character="&apos;" string="&amp;apos;"/>
	</xsl:character-map>
	<xsl:template match="node()|@*">
			<xsl:copy>
				<xsl:apply-templates select="node()|@*"/>
			</xsl:copy>
	</xsl:template>
	<xsl:template match="text()">
		<xsl:copy-of select="."/>
	</xsl:template>
</xsl:stylesheet>
