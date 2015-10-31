[#ftl]
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<targetDefinitions xmlns="http://openstm32.org/stm32TargetDefinitions" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://openstm32.org/stm32TargetDefinitions stm32TargetDefinitions.xsd">
  <board id="${board}">
    <name>${board}</name>
    <mcuId>${device}</mcuId>  <!-- mcu-->
    <dbgIF>${DebugMode}</dbgIF>
    <dbgDEV>ST-LinkV2-1</dbgDEV>
  </board>
</targetDefinitions>