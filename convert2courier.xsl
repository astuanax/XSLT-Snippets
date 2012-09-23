<?xml version="1.0" encoding="UTF-8"?>
<!--
	Convert Document Types to Courier templates
	Comes in handy when upgrading from Doc2Form to Courier
	Created by Len Dierickx on 2012-05-08.
	Copyright (c) 2012 __Len Dierickx__. All rights reserved.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" xmlns:math="http://exslt.org/math" xmlns:exsl="http://exslt.org/common" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0" extension-element-prefixes="date math">
	<xsl:import href="/Users/lendierickx/Dropbox-Len/Dropbox/Contour/guids.xsl"/>
	<xsl:import href="/Users/lendierickx/Dropbox-Len/Dropbox/Contour/datatypes.xsl"/>
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:variable name="formGUID">
		<xsl:call-template name="guuids">
			<xsl:with-param name="nr" select="3"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:template match="/">
		<Form xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			<xsl:comment> xmlns="UmbracoContour"&gt; </xsl:comment>
			<Name>
				<xsl:value-of select="DocumentType/Info/Name"/>
			</Name>
			<Created>
				<xsl:value-of select="date:date-time()"/>
			</Created>
			<FieldIndicationType>NoIndicator</FieldIndicationType>
			<Indicator/>
			<ShowValidationSummary>false</ShowValidationSummary>
			<HideFieldValidation>false</HideFieldValidation>
			<RequiredErrorMessage>{0} is mandatory</RequiredErrorMessage>
			<InvalidErrorMessage>{0} is not valid</InvalidErrorMessage>
			<MessageOnSubmit>Thank you</MessageOnSubmit>
			<GoToPageOnSubmit>0</GoToPageOnSubmit>
			<ManualApproval>false</ManualApproval>
			<Archived>false</Archived>
			<StoreRecordsLocally>true</StoreRecordsLocally>
			<DisableDefaultStylesheet>true</DisableDefaultStylesheet>
			<Pages>
				<Page>
					<FieldSets>
						<FieldSet>
							<Fields>
								<xsl:for-each select="DocumentType/GenericProperties/GenericProperty">
									<xsl:sort select="position()" data-type="number" order="ascending"/>
									<Field>
										<!--<PreValues/>-->
										<Caption>
											<xsl:value-of select="Name"/>
										</Caption>
										<ToolTip>
											<xsl:value-of select="Description"/>
										</ToolTip>
										<SortOrder>0</SortOrder>
										<PageIndex>0</PageIndex>
										<FieldsetIndex>0</FieldsetIndex>
										<Id>00000000-0000-0000-0000-000000000000</Id>
										<FieldSet>
											<xsl:value-of select="exsl:node-set($formGUID)/guuids/guuid[1]"/>
										</FieldSet>
										<xsl:call-template name="getDataType">
											<xsl:with-param name="g" select="Type"/>
										</xsl:call-template>
										<Form>
											<xsl:value-of select="exsl:node-set($formGUID)/guuids/guuid[2]"/>
										</Form>
										<!-- <FieldTypeId>
											<xsl:call-template name="getCourierGUUIDS">
												<xsl:with-param name="docTypeFieldGUUID" select="Type"/>
											</xsl:call-template>
										</FieldTypeId> -->
										<Mandatory>
											<xsl:value-of select="translate(./Mandatory,'TF','tf')"/>
										</Mandatory>
										<RegEx>
											<xsl:value-of select="Validation"/>
										</RegEx>
										<RequiredErrorMessage/>
										<InvalidErrorMessage/>
										<PreValueSourceId>00000000-0000-0000-0000-000000000000</PreValueSourceId>
										<Settings/>
									</Field>
								</xsl:for-each>
							</Fields>
							<Caption>
								<xsl:value-of select="DocumentType/Info/Name"/>
							</Caption>
							<SortOrder>0</SortOrder>
							<Id>00000000-0000-0000-0000-000000000000</Id>
							<Page>
								<xsl:value-of select="exsl:node-set($formGUID)/guuids/guuid[3]"/>
							</Page>
						</FieldSet>
					</FieldSets>
					<Caption/>
					<SortOrder>0</SortOrder>
					<Id>00000000-0000-0000-0000-000000000000</Id>
					<Form>
						<xsl:value-of select="exsl:node-set($formGUID)/guuids/guuid[2]"/>
					</Form>
				</Page>
			</Pages>
			<DataSource>00000000-0000-0000-0000-000000000000</DataSource>
			<Id>
				<xsl:value-of select="exsl:node-set($formGUID)/guuids/guuid[2]"/>
			</Id>
		</Form>
	</xsl:template>
</xsl:stylesheet>
