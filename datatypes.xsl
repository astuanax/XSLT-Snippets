<?xml version="1.0" encoding="UTF-8"?>
<!-- untitled
	Created by Len Dierickx on 2012-05-11.
	Copyright (c) 2012 __Astuanax__. All rights reserved.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" xmlns:math="http://exslt.org/math" xmlns:exsl="http://exslt.org/common" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0" extension-element-prefixes="date math">
	<xsl:output encoding="UTF-8" indent="yes" method="text"/>
	<xsl:variable name="dataTypes">
		<xsl:copy-of select="document('./datatypes.xml')/*"/>
	</xsl:variable>
	<xsl:template match="/">
		<!-- <xsl:call-template name="getCourierGUUIDS">
			<xsl:with-param name="docTypeFieldGUUID" select="'ec15c1e5-9d90-422a-aa52-4f7622c63bea'"/>
		</xsl:call-template> -->
	</xsl:template>
	<!--
	
	
	
	-->
	<xsl:template name="getDataType">
		<xsl:param name="g"/>
		<xsl:variable name="newG">
			<xsl:call-template name="getCourierGUUIDS">
				<xsl:with-param name="docTypeFieldGUUID" select="translate($g,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
			</xsl:call-template>
		</xsl:variable>
		<FieldTypeId>
			<xsl:value-of select="$newG"/>
		</FieldTypeId>
		<xsl:choose>
			<xsl:when test="count(exsl:node-set($dataTypes)/DataType[./controlId = $g])">
				<PreValues>
					<xsl:for-each select="exsl:node-set($dataTypes)/DataType[./controlId = $g]">
						<PreValue>
							<Field>00000000-0000-0000-0000-000000000000</Field>
							<Value>
								<xsl:value-of select="./PreValues/PreValue"/>
							</Value>
							<SortOrder>0</SortOrder>
						</PreValue>
					</xsl:for-each>
				</PreValues>
			</xsl:when>
			<xsl:otherwise>
				<PreValues/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	
	
	
	-->
	<xsl:template name="getCourierGUUIDS">
		<xsl:param name="docTypeFieldGUUID"/>
		<xsl:choose>
			<!---1	
			
			
			023F09AC-1445-4BCB-B8FA-AB49F33BD046	Textarea-->
			<xsl:when test="$docTypeFieldGUUID  = '67DB8357-EF57-493E-91AC-936D305E0F2A'">
				<xsl:value-of select="'023F09AC-1445-4BCB-B8FA-AB49F33BD046'"/>
			</xsl:when>			
			<!---2	
			
			
			0DD29D42-A6A5-11DE-A2F2-222256D89593	DropDownList-->
			<xsl:when test="$docTypeFieldGUUID  = 'A74EA9C9-8E18-4D2A-8CF6-73C6206C5DA6'">
				<xsl:value-of select="'0DD29D42-A6A5-11DE-A2F2-222256D89593'"/>
			</xsl:when>			
			<!---3	
			
			
			3F92E01B-29E2-4A30-BF33-9DF5580ED52C	TextField-->
			<xsl:when test="$docTypeFieldGUUID  = 'EC15C1E5-9D90-422A-AA52-4F7622C63BEA'">
				<xsl:value-of select="'3F92E01B-29E2-4A30-BF33-9DF5580ED52C'"/>
			</xsl:when>			

			<!---4	
			
			
			84A17CF8-B711-46A6-9840-0E4A072AD000	File upload-->
			<xsl:when test="$docTypeFieldGUUID  = 'EC15C1E5-9D90-422A-AA52-4F7622C63BEA'">
				<xsl:value-of select="'84A17CF8-B711-46A6-9840-0E4A072AD000'"/>
			</xsl:when>			
			<!---5	
			
			
			903DF9B0-A78C-11DE-9FC1-DB7A56D89593	RadioButton List-->
			<xsl:when test="$docTypeFieldGUUID  = 'A52C7C1C-C330-476E-8605-D63D3B84B6A6'">
				<xsl:value-of select="'903DF9B0-A78C-11DE-9FC1-DB7A56D89593'"/>
			</xsl:when>			
			<!---6	
			
			
			D5C0C390-AE9A-11DE-A69E-666455D89593	CheckBox-->
			<xsl:when test="$docTypeFieldGUUID  = 'B4471851-82B6-4C75-AFA4-39FA9C6A75E9'">
				<xsl:value-of select="'D5C0C390-AE9A-11DE-A69E-666455D89593'"/>
			</xsl:when>			
			<!---7	
			
			
			F8B4C3B8-AF28-11DE-9DD8-EF5956D89593	DatePicker-->
			<xsl:when test="$docTypeFieldGUUID  = '23E93522-3200-44E2-9F29-E61A6FCBB79A'">
				<xsl:value-of select="'F8B4C3B8-AF28-11DE-9DD8-EF5956D89593'"/>
			</xsl:when>			
			<xsl:when test="$docTypeFieldGUUID  = 'B6FB1622-AFA5-4BBF-A3CC-D9672A442222'">
				<xsl:value-of select="'F8B4C3B8-AF28-11DE-9DD8-EF5956D89593'"/>
			</xsl:when>			

			<!---8	
			
			
			FAB43F20-A6BF-11DE-A28F-9B5755D89593	CheckBoxList-->
			<xsl:when test="$docTypeFieldGUUID  = 'B4471851-82B6-4C75-AFA4-39FA9C6A75E9'">
				<xsl:value-of select="'FAB43F20-A6BF-11DE-A28F-9B5755D89593'"/>
			</xsl:when>
			<!---9	
			
			
				Hidden-->
			<xsl:when test="$docTypeFieldGUUID  = '6C738306-4C17-4D88-B9BD-6546F3771597'">
				<xsl:value-of select="'DA206CAE-1C52-434E-B21A-4A7C198AF877'"/>
			</xsl:when>
			<!---10	
			
			
				Boolean to Checkbox-->
			<xsl:when test="$docTypeFieldGUUID  = '38B352C1-E9F8-4FD8-9324-9A2EAB06D97A'">
				<xsl:value-of select="'D5C0C390-AE9A-11DE-A69E-666455D89593'"/>
			</xsl:when>
			<!-- 11
			
			
			Multi page picker-->
			<xsl:when test="$docTypeFieldGUUID  = 'F8695284-CF23-4EA2-B911-46503C14AA32'">
				<xsl:value-of select="'3F92E01B-29E2-4A30-BF33-9DF5580ED52C'"/>
			</xsl:when>
			<!-- 12
			
			
			Upload-->
			<xsl:when test="$docTypeFieldGUUID  = '5032A6E6-69E3-491D-BB28-CD31CD11086C'">
				<xsl:value-of select="'84A17CF8-B711-46A6-9840-0E4A072AD000'"/>
			</xsl:when>
			<!-- 13


			Number-->
			<xsl:when test="$docTypeFieldGUUID  = '1413AFCB-D19A-4173-8E9A-68288D2A73B8'">
				<xsl:value-of select="'3F92E01B-29E2-4A30-BF33-9DF5580ED52C'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:comment>No GUUID FOUND for <xsl:value-of select="$docTypeFieldGUUID"/></xsl:comment>
				00000000-0000-0000-0000-000000000000
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>
	<!--
1	023F09AC-1445-4BCB-B8FA-AB49F33BD046	Textarea
2	0DD29D42-A6A5-11DE-A2F2-222256D89593	DropDownList
3	3F92E01B-29E2-4A30-BF33-9DF5580ED52C	TextField
4	84A17CF8-B711-46A6-9840-0E4A072AD000	File upload
5	903DF9B0-A78C-11DE-9FC1-DB7A56D89593	RadioButton List
6	D5C0C390-AE9A-11DE-A69E-666455D89593	CheckBox
7	F8B4C3B8-AF28-11DE-9DD8-EF5956D89593	DatePicker
8	FAB43F20-A6BF-11DE-A28F-9B5755D89593	CheckBoxList
	-->
</xsl:stylesheet>
