<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
  <xsl:template match="node()|@*">
     <xsl:copy>
       <xsl:apply-templates select="node()|@*"/>
     </xsl:copy>
  </xsl:template>

  <xsl:template match="/domain/devices">
  <xsl:copy>
  <xsl:apply-templates select="node()|@*"/>
    <xsl:element name="hostdev0">
      <xsl:attribute name="mode">subsystem</xsl:attribute>
      <xsl:attribute name="type">pci</xsl:attribute>
      <xsl:attribute name="managed">yes</xsl:attribute>
      <xsl:element name="driver">
        <xsl:attribute name="name">vfio</xsl:attribute>
      </xsl:element>
      <xsl:element name="source">
        <xsl:element name="address">
          <xsl:attribute name="domain">0x0000</xsl:attribute>
          <xsl:attribute name="bus">0x01</xsl:attribute>
          <xsl:attribute name="slot">0x00</xsl:attribute>
          <xsl:attribute name="function">0x0</xsl:attribute>
        </xsl:element>
      </xsl:element>
      <xsl:element name="alias">
        <xsl:attribute name="name">hostdev0</xsl:attribute>
      </xsl:element>
      <xsl:element name="address">
        <xsl:attribute name="type">pci</xsl:attribute>
        <xsl:attribute name="domain">0x0000</xsl:attribute>
        <xsl:attribute name="bus">0x00</xsl:attribute>
        <xsl:attribute name="slot">0x08</xsl:attribute>
        <xsl:attribute name="function">0x0</xsl:attribute>
      </xsl:element>
    </xsl:element>
    <xsl:element name="hostdev1">
      <xsl:attribute name="mode">subsystem</xsl:attribute>
      <xsl:attribute name="type">pci</xsl:attribute>
      <xsl:attribute name="managed">yes</xsl:attribute>
      <xsl:element name="driver">
        <xsl:attribute name="name">vfio</xsl:attribute>
      </xsl:element>
      <xsl:element name="source">
        <xsl:element name="address">
          <xsl:attribute name="domain">0x0000</xsl:attribute>
          <xsl:attribute name="bus">0x01</xsl:attribute>
          <xsl:attribute name="slot">0x00</xsl:attribute>
          <xsl:attribute name="function">0x1</xsl:attribute>
        </xsl:element>
      </xsl:element>
      <xsl:element name="alias">
        <xsl:attribute name="name">hostdev1</xsl:attribute>
      </xsl:element>
      <xsl:element name="address">
        <xsl:attribute name="type">pci</xsl:attribute>
        <xsl:attribute name="domain">0x0000</xsl:attribute>
        <xsl:attribute name="bus">0x00</xsl:attribute>
        <xsl:attribute name="slot">0x09</xsl:attribute>
        <xsl:attribute name="function">0x0</xsl:attribute>
      </xsl:element>
    </xsl:element>
    <xsl:element name="hostdev2">
      <xsl:attribute name="mode">subsystem</xsl:attribute>
      <xsl:attribute name="type">pci</xsl:attribute>
      <xsl:attribute name="managed">yes</xsl:attribute>
      <xsl:element name="driver">
        <xsl:attribute name="name">vfio</xsl:attribute>
      </xsl:element>
      <xsl:element name="source">
        <xsl:element name="address">
          <xsl:attribute name="domain">0x0000</xsl:attribute>
          <xsl:attribute name="bus">0x01</xsl:attribute>
          <xsl:attribute name="slot">0x00</xsl:attribute>
          <xsl:attribute name="function">0x2</xsl:attribute>
        </xsl:element>
      </xsl:element>
      <xsl:element name="alias">
        <xsl:attribute name="name">hostdev2</xsl:attribute>
      </xsl:element>
      <xsl:element name="address">
        <xsl:attribute name="type">pci</xsl:attribute>
        <xsl:attribute name="domain">0x0000</xsl:attribute>
        <xsl:attribute name="bus">0x00</xsl:attribute>
        <xsl:attribute name="slot">0x0a</xsl:attribute>
        <xsl:attribute name="function">0x0</xsl:attribute>
      </xsl:element>
    </xsl:element>
    <xsl:element name="hostdev3">
      <xsl:attribute name="mode">subsystem</xsl:attribute>
      <xsl:attribute name="type">pci</xsl:attribute>
      <xsl:attribute name="managed">yes</xsl:attribute>
      <xsl:element name="driver">
        <xsl:attribute name="name">vfio</xsl:attribute>
      </xsl:element>
      <xsl:element name="source">
        <xsl:element name="address">
          <xsl:attribute name="domain">0x0000</xsl:attribute>
          <xsl:attribute name="bus">0x01</xsl:attribute>
          <xsl:attribute name="slot">0x00</xsl:attribute>
          <xsl:attribute name="function">0x3</xsl:attribute>
        </xsl:element>
      </xsl:element>
      <xsl:element name="alias">
        <xsl:attribute name="name">hostdev3</xsl:attribute>
      </xsl:element>
      <xsl:element name="address">
        <xsl:attribute name="type">pci</xsl:attribute>
        <xsl:attribute name="domain">0x0000</xsl:attribute>
        <xsl:attribute name="bus">0x00</xsl:attribute>
        <xsl:attribute name="slot">0x0b</xsl:attribute>
        <xsl:attribute name="function">0x0</xsl:attribute>
      </xsl:element>
    </xsl:element>
  </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
