<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" indent="yes" encoding="UTF-8" />
    <xsl:strip-space elements="*" />

    <xsl:variable name="spaces" select="'                                           '" />

    <xsl:template match="ctx_periph_help | node() | comment()" >
        <xsl:copy>
            <xsl:apply-templates select="@* | node() | comment()" >
                <xsl:sort select="@ref"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="serie | @*" >
        <xsl:variable name="indent" select="concat('&#10;', substring($spaces, 1, 4*count(ancestor::*)))" />
        <xsl:value-of select="$indent" />
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="@* | node()"/>
            <xsl:value-of select="$indent" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="peripheral | @*" >
        <xsl:variable name="indent" select="concat('&#10;', substring($spaces, 1, 4*count(ancestor::*)))" />
        <xsl:value-of select="$indent" />
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" >
                <xsl:sort select="@display" />
            </xsl:apply-templates>
            <xsl:value-of select="$indent" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="title | @*" >
        <xsl:variable name="indent" select="concat('&#10;', substring($spaces, 1, 4*count(ancestor::*)))" />
        <xsl:value-of select="$indent" />
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="extract | @*" >
        <xsl:variable name="indent" select="concat('&#10;', substring($spaces, 1, 4*count(ancestor::*)))" />
        <xsl:value-of select="$indent" />
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="help_text | @*" >
        <xsl:variable name="indent" select="concat('&#10;', substring($spaces, 1, 4*count(ancestor::*)))" />
        <xsl:value-of select="$indent" />
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="link | @*" >
        <xsl:variable name="indent" select="concat('&#10;', substring($spaces, 1, 4*count(ancestor::*)))" />
        <xsl:value-of select="$indent" />
        <xsl:copy>
            <xsl:copy-of select="@* | node()"/>
            <xsl:apply-templates />
            <xsl:value-of select="$indent" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="mode | @*" >
        <xsl:variable name="indent" select="concat('&#10;', substring($spaces, 1, 4*count(ancestor::*)))" />
        <xsl:value-of select="$indent" />
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="@* | node()" />
            <xsl:value-of select="$indent" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="config | @*" >
        <xsl:variable name="indent" select="concat('&#10;', substring($spaces, 1, 4*count(ancestor::*)))" />
        <xsl:value-of select="$indent" />
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="@* | node()" />
            <xsl:value-of select="$indent" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="comment()">
        <xsl:variable name="indent" select="concat('&#10;', substring($spaces, 1, 4*count(ancestor::*)))" />
        <xsl:value-of select="$indent" />
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="*|@*">
        <xsl:copy>
            <xsl:apply-templates />
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>