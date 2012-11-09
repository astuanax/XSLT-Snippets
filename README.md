XSLT-Snippets
=============

- convert2contour.xsl

  Convert exported document types to Contour templates.

  - guuids.xsl

    An XSLT 1 native generator of 128 bit GUUID's using a Lagged Fibonaccipseudo-random number 
    generator and someother templates copy-pasted together from the internet.

    Need to work on this but, its a start

    Don't use this in production, unless time isn't an issue. 
    It takes quite some time to process the initial seed values for the LFG

- datatypes.xml and datatypes.xsl

    XSLT to transform the GUIDs from the Doc2Form Document types into a Courier form
