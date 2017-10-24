﻿<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:aspdnsf="http://www.aspdotnetstorefront.com">
	<xsl:output method="html" omit-xml-declaration="yes" standalone="yes"/>
	<xsl:key name="parentID" match="Vector" use="ParentVectorID"/>
	<xsl:param name="indent" select="'&#160;&#160;&#160;'"></xsl:param>

	  <xsl:param name="LocaleSetting" aspdnsf:sqlparam="LocaleSetting" aspdnsf:runtime="LocaleSetting" />
	  <xsl:param name="WebConfigLocaleSetting" aspdnsf:sqlparam="WebConfigLocaleSetting" aspdnsf:runtime="WebConfigLocaleSetting" />

    <xsl:template match="root">
		<xsl:call-template name="Vector">
			<xsl:with-param name="pvectorid" select="0"></xsl:with-param>
			<xsl:with-param name="prefix"></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="Vector">
		<xsl:param name="pvectorid"></xsl:param>
		<xsl:param name="prefix"></xsl:param>

		<xsl:for-each select="key('parentID', $pvectorid)">
			<xsl:variable name="eName">
				<xsl:choose>
					<xsl:when test="count(Name/ml/locale[@name=$LocaleSetting])!=0">
						<xsl:value-of select="Name/ml/locale[@name=$LocaleSetting]"/>
					</xsl:when>
					<xsl:when test="count(Name/ml/locale[@name=$WebConfigLocaleSetting])!=0">
						<xsl:value-of select="Name/ml/locale[@name=$WebConfigLocaleSetting]"/>
					</xsl:when>
					<xsl:when test="count(Name/ml)=0">
						<xsl:value-of select="Name"/>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>

			<nobr>
				<input type="checkbox" name="VectorMap" >
					<xsl:attribute name="value"><xsl:value-of select="VectorID"/></xsl:attribute>
					<xsl:if test="ProductID!=0">
						<xsl:attribute name="checked">checked</xsl:attribute>
					</xsl:if>
				</input>
				<xsl:choose>
					<xsl:when test="ParentVectorID=0">
						<b>
							<xsl:value-of select="concat($prefix,$eName)"/>
						</b>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($prefix,$eName)"/>
					</xsl:otherwise>
				</xsl:choose>
			</nobr><br/>
			<xsl:call-template name="Vector">
				<xsl:with-param name="pvectorid" select="VectorID"></xsl:with-param>
				<xsl:with-param name="prefix" select="concat($prefix, $indent)"></xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>