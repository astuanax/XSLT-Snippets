<?xml version="1.0" encoding="UTF-8"?>
<!--
	XSLT native GUUID using a Lagged Fibanacci Generator (well ... some EXSLT involved ;-)
	Created by Len Dierickx on 2012-05-08.
	Copyright (c) 2012 __Astuanax__. All rights reserved.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" xmlns:math="http://exslt.org/math" xmlns:exsl="http://exslt.org/common" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0" extension-element-prefixes="date math">
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    <xsl:variable name="initK" select="128"/>
    <xsl:variable name="initJ" select="68"/>
    <xsl:variable name="initM" select="71538"/>
    <xsl:variable name="seed" select="generate-id(//*)"/>
    <xsl:template match="/">
        <!-- 

        Import the XSL file and call the template "guuids"
        - nr: number of guuids returned
        
        <xsl:call-template name="guuids"><xsl:with-param name="nr" select="2"/></xsl:call-template>
        
        Returns a node set:
        
        <guuids>
          <guuid nr="2">F269D186-F258-183A-F234-F223353BF7A</guuid>
        </guuids><guuids>
          <guuid nr="1">978D2D62-F269-F258-183A-F234DA60B64</guuid>
        </guuids>
        
        
        Any comments about the math are welcome,
        please review and send your ideas to:
        len ad astuanax dot com
        
        -->
        
        <xsl:call-template name="guuids"><xsl:with-param name="nr" select="2"/></xsl:call-template>
        
    </xsl:template>
    <!-- 
	
	
    Template toHex
	Copied from http://www.stylusstudio.com/xsllist/200303/post80360.html
    -->
    <xsl:variable name="hexDigits" select="'0123456789ABCDEF'"/>
    <xsl:template name="toHex">
        <xsl:param name="decimalNumber"/>
        <xsl:if test="$decimalNumber &gt;= 16">
            <xsl:call-template name="toHex">
                <xsl:with-param name="decimalNumber" select="floor($decimalNumber div 16)"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:value-of select="substring($hexDigits,   ($decimalNumber mod 16) + 1, 1)"/>
    </xsl:template>
    <!--
	
	
	Template Seedset
	Initial values to start the LG series
	
	xn = xn − j + xn − k (mod m),  0 < j < k
    -->
    <xsl:template name="seedSet">
        <xsl:param name="k" select="$initK"/>
        <xsl:param name="resultset"/>
        <xsl:param name="seeding" select="substring(translate($seed,'abcdefghijklmnopqrstuvwxyz','01234567890123456789012345'),2,4)"/>
        <xsl:variable name="mash">
            <xsl:call-template name="mash"/>
        </xsl:variable>
        <xsl:variable name="modulo">
            <xsl:value-of select="math:power(2,number(string-length($seeding * $mash)))"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$k = 0">
                <xsl:copy-of select="$resultset"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="previous">
                    <xsl:value-of select="exsl:node-set($resultset)//var[last()]"/>
                </xsl:variable>
                <xsl:variable name="temp">
                    <xsl:choose>
                        <xsl:when test="string-length($resultset) = 0">
                            <resultset>
                                <var>
                                    <xsl:value-of select="($seeding * $mash)"/>
                                </var>
                            </resultset>
                        </xsl:when>
                        <xsl:otherwise>
                            <resultset>
                                <xsl:copy-of select="exsl:node-set($resultset)//var"/>
                                <var>
                                    <xsl:value-of select="(( exsl:node-set($resultset)//var[last()] div $seeding ) + number(exsl:node-set($resultset)//var[last()])) mod $modulo"/>
                                </var>
                            </resultset>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:call-template name="seedSet">
                    <xsl:with-param name="k" select="number($k) - 1"/>
                    <xsl:with-param name="resultset" select="$temp"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--
	
	
	
	
	
	
	
	LAGGED FIBONACCI GENERATOR
	-->
    <xsl:template name="lfg">
        <xsl:param name="nextRand" select="0"/>
        <xsl:param name="seedSet">
            <xsl:call-template name="seedSet"/>
        </xsl:param>
        <xsl:variable name="mash">
            <xsl:call-template name="mash"/>
        </xsl:variable>
        <xsl:variable name="m">
            <xsl:value-of select="$initM"/>
        </xsl:variable>
        <xsl:variable name="k">
            <xsl:call-template name="absolute">
                <xsl:with-param name="vNum" select="number($initK - $nextRand)"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="j">
            <xsl:call-template name="absolute">
                <xsl:with-param name="vNum" select="number($initJ - $nextRand)"/>
            </xsl:call-template>
        </xsl:variable>
        <!--
       xn = xn − j + xn − k (mod m),  0 < j < k
       -->
        <xsl:choose>
            <xsl:when test="$nextRand = $initK">
                <xsl:value-of select="'Error: nextRand cannot be equal to K'"/>
            </xsl:when>
            <xsl:when test="$nextRand = $initJ">
                <xsl:value-of select="'Error: nextRand cannot be equal to J'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="x">
                    <xsl:value-of select="(exsl:node-set($seedSet)/resultset/var[position() = $j] - exsl:node-set($seedSet)/resultset/var[position() = $k]) mod $m"/>
                </xsl:variable>
                <xsl:call-template name="absolute">
                    <xsl:with-param name="vNum" select="translate($x,'e+.','')"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--
	
	
	Returns ABSOLUTE value of an int
	-->
    <xsl:template name="absolute">
        <xsl:param name="vNum" select="'a'"/>
        <xsl:choose>
            <xsl:when test="number($vNum)">
                <xsl:value-of select="$vNum*($vNum &gt;=0) - $vNum*($vNum &lt; 0)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'Not a numeric value, check input of -absolute- template'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--
	
	
	
	
	
        Based on http://baagoe.com/en/RandomMusings/javascript/ 
        Mash() JavaScript function 

	-->
    <xsl:variable name="n" select="date:seconds()"/>
    <xsl:template name="mash">
        <xsl:param name="seed" select="53258"/>
        <xsl:param name="count" select="10"/>
        <xsl:param name="result"/>
        <xsl:param name="node"/>
        <xsl:choose>
            <xsl:when test="$count = 0">
                <xsl:value-of select="$result"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="n-local" select="$n + $seed"/>
                <xsl:variable name="h" select="$n*0.02519603282416938"/>
                <xsl:variable name="step1" select="floor($h) -$n-local"/>
                <xsl:variable name="step2" select="floor($h) * $step1"/>
                <xsl:variable name="step3" select="$step2 * $step1"/>
                <xsl:variable name="step4" select="floor($step3)"/>
                <xsl:variable name="step5" select="$step3 * $step4"/>
                <xsl:variable name="step6" select="$step4 + $step5 * 4294967296"/>
                <xsl:variable name="temp" select="floor($step6) * number(2.3283064365386963e-45)"/>
                <xsl:call-template name="mash">
                    <xsl:with-param name="count" select="$count - 1"/>
                    <xsl:with-param name="result" select="$temp"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--
	
	
	
	
	
	
	
	
	Template GUUIDS: 
	0e21d666-dbcd-102b-9532-00301b462e0a
	8-4-4-4-12
	-->
    <xsl:template name="guuids">
        <xsl:param name="nr" select="1"/>
        <xsl:param name="guuids"/>
        <xsl:param name="resultset"/>
        <xsl:choose>
            <xsl:when test="$nr = 0">
                <xsl:value-of select="$resultset"/>
            </xsl:when>
            <xsl:otherwise>
                <guuids>
                    <xsl:copy-of select="exsl:node-set($resultset)/guuids//guuid"/>
                    <guuid nr="{$nr}">
                        <xsl:call-template name="guuid">
                            <xsl:with-param name="nr" select="$nr"/>
                        </xsl:call-template>
                    </guuid>
                </guuids>
                <xsl:call-template name="guuids">
                    <xsl:with-param name="nr" select="$nr - 1"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--
    
    
    
    -->
    <xsl:template name="guuid">
        <xsl:param name="nr" select="1"/>
        <xsl:variable name="part1">
            <xsl:call-template name="toHex">
                <xsl:with-param name="decimalNumber">
                    <xsl:call-template name="lfg">
                        <xsl:with-param name="nextRand" select="$nr + 2"/>
                    </xsl:call-template>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="part2">
            <xsl:call-template name="toHex">
                <xsl:with-param name="decimalNumber">
                    <xsl:call-template name="lfg">
                        <xsl:with-param name="nextRand" select="$nr + 3"/>
                    </xsl:call-template>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="part3">
            <xsl:call-template name="toHex">
                <xsl:with-param name="decimalNumber">
                    <xsl:call-template name="lfg">
                        <xsl:with-param name="nextRand" select="$nr + 4"/>
                    </xsl:call-template>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="part4">
            <xsl:call-template name="toHex">
                <xsl:with-param name="decimalNumber">
                    <xsl:call-template name="lfg">
                        <xsl:with-param name="nextRand" select="$nr + 5"/>
                    </xsl:call-template>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="part5">
            <xsl:call-template name="toHex">
                <xsl:with-param name="decimalNumber">
                    <xsl:call-template name="lfg">
                        <xsl:with-param name="nextRand" select="$nr + 6"/>
                    </xsl:call-template>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="substring($part1,1,8)"/>
        <xsl:value-of select="'-'"/>
        <xsl:value-of select="substring($part2,1,4)"/>
        <xsl:value-of select="'-'"/>
        <xsl:value-of select="substring($part3,1,4)"/>
        <xsl:value-of select="'-'"/>
        <xsl:value-of select="substring($part4,1,4)"/>
        <xsl:value-of select="'-'"/>
        <xsl:value-of select="substring($part5,1,12)"/>
    </xsl:template>
</xsl:stylesheet>
