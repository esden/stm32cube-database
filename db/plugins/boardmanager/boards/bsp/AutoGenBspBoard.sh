#!/bin/bash
# Initialize variabless
Board=""
FW=""
Path=""
Led_Numbers=""
Led_Pins=""
Button_Names=""
Button_Ports=""
VCP_Number=""
VCP_TX_Port=""
VCP_RX_Port=""

BspIpLibMethode=""
TrustZoneEnable=""



# Parse arguments
while [ "$#" -gt 0 ]; do
	case "$1" in
		-Board)
			Board="$2"
			shift 2
			;;
		-FW)
			FW="$2"
			shift 2
			;;
		-Path)
			Path="$2"
			shift 2
			;;
		-Led_Numbers)
			Led_Numbers="$2"
			shift 2
			;;
		-Led_Pins)
			Led_Pins="$2"
			shift 2
			;;
		-Led_Colors)
			Led_Colors="$2"
			shift 2
			;;
		-Button_Names)
			Button_Names="$2"
			shift 2
			;;
		-Button_Ports)
			Button_Ports="$2"
			shift 2
			;;
		-VCP_Number)
			VCP_Number="$2"
			shift 2
			;;
		-VCP_TX_Port)
			VCP_TX_Port="$2"
			shift 2
			;;
		-VCP_RX_Port)
			VCP_RX_Port="$2"
			shift 2
			;;
	  -BspIpLibMethode)
      BspIpLibMethode="$2"
      shift 2
      ;;
    -TrustZoneEnable)
      TrustZoneEnable="$2"
      shift 2
      ;;
		*)
			echo -e "$(tput setaf 1)Unknown option: \n$1$(tput sgr0)"
			usage
			;;
	esac
done

# Function to display usage information
usage() {
    echo -e "\nUsage: $0 -Board <value> -FW <value> -Path <specific location> -Led_Numbers <value,value ..> -Led_Pins <GPIOA1,GPIOB2 ..> -Led_Colors <value,value ..> -Button_Names <value,value ..> -Button_Ports <GPIOC13,GPIOB2 ..> -VCP_Number <value> -VCP_TX_Port <value> -VCP_RX_Port <value> BspIpLibMethode <value exp: \"BSP_PB_IRQHandler(BUTTON_SW1)\"> -TrustZoneEnable <true or false>"
    exit 1
}

# Function to check if all arguments are provided
check_Arguments() {
	if [ -z "$Board" ] ||[ -z "$FW" ]  || [ -z "$Led_Numbers" ] || [ -z "$Led_Colors" ] || [ -z "$Led_Pins" ] || [ -z "$Button_Names" ] || [ -z "$Button_Ports" ] || [ -z "$VCP_Number" ] || [ -z "$VCP_TX_Port" ] || [ -z "$VCP_RX_Port" ] ; then
		echo "Missing arguments!"
		usage
	fi
}

#------------------------------------------------------------------------------------------------------

# Function to get Led datas
split_LED_Data(){
	Arry_Led_Numbers=($(echo $Led_Numbers | sed 's/\,/\n/g'))
	Arry_Led_Pins=($(echo $Led_Pins | sed 's/\,/\n/g'))
	Arry_Led_Colors=($(echo $Led_Colors | sed 's/\,/\n/g'))
	for i in $( seq 0 "$((${#Arry_Led_Numbers[@]} - 1 ))")
	do
		ports=($(echo ${Arry_Led_Pins[$i]} | sed 's/\-/\n/g'))
		case ${Arry_Led_Numbers[$i]} in
			1)
			LD1="true";
			LD1_Port=${ports[0]};
			LD1_Number=${ports[1]};
			LD1_Color=${Arry_Led_Colors[$i]};
			echo -e "\t-$(tput setaf 5)LED$(tput sgr0)(1): $(tput sgr0)GPIO$(tput setaf 2)$LD1_Port$LD1_Number-$(tput setaf 3)$LD1_Color$(tput sgr0)";
			;;
			2)
			LD2="true";
			LD2_Port=${ports[0]};
			LD2_Number=${ports[1]};
			LD2_Color=${Arry_Led_Colors[$i]};
			echo -e "\t-$(tput setaf 5)LED$(tput sgr0)(2): $(tput sgr0)GPIO$(tput setaf 2)$LD2_Port$LD2_Number-$(tput setaf 3)$LD2_Color$(tput sgr0)";
			;;
			3)
			LD3="true";
			LD3_Port=${ports[0]};
			LD3_Number=${ports[1]};
			LD3_Color=${Arry_Led_Colors[$i]};
			echo -e "\t-$(tput setaf 5)LED$(tput sgr0)(3): $(tput sgr0)GPIO$(tput setaf 2)$LD3_Port$LD3_Number-$(tput setaf 3)$LD3_Color$(tput sgr0)";
			;;
			4)
			LD4="true";
			LD4_Port=${ports[0]};
			LD4_Number=${ports[1]};
			LD4_Color=${Arry_Led_Colors[$i]};
			echo -e "\t-$(tput setaf 5)LED$(tput sgr0)(4): $(tput sgr0)GPIO$(tput setaf 2)$LD4_Port$LD4_Number-$(tput setaf 3)$LD4_Color$(tput sgr0)";
			;;
		esac
		
	done ;
}



# Function to get Button datas
split_Button_Data(){
	Arry_Button_Names=($(echo $Button_Names | sed 's/\,/\n/g'))
	Arry_Button_Ports=($(echo $Button_Ports | sed 's/\,/\n/g'))

	for i in  $( seq 0 "$((${#Arry_Button_Names[@]} - 1 ))")
	do
		data=($(echo ${Arry_Button_Ports[$i]} | sed 's/\-/\n/g'))
		if [ "${#Arry_Button_Names[@]}" == 1 ];then
		  username="BUTTON_USER"
		  else
		  username=${Arry_Button_Names[$i]}
		fi
		case ${i} in
			0)
			Button="true";
			button_name="${Arry_Button_Names[$i]}"
			Button_Port=${data[0]};
			Button_Number=${data[1]};
			Button_UserName=$username;
			echo -e "\t-$(tput setaf 5)Button 1$(tput sgr0)( $button_name ): $(tput sgr0)GPIO$(tput setaf 2)$Button_Port$Button_Number";
			;;
			1)
			Button2="true";
			button2_name="${Arry_Button_Names[$i]}"
			Button2_Port=${data[0]};
			Button2_Number=${data[1]};
			Button2_UserName=$username;
			echo -e "\t-$(tput setaf 5)Button 2$(tput sgr0)( $button2_name ): $(tput sgr0)GPIO$(tput setaf 2)$Button2_Port$Button2_Number";
			;;
			2)
			Button3="true";
			button3_name="${Arry_Button_Names[$i]}"
			Button3_Port=${data[0]};
			Button3_Number=${data[1]};
			Button3_UserName=$username;
			echo -e "\t-$(tput setaf 5)Button 3$(tput sgr0)( $button3_name ): $(tput sgr0)GPIO$(tput setaf 2)$Button3_Port$Button3_Number";
			;;
			3)
			Button4="true";
			button4_name="${Arry_Button_Names[$i]}"
			Button4_Port=${data[0]};
			Button4_Number=${data[1]};
			Button4_UserName=$username;
			echo -e "\t-$(tput setaf 5)Button 4$(tput sgr0)( $button4_name ): $(tput sgr0)GPIO$(tput setaf 2)$Button4_Port$Button4_Number";
			;;
		esac
	done ;
	tput sgr0
}

# Function to get Virtual com port  datas
split_VCP_Data(){
	Board_Name=$Board
	Arry_VCP_TX=($(echo $VCP_TX_Port | sed 's/\-/\n/g'))
	Arry_VCP_RX=($(echo $VCP_RX_Port | sed 's/\-/\n/g'))
	VCP=true;
	USART_Number=$VCP_Number
	TX_Port=${Arry_VCP_TX[0]};
	TX_Number=${Arry_VCP_TX[1]};
	RX_Port=${Arry_VCP_RX[0]};
	RX_Number=${Arry_VCP_RX[1]};
    echo -e "\n\t-$(tput setaf 5)VCP$(tput sgr0):$(tput setaf 6) $USART_Number$(tput sgr0) -TX: GPIO$(tput setaf 2)$TX_Port$TX_Number$(tput sgr0) -RX: GPIO$(tput setaf 2)$RX_Port$RX_Number" 

	tput sgr0
}

# Function to provided arguments
Collect_Data(){
  DB_Path=microxplorer/src/main/resources/db
  bspPlugins_Path=plugins/boardmanager/boards/bsp
  ftl_Path=templates/bsp
  if [ -z "$Path" ];then
    cd ./../../../../../../../../../
   Path=$(pwd);
  else
    echo -e "\n$(tput sgr0)Create new specific folder under :$(tput setaf 5) $Path/$(tput setaf 6)$DB_Path"
    mkdir -p $Path/$DB_Path/$bspPlugins_Path
  fi

  home_Path=$Path

  if [ -z "$TrustZoneEnable" ];then
    TrustZoneEnable=false;
  fi
  if [ -z "$BspIpLibMethode" ];then
    BspIpLibMethode="BSP_PB_IRQHandler"
  fi

	echo -e "\n\t\t\t $(tput setaf 2)-----Info------\n"
	echo -e "\t-$(tput setaf 5)Board Name$(tput sgr0): NUCLEO-$Board"
	echo -e "\t-$(tput setaf 5)FW$(tput sgr0): $FW$(echo "xx_HAL_Driver")"
	echo -e "\t-$(tput setaf 5)Path$(tput sgr0): $Path\n"
	split_LED_Data
  split_Button_Data
	split_VCP_Data
	 echo -e "\n\t-$(tput setaf 5)BspIpLibMethode$(tput sgr0): $BspIpLibMethode\n"
   echo -e "\t-$(tput setaf 5)TrustZoneEnable$(tput sgr0): $TrustZoneEnable\n"


	echo -e "\n\t\t\t $(tput setaf 2)---------------\n"
	tput sgr0

}



#------------------------------------------------------------------------------------------------

# Function to generate NUCLEO-BoardName_Modes.xml
generate_Mode_file() {
	echo  "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>
<IP DBVersion=\"V4.0\"
	IPType=\"bspip\"
	Name=\"NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )\"
	Version=\"nucleo-$( echo "$Board_Name" | tr '[:upper:]' '[:lower:]')_v1_0_Cube\"
	xmlns:ns0=\"http://www.w3.org/2001/XMLSchema-instance\"
	ns0:schemaLocation=\"http://mcd.rou.st.com/modules.php?name=mcu ../../../../../../../doc/V4/Development/Specifications/db/IP_Modes.xsd\"
	xmlns=\"http://mcd.rou.st.com/modules.php?name=mcu\">

	<About>BSP for NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )</About>
	<!-- BSP COMMON -->
	$( if [ "$LD1" = true ] ; then
	echo "<RefParameter Name=\"LD1\" Comment=\"USER LED $( echo "$LD1_Color" | tr '[:lower:]' '[:upper:]' ) (LD1)\" DefaultValue=\"false\" Type=\"boolean\" Group=\"Led\" TabName=\"Human Machine Interface\">
		<PossibleValue Comment=\"true\" Value=\"true\" Semaphore=\"S_LED_$( echo "$LD1_Color" | tr '[:lower:]' '[:upper:]' )\"/>
		<PossibleValue Comment=\"false\" Value=\"false\"/>
		<Description>Pin P$LD1_Port$LD1_Number is used to drive the user $( echo "$LD1_Color" | tr '[:upper:]' '[:lower:]' ) Led</Description>
	</RefParameter> "
	fi )
	$( if [ "$LD2" = true ] ; then
	echo "<RefParameter Name=\"LD2\" Comment=\"USER LED $( echo "$LD2_Color" | tr '[:lower:]' '[:upper:]' ) (LD2)\" DefaultValue=\"false\" Type=\"boolean\" Group=\"Led\" TabName=\"Human Machine Interface\">
		<PossibleValue Comment=\"true\" Value=\"true\" Semaphore=\"S_LED_$( echo "$LD2_Color" | tr '[:lower:]' '[:upper:]' )\"/>
		<PossibleValue Comment=\"false\" Value=\"false\"/>
		<Description>Pin P$LD2_Port$LD2_Number is used to drive the user $( echo "$LD2_Color" | tr '[:upper:]' '[:lower:]' ) Led</Description>
	</RefParameter> "
	fi )
	$( if [ "$LD3" = true ] ; then
	echo "<RefParameter Name=\"LD3\" Comment=\"USER LED $( echo "$LD3_Color" | tr '[:lower:]' '[:upper:]' ) (LD3)\" DefaultValue=\"false\" Type=\"boolean\" Group=\"Led\" TabName=\"Human Machine Interface\">
		<PossibleValue Comment=\"true\" Value=\"true\" Semaphore=\"S_LED_$( echo "$LD3_Color" | tr '[:lower:]' '[:upper:]' )\"/>
		<PossibleValue Comment=\"false\" Value=\"false\"/>
		<Description>Pin P$LD3_Port$LD3_Number is used to drive the user $( echo "$LD3_Color" | tr '[:upper:]' '[:lower:]' ) Led</Description>
	</RefParameter> "
	fi )
	$( if [ "$LD4" = true ] ; then
	echo "<RefParameter Name=\"LD4\" Comment=\"USER LED $( echo "$LD4_Color" | tr '[:lower:]' '[:upper:]' ) (LD4)\" DefaultValue=\"false\" Type=\"boolean\" Group=\"Led\" TabName=\"Human Machine Interface\">
		<PossibleValue Comment=\"true\" Value=\"true\" Semaphore=\"S_LED_$( echo "$LD4_Color" | tr '[:lower:]' '[:upper:]' )\"/>
		<PossibleValue Comment=\"false\" Value=\"false\"/>
		<Description>Pin P$LD4_Port$LD4_Number is used to drive the user $( echo "$LD4_Color" | tr '[:upper:]' '[:lower:]' ) Led</Description>
	</RefParameter> "
	fi )
	$( if [ "$Button" = true ] ; then
	echo "<RefParameter Name=\"BUTTON\" Comment=\"USER $button_name\" DefaultValue=\"0\" Type=\"list\" Group=\"Button\" TabName=\"Human Machine Interface\">
		<PossibleValue Comment=\"Mode GPIO\" Value=\"2\" Semaphore=\"S_USER_BUTTON_POLL\"/>
		<PossibleValue Comment=\"Mode EXTI\" Value=\"1\" Semaphore=\"S_USER_BUTTON_EXTI\"/>
		<PossibleValue Comment=\"Disable\" Value=\"0\"/>
		<Description>Pin P$Button_Port$Button_Number is used to detect press/release on the user button. This detection could be made by polling or under interrupt</Description>
	</RefParameter>"
	fi )
	$( if [ "$Button2" = true ] ; then
	echo "<RefParameter Name=\"BUTTON2\" Comment=\"USER $button2_name\" DefaultValue=\"0\" Type=\"list\" Group=\"Button\" TabName=\"Human Machine Interface\">
		<PossibleValue Comment=\"Mode GPIO\" Value=\"2\" Semaphore=\"S_USER_BUTTON2_POLL\"/>
		<PossibleValue Comment=\"Mode EXTI\" Value=\"1\" Semaphore=\"S_USER_BUTTON2_EXTI\"/>
		<PossibleValue Comment=\"Disable\" Value=\"0\"/>
		<Description>Pin P$Button2_Port$Button2_Number is used to detect press/release on the user button. This detection could be made by polling or under interrupt</Description>
	</RefParameter>"
	fi )
	$( if [ "$Button3" = true ] ; then
	echo "<RefParameter Name=\"BUTTON3\" Comment=\"USER $button3_name\" DefaultValue=\"0\" Type=\"list\" Group=\"Button\" TabName=\"Human Machine Interface\">
		<PossibleValue Comment=\"Mode GPIO\" Value=\"2\" Semaphore=\"S_USER_BUTTON3_POLL\"/>
		<PossibleValue Comment=\"Mode EXTI\" Value=\"1\" Semaphore=\"S_USER_BUTTON3_EXTI\"/>
		<PossibleValue Comment=\"Disable\" Value=\"0\"/>
		<Description>Pin P$Button3_Port$Button3_Number is used to detect press/release on the user button. This detection could be made by polling or under interrupt</Description>
	</RefParameter>"
	fi )
	$( if [ "$Button4" = true ] ; then
	echo "<RefParameter Name=\"BUTTON4\" Comment=\"USER $button4_name\" DefaultValue=\"0\" Type=\"list\" Group=\"Button\" TabName=\"Human Machine Interface\">
		<PossibleValue Comment=\"Mode GPIO\" Value=\"2\" Semaphore=\"S_USER_BUTTON4_POLL\"/>
		<PossibleValue Comment=\"Mode EXTI\" Value=\"1\" Semaphore=\"S_USER_BUTTON4_EXTI\"/>
		<PossibleValue Comment=\"Disable\" Value=\"0\"/>
		<Description>Pin P$Button4_Port$Button4_Number is used to detect press/release on the user button. This detection could be made by polling or under interrupt</Description>
	</RefParameter>"
	fi )
	
	$( if [ "$VCP" = true ] ; then
	echo "<RefParameter Name=\"VCP\" Comment=\"Virtual Com Port\" DefaultValue=\"false\" Type=\"boolean\" Group=\"VCOM\" TabName=\"Human Machine Interface\">
		<PossibleValue Comment=\"true\" Value=\"true\" Semaphore=\"S_VCOM\"/>
		<PossibleValue Comment=\"false\" Value=\"false\"/>
		<Description>
			Peripheral $USART_Number (Pin P$TX_Port$TX_Number, P$RX_Port$RX_Number) is used to send trace through the ST-Link &lt;br/&gt;
			- Baud rate     : 115200          &lt;br/&gt;
			- Data          : 8 bit           &lt;br/&gt;
			- Parity        : none            &lt;br/&gt;
			- Stop          : 1 bit          &lt;br/&gt;
			- Flow control  : No hardware control        &lt;br/&gt;

		</Description>
	</RefParameter>"
	fi )

	<!-- Demo code genaration: Bsp_Common_DEMO is set by the wizard.
	if Bsp_Common_DEMO = true, applicative code is generated for the enabled features. -->
	<RefParameter Name=\"Bsp_Common_DEMO\" Comment=\"Generate demonstration code\" DefaultValue=\"false\" Type=\"boolean\" Group=\"Demonstration\" TabName=\"Human Machine Interface\" Visible=\"false\">
			<PossibleValue Comment=\"true\" Value=\"true\" Semaphore=\"SEM_Common_DEMO_ON\"/>
			<PossibleValue Comment=\"false\" Value=\"false\"/>
			<Description>Generate demonstration code for selected BSP Common features.&lt;br/&gt;
		&lt;font color=&quot;blue&quot;&gt;&lt;b&gt;@note&lt;/b&gt;This parameter is configurable only at project creation in the board project wizard.
				&lt;br/&gt;Demonstration code is added only at 1st generation in user section and will not be updated in successive generations.&lt;/font&gt;
			</Description>
		</RefParameter>
	<RefParameter Name=\"Bsp_Common_DEMO_Enabled\" Comment=\"Generate demonstration code\" DefaultValue=\"Enabled\" Type=\"string\" Group=\"Demonstration code\" TabName=\"Human Machine Interface\" Visible=\"true\">
			<Condition Diagnostic=\"\" Expression=\"SEM_Common_DEMO_ON\"/>
			<Description>Generate demonstration code for selected BSP Common features.&lt;br/&gt;
		&lt;font color=&quot;blue&quot;&gt;&lt;b&gt;@note&lt;/b&gt;This parameter is configurable only at project creation in the board project wizard.
				&lt;br/&gt;Demonstration code is added only at 1st generation in user section and will not be updated in successive generations.&lt;/font&gt;
			</Description>
		</RefParameter>
	<RefParameter Name=\"Bsp_Common_DEMO_Enabled\" Comment=\"Generate demonstration code\" DefaultValue=\"Disabled\" Type=\"string\" Group=\"Demonstration code\" TabName=\"Human Machine Interface\" Visible=\"true\">
			<Condition Diagnostic=\"\" Expression=\"!SEM_Common_DEMO_ON\"/>
			<Description>Generate demonstration code for selected BSP Common features.&lt;br/&gt;
		&lt;font color=&quot;blue&quot;&gt;&lt;b&gt;@note&lt;/b&gt;This parameter is configurable only at project creation in the board project wizard.
				&lt;br/&gt;Demonstration code is added only at 1st generation in user section and will not be updated in successive generations.&lt;/font&gt;
			</Description>
		</RefParameter>

	<!-- Give the list of context to remove from current list of existing context -->
	<RefParameter Comment=\"ExcludedContext\" DefaultValue=\"\" Group=\"Current application region attributes\" Name=\"ExcludedContext\" Type=\"list\" Visible=\"false\">
		<PossibleValue Comment=\"ExtMemLoader\" Value=\"ExtMemLoader\"/>
	</RefParameter>

	<!-- Initializer context not needed -->
	<RefParameter Comment=\"NoInitContext\" DefaultValue=\"true\" Group=\"Current application region attributes\" Name=\"NoInitContext\" Type=\"boolean\" Visible=\"false\">
	</RefParameter>

	<RefMode Abstract=\"true\" Name=\"COMMON\" HalMode=\"\">
		$( if [ "$LD1" = true ] ; then
		echo "<Parameter Name=\"LD1\"/>" ;fi )
		$( if [ "$LD2" = true ] ; then
		echo "<Parameter Name=\"LD2\"/>" ;fi )
		$( if [ "$LD3" = true ] ; then
		echo "<Parameter Name=\"LD3\"/>" ;fi )
		$( if [ "$LD4" = true ] ; then
		echo "<Parameter Name=\"LD4\"/>" ;fi )
		$( if [ "$Button" = true ] ; then
		echo "<Parameter Name=\"BUTTON\"/>" ;fi )
		$( if [ "$Button2" = true ] ; then
		echo "<Parameter Name=\"BUTTON2\"/>" ;fi )
		$( if [ "$Button3" = true ] ; then
		echo "<Parameter Name=\"BUTTON3\"/>" ;fi )
		$( if [ "$Button4" = true ] ; then
		echo "<Parameter Name=\"BUTTON4\"/>" ;fi )
		$( if [ "$VCP" = true ] ; then
		echo "<Parameter Name=\"VCP\"/>" ;fi )
		<Parameter Name=\"Bsp_Common_DEMO\"/>
		<Parameter Name=\"Bsp_Common_DEMO_Enabled\"/>
		<Parameter Name=\"ExcludedContext\"/>
		<Parameter Name=\"NoInitContext\"/>
		$( if [ "$LD1" = true ] ; then
		echo "<BspDependency Name=\"LD1\" Comment=\"\" BspIpName=\"GPIO_$LD1_Port"_"$LD1_Number\" BspModeName=\"Reserved\" Api=\"\" GroupName=\"BSP\">
			<Condition Diagnostic=\"\" Expression=\"S_LED_$( echo "$LD1_Color" | tr '[:lower:]' '[:upper:]' )\"/>
		</BspDependency>" ;fi )
		$( if [ "$LD2" = true ] ; then
		echo "<BspDependency Name=\"LD2\" Comment=\"\" BspIpName=\"GPIO_$LD2_Port"_"$LD2_Number\" BspModeName=\"Reserved\" Api=\"\" GroupName=\"BSP\">
			<Condition Diagnostic=\"\" Expression=\"S_LED_$( echo "$LD2_Color" | tr '[:lower:]' '[:upper:]' )\"/>
		</BspDependency>" ;fi )
		$( if [ "$LD3" = true ] ; then
		echo "<BspDependency Name=\"LD3\" Comment=\"\" BspIpName=\"GPIO_$LD3_Port"_"$LD3_Number\" BspModeName=\"Reserved\" Api=\"\" GroupName=\"BSP\">
			<Condition Diagnostic=\"\" Expression=\"S_LED_$( echo "$LD3_Color" | tr '[:lower:]' '[:upper:]' )\"/>
		</BspDependency>" ;fi )
		$( if [ "$LD4" = true ] ; then
		echo "<BspDependency Name=\"LD4\" Comment=\"\" BspIpName=\"GPIO_$LD4_Port"_"$LD4_Number\" BspModeName=\"Reserved\" Api=\"\" GroupName=\"BSP\">
			<Condition Diagnostic=\"\" Expression=\"S_LED_$( echo "$LD4_Color" | tr '[:lower:]' '[:upper:]' )\"/>
		</BspDependency>" ;fi )
		$( if [ "$Button" = true ] ; then
		echo "<BspDependency Name=\"$button_name\" Comment=\"$BspIpLibMethode($Button_UserName)\" BspIpName=\"GPIO_$Button_Port"_"$Button_Number\" BspModeName=\"Reserved\" Api=\"HAL_EXTI_DRIVER\" GroupName=\"BSP\">
			<Condition Diagnostic=\"\" Expression=\"S_USER_BUTTON_EXTI\"/>
		</BspDependency>
		<BspDependency Name=\"BUTTON\" Comment=\"\" BspIpName=\"GPIO_$Button_Port"_"$Button_Number\" BspModeName=\"Reserved\" Api=\"\" GroupName=\"BSP\">
			<Condition Diagnostic=\"\" Expression=\"S_USER_BUTTON_POLL | S_USER_BUTTON_EXTI\"/>
		</BspDependency>" ;fi )
		$( if [ "$Button2" = true ] ; then
		echo "<BspDependency Name=\"$button2_name\" Comment=\"$BspIpLibMethode($Button2_UserName)\" BspIpName=\"GPIO_$Button2_Port"_"$Button2_Number\" BspModeName=\"Reserved\" Api=\"HAL_EXTI_DRIVER\" GroupName=\"BSP\">
			<Condition Diagnostic=\"\" Expression=\"S_USER_BUTTON2_EXTI\"/>
		</BspDependency>
		<BspDependency Name=\"BUTTON2\" Comment=\"\" BspIpName=\"GPIO_$Button2_Port"_"$Button2_Number\" BspModeName=\"Reserved\" Api=\"\" GroupName=\"BSP\">
			<Condition Diagnostic=\"\" Expression=\"S_USER_BUTTON2_POLL | S_USER_BUTTON2_EXTI\"/>
		</BspDependency>" ;fi )
		$( if [ "$Button3" = true ] ; then
		echo "<BspDependency Name=\"$button3_name\" Comment=\"$BspIpLibMethode($Button3_UserName)\" BspIpName=\"GPIO_$Button3_Port"_"$Button3_Number\" BspModeName=\"Reserved\" Api=\"HAL_EXTI_DRIVER\" GroupName=\"BSP\">
			<Condition Diagnostic=\"\" Expression=\"S_USER_BUTTON3_EXTI\"/>
		</BspDependency>
		<BspDependency Name=\"BUTTON3\" Comment=\"\" BspIpName=\"GPIO_$Button3_Port"_"$Button3_Number\" BspModeName=\"Reserved\" Api=\"\" GroupName=\"BSP\">
			<Condition Diagnostic=\"\" Expression=\"S_USER_BUTTON3_POLL | S_USER_BUTTON3_EXTI\"/>
		</BspDependency>" ;fi )
		$( if [ "$Button4" = true ] ; then
		echo "<BspDependency Name=\"$button4_name\" Comment=\"$BspIpLibMethode($Button4_UserName)\" BspIpName=\"GPIO_$Button4_Port"_"$Button4_Number\" BspModeName=\"Reserved\" Api=\"HAL_EXTI_DRIVER\" GroupName=\"BSP\">
			<Condition Diagnostic=\"\" Expression=\"S_USER_BUTTON4_EXTI\"/>
		</BspDependency>
		<BspDependency Name=\"BUTTON4\" Comment=\"\" BspIpName=\"GPIO_$Button4_Port"_"$Button4_Number\" BspModeName=\"Reserved\" Api=\"\" GroupName=\"BSP\">
			<Condition Diagnostic=\"\" Expression=\"S_USER_BUTTON4_POLL | S_USER_BUTTON4_EXTI\"/>
		</BspDependency>" ;fi )
		$( if [ "$VCP" = true ] ; then
		echo "<BspDependency Name=\"VCP\" Comment=\"Use an USART or a LPUART for this application\" BspIpName=\"$USART_Number\" BspModeName=\"\" Api=\"\" GroupName=\"BSP\">
			<Condition Diagnostic=\"\" Expression=\"S_VCOM\"/>
		</BspDependency> 
		<BspDependency Name=\"VCP_TX\" Comment=\"Use an USART or a LPUART for this application\" BspIpName=\"GPIO_$TX_Port"_"$TX_Number\" BspModeName=\"Reserved\" Api=\"\" GroupName=\"BSP\">
			<Condition Diagnostic=\"\" Expression=\"S_VCOM\"/>
		</BspDependency>
		<BspDependency Name=\"VCP_RX\" Comment=\"Use an USART or a LPUART for this application\" BspIpName=\"GPIO_$RX_Port"_"$RX_Number\" BspModeName=\"Reserved\" Api=\"\" GroupName=\"BSP\">
			<Condition Diagnostic=\"\" Expression=\"S_VCOM\"/>
		</BspDependency>" ;fi )
		<ConfigForMode>Bsp_Common</ConfigForMode>
	</RefMode>


	<!-- ModeLogicOperator for HS/FS -->
	<ModeLogicOperator Name=\"OR\">
		<Mode Name=\"COMMON\" UserName=\"Human Machine Interface\">
			<ModeLogicOperator Name=\"OR\">
				<Mode Name=\"COMMON\" UserName=\"Human Machine Interface\">
					<SignalLogicalOp Name=\"AND\">
						<Signal Name=\"VS_BSP_COMMON\"/>
					</SignalLogicalOp>
				<Semaphore></Semaphore>
				</Mode>
			</ModeLogicOperator>
		</Mode>
	</ModeLogicOperator>
	<Semaphore></Semaphore>
	<Semaphore></Semaphore>


	<RefSignal Name=\"VS_BSP_COMMON\" Virtual=\"true\"/>


</IP>" > $home_Path/$DB_Path/$bspPlugins_Path/NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )_Modes.xml
}

# Function to generate NUCLEO-BoardName_Configs.xml
generate_Config_file(){
	echo  "<?xml version=\"1.0\" encoding=\"ISO-8859-1\" standalone=\"no\"?>
<IP xmlns=\"http://mcd.rou.st.com/modules.php?name=mcu\"
	DBVersion=\"V4.0\"
	Name=\"BSP\"
	Version=\"STM32Cube_FW_$(echo $FW | sed 's/\STM32//')_V1.0.0RC3\"
	RootFolder=\"\"
	xmlns:ns0=\"http://www.w3.org/2001/XMLSchema-instance\"
	ns0:schemaLocation=\"http://mcd.rou.st.com/modules.php?name=mcu ../../../../../../../doc/V4/Development/Specifications/db/IP_Configs.xsd\">

	<!-- Class:Group:Sub:Variant (see STM32Cube_Packs_Firmware_Specification_rev1.5rc3_SRA.pdf chap 5.8 -->


	<RefConfig Name=\"Bsp_Common\">
		<Component Name=\"BoardSupport:NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]'):COMMON\"/>
		<ConfigFile Name=\"BSP_CONF_H\"/>
		<Component Name=\"HAL:UART\"/>
		<ConfigFile Name=\"BSP_INIT_C\"/>
		<Defines Name=\"USE_NUCLEO_64\" Type=\"Cdefine\" />
	</RefConfig>

	<RefConfigFile Name=\"BSP_CONF_H\" Description=\"\" Template=\"$( echo "$FW" | tr  '[:upper:]' '[:lower:]' )xx_nucleo_conf_h.ftl\" Added=\"true\">
		<File Name=\"$( echo "$FW" | tr  '[:upper:]' '[:lower:]')xx_nucleo_conf.h\" Category=\"header\" Version=\"\" Condition=\"\" />
		<Argument Name=\"VCP\" Comment=\"Virtual Com Port\"  GenericType=\"simple\"/>
	</RefConfigFile>
	<RefConfigFile Name=\"BSP_INIT_C\" Description=\"\" Template=\"bsp_inc.ftl\" Added=\"true\">
		<File Name=\"bsp_inc.tmp\" Category=\"source\" Version=\"1.0.0\" Condition=\"all\" />
		<Argument Name=\"VCP\" Comment=\"Virtual Com Port\"  GenericType=\"simple\"/>
	</RefConfigFile>
	<RefConfigFile Name=\"BSP_INIT_C\" Description=\"\" Template=\"bsp_common_vars.ftl\" Added=\"true\">
		<File Name=\"bsp_common_vars.tmp\" Category=\"source\" Version=\"1.0.0\" Condition=\"all\" />
		$( if [ "$LD1" = true ] ; then
		echo "<Argument Name=\"LD1\" Comment=\"USER LED $( echo "$LD1_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$LD2" = true ] ; then
		echo "<Argument Name=\"LD2\" Comment=\"USER LED $( echo "$LD2_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$LD3" = true ] ; then
		echo "<Argument Name=\"LD3\" Comment=\"USER LED $( echo "$LD3_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$LD4" = true ] ; then
		echo "<Argument Name=\"LD4\" Comment=\"USER LED $( echo "$LD4_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button" = true ] ; then
		echo "<Argument Name=\"BUTTON\" Comment=\"USER $button_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button2" = true ] ; then
		echo "<Argument Name=\"BUTTON2\" Comment=\"USER $button2_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button3" = true ] ; then
		echo "<Argument Name=\"BUTTON3\" Comment=\"USER $button3_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button4" = true ] ; then
		echo "<Argument Name=\"BUTTON4\" Comment=\"USER $button4_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$VCP" = true ] ; then
		echo "<Argument Name=\"VCP\" Comment=\"Virtual Com Port\"  GenericType=\"simple\"/>" ;fi )
		<Argument Name=\"Bsp_Common_DEMO\" Comment=\"Generate demonstration code\"  GenericType=\"simple\"/>
	</RefConfigFile>
	<RefConfigFile Name=\"BSP_INIT_C\" Description=\"\" Template=\"bsp_common_init.ftl\" Added=\"true\">
		<File Name=\"bsp_common_init.tmp\" Category=\"source\" Version=\"1.0.0\" Condition=\"all\" />
		$( if [ "$LD1" = true ] ; then
		echo "<Argument Name=\"LD1\" Comment=\"USER LED $( echo "$LD1_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$LD2" = true ] ; then
		echo "<Argument Name=\"LD2\" Comment=\"USER LED $( echo "$LD2_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$LD3" = true ] ; then
		echo "<Argument Name=\"LD3\" Comment=\"USER LED $( echo "$LD3_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$LD4" = true ] ; then
		echo "<Argument Name=\"LD4\" Comment=\"USER LED $( echo "$LD4_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button" = true ] ; then
		echo "<Argument Name=\"BUTTON\" Comment=\"USER $button_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button2" = true ] ; then
		echo "<Argument Name=\"BUTTON2\" Comment=\"USER $button2_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button3" = true ] ; then
		echo "<Argument Name=\"BUTTON3\" Comment=\"USER $button3_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button4" = true ] ; then
		echo "<Argument Name=\"BUTTON4\" Comment=\"USER $button4_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$VCP" = true ] ; then
		echo "<Argument Name=\"VCP\" Comment=\"Virtual Com Port\"  GenericType=\"simple\"/>" ;fi )
		<Argument Name=\"Bsp_Common_DEMO\" Comment=\"Generate demonstration code\"  GenericType=\"simple\"/>
	</RefConfigFile>
	<RefConfigFile Name=\"BSP_INIT_C\" Description=\"\" Template=\"bsp_common_demo_before_while.ftl\" Added=\"true\">
		<File Name=\"bsp_common_demo_before_while.tmp\" Category=\"source\" Version=\"1.0.0\" Condition=\"all\" />
		$( if [ "$LD1" = true ] ; then
		echo "<Argument Name=\"LD1\" Comment=\"USER LED $( echo "$LD1_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$LD2" = true ] ; then
		echo "<Argument Name=\"LD2\" Comment=\"USER LED $( echo "$LD2_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$LD3" = true ] ; then
		echo "<Argument Name=\"LD3\" Comment=\"USER LED $( echo "$LD3_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$LD4" = true ] ; then
		echo "<Argument Name=\"LD4\" Comment=\"USER LED $( echo "$LD4_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button" = true ] ; then
		echo "<Argument Name=\"BUTTON\" Comment=\"USER $button_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button2" = true ] ; then
		echo "<Argument Name=\"BUTTON2\" Comment=\"USER $button2_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button3" = true ] ; then
		echo "<Argument Name=\"BUTTON3\" Comment=\"USER $button3_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button4" = true ] ; then
		echo "<Argument Name=\"BUTTON4\" Comment=\"USER $button4_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$VCP" = true ] ; then
		echo "<Argument Name=\"VCP\" Comment=\"Virtual Com Port\"  GenericType=\"simple\"/>" ;fi )
		<Argument Name=\"Bsp_Common_DEMO\" Comment=\"Generate demonstration code\"  GenericType=\"simple\"/>
	</RefConfigFile>
	<RefConfigFile Name=\"BSP_INIT_C\" Description=\"\" Template=\"bsp_common_demo_inside_while.ftl\" Added=\"true\">
		<File Name=\"bsp_common_demo_inside_while.tmp\" Category=\"source\" Version=\"1.0.0\" Condition=\"all\" />
		$( if [ "$LD1" = true ] ; then
		echo "<Argument Name=\"LD1\" Comment=\"USER LED $( echo "$LD1_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$LD2" = true ] ; then
		echo "<Argument Name=\"LD2\" Comment=\"USER LED $( echo "$LD2_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$LD3" = true ] ; then
		echo "<Argument Name=\"LD3\" Comment=\"USER LED $( echo "$LD3_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$LD4" = true ] ; then
		echo "<Argument Name=\"LD4\" Comment=\"USER LED $( echo "$LD4_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button" = true ] ; then
		echo "<Argument Name=\"BUTTON\" Comment=\"USER $button_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button2" = true ] ; then
		echo "<Argument Name=\"BUTTON2\" Comment=\"USER $button2_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button3" = true ] ; then
		echo "<Argument Name=\"BUTTON3\" Comment=\"USER $button3_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button4" = true ] ; then
		echo "<Argument Name=\"BUTTON4\" Comment=\"USER $button4_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$VCP" = true ] ; then
		echo "<Argument Name=\"VCP\" Comment=\"Virtual Com Port\"  GenericType=\"simple\"/>" ;fi )
		<Argument Name=\"Bsp_Common_DEMO\" Comment=\"Generate demonstration code\"  GenericType=\"simple\"/>
	</RefConfigFile>
	<RefConfigFile Name=\"BSP_INIT_C\" Description=\"\" Template=\"bsp_common_demo_fct.ftl\" Added=\"true\">
		<File Name=\"bsp_common_demo_fct.tmp\" Category=\"source\" Version=\"1.0.0\" Condition=\"all\" />
		$( if [ "$LD1" = true ] ; then
		echo "<Argument Name=\"LD1\" Comment=\"USER LED $( echo "$LD1_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$LD2" = true ] ; then
		echo "<Argument Name=\"LD2\" Comment=\"USER LED $( echo "$LD2_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$LD3" = true ] ; then
		echo "<Argument Name=\"LD3\" Comment=\"USER LED $( echo "$LD3_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$LD4" = true ] ; then
		echo "<Argument Name=\"LD4\" Comment=\"USER LED $( echo "$LD4_Color" | tr '[:lower:]' '[:upper:]' )\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button" = true ] ; then
		echo "<Argument Name=\"BUTTON\" Comment=\"USER $button_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button2" = true ] ; then
		echo "<Argument Name=\"BUTTON2\" Comment=\"USER $button2_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button3" = true ] ; then
		echo "<Argument Name=\"BUTTON3\" Comment=\"USER $button3_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$Button4" = true ] ; then
		echo "<Argument Name=\"BUTTON4\" Comment=\"USER $button4_name\"  GenericType=\"simple\"/>" ;fi )
		$( if [ "$VCP" = true ] ; then
		echo "<Argument Name=\"VCP\" Comment=\"Virtual Com Port\"  GenericType=\"simple\"/>" ;fi )
		<Argument Name=\"Bsp_Common_DEMO\" Comment=\"Generate demonstration code\"  GenericType=\"simple\"/>
	</RefConfigFile>

  $( if [ "$TrustZoneEnable" = true ] ; then
      echo "  <RefConfigFile Name=\"BSP_INIT_C\" Description=\"\" Template=\"/../bsp_common_demo_gpio.ftl\" Added=\"true\">
            <File Name=\"bsp_common_demo_gpio.tmp\" Category=\"source\" Version=\"1.0.0\" Condition=\"all\" />
    </RefConfigFile>" ;fi )

	<RefComponent Cclass=\"BoardSupport\" Cgroup=\"NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]')\" Cversion=\"V1.1.0\">
		<SubComponent Csub=\"COMMON\" Description=\"Common\">
			<File Category=\"header\" Condition=\"\" Name=\"Drivers/BSP/$( echo "$FW" | tr  '[:lower:]' '[:upper:]' )xx_Nucleo/$( echo "$FW" | tr '[:upper:]' '[:lower:]' )xx_nucleo_errno.h\"/>

			<File Category=\"header\" Condition=\"\" Name=\"Drivers/BSP/$( echo "$FW" | tr  '[:lower:]' '[:upper:]' )xx_Nucleo/$( echo "$FW" | tr '[:upper:]' '[:lower:]' )xx_nucleo.h\"/>
			<File Category=\"source\" Condition=\"\" Name=\"Drivers/BSP/$( echo "$FW" | tr  '[:lower:]' '[:upper:]' )xx_Nucleo/$( echo "$FW" | tr '[:upper:]' '[:lower:]' )xx_nucleo.c\"/>
		</SubComponent>
	</RefComponent>

	<RefComponent Cclass=\"HAL\" Cgroup=\"USART\" Cversion=\"0.1.0\">
		<File Category=\"header\" Name=\"Drivers/$( echo "$FW" | tr  '[:lower:]' '[:upper:]' )xx_HAL_Driver/Inc/$( echo "$FW" | tr '[:upper:]' '[:lower:]' )xx_hal_usart.h\"/>
		<File Category=\"header\" Name=\"Drivers/$( echo "$FW" | tr  '[:lower:]' '[:upper:]' )xx_HAL_Driver/Inc/$( echo "$FW" | tr '[:upper:]' '[:lower:]' )xx_hal_usart_ex.h\"/>
		<File Category=\"source\" Name=\"Drivers/$( echo "$FW" | tr  '[:lower:]' '[:upper:]' )xx_HAL_Driver/Src/$( echo "$FW" | tr '[:upper:]' '[:lower:]' )xx_hal_usart.c\"/>
		<File Category=\"source\" Name=\"Drivers/$( echo "$FW" | tr  '[:lower:]' '[:upper:]' )xx_HAL_Driver/Src/$( echo "$FW" | tr '[:upper:]' '[:lower:]' )xx_hal_usart_ex.c\"/>
	</RefComponent>

	<RefComponent Cclass=\"HAL\" Cgroup=\"UART\" Cversion=\"0.1.0\">
		<File Category=\"header\" Name=\"Drivers/$( echo "$FW" | tr  '[:lower:]' '[:upper:]' )xx_HAL_Driver/Inc/$( echo "$FW" | tr '[:upper:]' '[:lower:]' )xx_hal_uart.h\"/>
		<File Category=\"header\" Name=\"Drivers/$( echo "$FW" | tr  '[:lower:]' '[:upper:]' )xx_HAL_Driver/Inc/$( echo "$FW" | tr '[:upper:]' '[:lower:]' )xx_hal_uart_ex.h\"/>
		<File Category=\"source\" Name=\"Drivers/$( echo "$FW" | tr  '[:lower:]' '[:upper:]' )xx_HAL_Driver/Src/$( echo "$FW" | tr '[:upper:]' '[:lower:]' )xx_hal_uart_ex.c\"/>
		<File Category=\"source\" Name=\"Drivers/$( echo "$FW" | tr  '[:lower:]' '[:upper:]' )xx_HAL_Driver/Src/$( echo "$FW" | tr '[:upper:]' '[:lower:]' )xx_hal_uart.c\"/>
	</RefComponent>

</IP>" > $home_Path/$DB_Path/$bspPlugins_Path/NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )_Configs.xml

}

# Function to generate bsp_common.ftl
generate_bsp_common_ftl(){
	local fileName=$1;
	echo "[#ftl]
[#list SWIPdatas as SWIP]
    [#assign instName = SWIP.ipName]
    [#assign fileName = SWIP.fileName]
    [#assign version = SWIP.version]

    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if definition.name==\"LD1\"]
                [#assign LED1 = definition.value]
            [/#if]
            [#if definition.name==\"LD2\"]
                [#assign LED2 = definition.value]
            [/#if]
            [#if definition.name==\"LD3\"]
                [#assign LED3 = definition.value]
            [/#if]
            [#if definition.name==\"LD4\"]
                [#assign LED4 = definition.value]
            [/#if]
            [#if definition.name==\"BUTTON\"]
                [#assign BUTTON = definition.value]
            [/#if]
			[#if definition.name==\"BUTTON2\"]
                [#assign BUTTON2 = definition.value]
            [/#if]
			[#if definition.name==\"BUTTON3\"]
                [#assign BUTTON3 = definition.value]
            [/#if]
			[#if definition.name==\"BUTTON4\"]
                [#assign BUTTON4 = definition.value]
            [/#if]
            [#if definition.name==\"VCP\"]
                [#assign VCP = definition.value]
            [/#if]
            [#if definition.name==\"Bsp_Common_DEMO\"]
                [#assign Bsp_Common_DEMO = definition.value]
            [/#if]
        [/#list]
    [/#if]
[/#list]" > $home_Path/$DB_Path/$ftl_Path/NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )/$fileName
}

# Function to generate bsp_common_demo_before_while.ftl
generate_bsp_common_demo_before_while_ftl(){
generate_bsp_common_ftl bsp_common_demo_before_while.ftl
	
echo "[#compress]
[#if Bsp_Common_DEMO?? && Bsp_Common_DEMO == \"true\"]
	#t/* USER CODE BEGIN BSP */
	[#if VCP == \"true\"]
	#n#t/* -- Sample board code to send message over COM1 port ---- */
	#tprintf(\"Welcome to STM32 world !\n\r\");
	[/#if]
	$( if [ "$LD1" = true ] || [ "$LD2" = true ] || [ "$LD3" = true ] || [ "$LD4" = true ] ; then
echo "[#if (LED1??&& LED1==\"true\") || (LED2??&& LED2==\"true\") || (LED3??&& LED3==\"true\") || (LED4??&& LED4==\"true\") ]
		#n#t/* -- Sample board code to switch on leds ---- */

        $( if [ "$LD1" = true ] ; then
  echo "[#if  LED1?? && LED1 == \"true\"]
			#tBSP_LED_On($( echo "LED_$LD1_Color" | tr '[:lower:]' '[:upper:]' ));
		[/#if]" ;fi )
		 $( if [ "$LD2" = true ] ; then
  echo "[#if  LED2?? && LED2 == \"true\"]
			#tBSP_LED_On($( echo "LED_$LD2_Color" | tr '[:lower:]' '[:upper:]' ));
		[/#if]" ;fi )
		$( if [ "$LD3" = true ] ; then
  echo "[#if  LED3?? && LED3 == \"true\"]
			#tBSP_LED_On($( echo "LED_$LD3_Color" | tr '[:lower:]' '[:upper:]' ));
		[/#if]" ;fi )
		$( if [ "$LD4" = true ] ; then
  echo "[#if  LED4?? && LED4 == \"true\"]
			#tBSP_LED_On($( echo "LED_$LD4_Color" | tr '[:lower:]' '[:upper:]' ));
		[/#if]" ;fi )
	[/#if] " ;fi )
	#n#t/* USER CODE END BSP */
[/#if]
[/#compress]" >> $home_Path/$DB_Path/$ftl_Path/NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )/bsp_common_demo_before_while.ftl

}


# Function to generate bsp_common_demo_fct.ftl
generate_bsp_common_demo_fct(){
generate_bsp_common_ftl bsp_common_demo_fct.ftl

echo "[#if Bsp_Common_DEMO?? && Bsp_Common_DEMO == \"true\"]
[#compress]
[#if (BUTTON?? && BUTTON == \"1\") || (BUTTON2?? && BUTTON2 == \"1\") || (BUTTON3?? && BUTTON3 == \"1\") || (BUTTON4?? && BUTTON4 == \"1\")][#--EXTI--]
  $( if [ "$Button" = true ] && [ -z "$Button2" ] && [ -z "$Button3" ] && [ -z "$Button4" ] ; then
    echo "/**
  #t* @brief  BSP Push Button callback
  #t* @param  Button Specifies the pressed button
  #t* @retval None
  #t*/
  void BSP_PB_Callback(Button_TypeDef Button)
  {
    #tif (Button == BUTTON_USER)
      #t{
        #t#tBspButtonState = BUTTON_PRESSED;
      #t}";
   else
    echo "/**
  #t* @brief EXTI line detection callback.
  #t* @param GPIO_Pin: Specifies the pins connected EXTI line
  #t* @retval None
  #t*/
  void HAL_GPIO_EXTI_Falling_Callback(uint16_t GPIO_Pin)
  {
  #tswitch(GPIO_Pin)
      #t{"
      if [ "$Button" = true ] ; then
        echo -e "\t\t\t[#if (BUTTON?? && BUTTON == \"1\")]
                \t#t#tcase "$button_name"_PIN:
                \t\t#t#t#t/* Change the period to 100 ms */
                \t\t#t#t#tdelay = 100;
                \t\t#t#t#tbreak;
                [/#if]"; fi
      if [ "$Button2" = true ] ; then
        echo -e "\t\t\t[#if (BUTTON2?? && BUTTON2 == \"1\")]
                \t#t#tcase "$button2_name"_PIN:
                \t\t#t#t#t/* Change the period to 500 ms */
                \t\t#t#t#tdelay = 500;
                \t\t#t#t#tbreak;
                 [/#if]";fi
      if [ "$Button3" = true ] ; then
          echo -e "\t\t\t[#if (BUTTON3?? && BUTTON3 == \"1\")]
                \t#t#tcase "$button3_name"_PIN:
                \t\t#t#t#t/* Change the period to 1000 ms */
                \t\t#t#t#tdelay = 1000;
                \t\t#t#t#tbreak;
                [/#if]";fi
           echo -e "\t\t\t\t#t#tdefault:
                \t#t#t#tbreak;
        #t}"
  fi )

	}
  [/#if]
[/#compress]
[/#if]" >> $home_Path/$DB_Path/$ftl_Path/NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )/bsp_common_demo_fct.ftl
}


# Function to generate bsp_common_demo_inside_while.ftl
generate_bsp_common_demo_inside_while(){
generate_bsp_common_ftl bsp_common_demo_inside_while.ftl

echo -e "\n[#if Bsp_Common_DEMO?? && Bsp_Common_DEMO == \"true\"  ]
[#compress]
$( if [ "$Button" = true ] && [ -z "$Button2" ] && [ -z "$Button3" ] && [ -z "$Button4" ] ; then
echo "[#if BUTTON == \"1\"]
        #t#t/* -- Sample board code for User push-button in interrupt mode ---- */
        #t#tif (BspButtonState == BUTTON_PRESSED)
        #t#t{
        #t#t#t/* Update button state */
        #t#t#tBspButtonState = BUTTON_RELEASED;
        [@toggle_Leds/]
        #t#t#t/* ..... Perform your action ..... */
        #t#t}
    [#elseif BUTTON == \"2\"]
        #t#t/* -- Sample board code for User push-button without interrupt mode ---- */
        #t#tif (BSP_PB_GetState(BUTTON_USER) == BUTTON_PRESSED)
        #t#t{
        [@toggle_Leds/]
        #t#t#t/* ..... Perform your action ..... */
        #t#t}
    [/#if]";
    else
    echo  "[#if (BUTTON?? && BUTTON == \"1\") || (BUTTON2?? && BUTTON2 == \"1\") || (BUTTON3?? && BUTTON3 == \"1\") || (BUTTON4?? && BUTTON4 == \"1\")][#--GPIO--]
    #t#t/* -- Sample board code for User push-button in interrupt mode ---- */
  [/#if]"
      if [ "$Button" = true ] ; then
echo "[#if BUTTON == \"1\"]
    #t#tBSP_LED_Toggle($( echo "LED_$LD1_Color" | tr '[:lower:]' '[:upper:]' ));
    #t#tHAL_Delay(delay);
    #n
[/#if]";
      fi
      if [ "$Button2" = true ] ; then
echo "[#if BUTTON2 == \"1\"]
    #t#tBSP_LED_Toggle($( echo "LED_$LD2_Color" | tr '[:lower:]' '[:upper:]' ));
    #t#tHAL_Delay(delay);
    #n
[/#if]";
      fi
      if [ "$Button3" = true ] ; then
echo "[#if BUTTON3 == \"1\"]
    #t#tBSP_LED_Toggle($( echo "LED_$LD3_Color" | tr '[:lower:]' '[:upper:]' ));
    #t#tHAL_Delay(delay);
    #n
[/#if]";
      fi
      if [ "$Button4" = true ] ; then
echo "[#if BUTTON4 == \"1\"]
    #t#tBSP_LED_Toggle($( echo "LED_$LD4_Color" | tr '[:lower:]' '[:upper:]' ));
    #t#tHAL_Delay(delay);
    #n
[/#if]";
      fi

echo -e "\n[#if (BUTTON?? && BUTTON == \"2\") || (BUTTON2?? && BUTTON2 == \"2\") || (BUTTON3?? && BUTTON3 == \"2\") || (BUTTON4?? && BUTTON4 == \"2\")][#--GPIO--]
#t#t/* -- Sample board code for User push-button without interrupt mode ---- */
[/#if]"
      if [ "$Button" = true ] ; then
echo "[#if BUTTON == \"2\"]
    #t#tBSP_LED_Toggle($( echo "LED_$LD1_Color" | tr '[:lower:]' '[:upper:]' ));
    #t#tHAL_Delay(delay);
    #t#tif (BSP_PB_GetState($button_name) == 1)
    #t#t{
    [#if  LED1?? && LED1 == \"true\"]
              #t#t#tdelay = 100;
    [/#if]
    #t#t#t/* ..... Perform your action ..... */
    #t#t}
    #n
[/#if]";
      fi
      if [ "$Button2" = true ] ; then
echo "[#if BUTTON2 == \"2\"]
    #t#tBSP_LED_Toggle($( echo "LED_$LD2_Color" | tr '[:lower:]' '[:upper:]' ));
    #t#tHAL_Delay(delay);
    #t#tif (BSP_PB_GetState($button2_name) == 1)
    #t#t{
    [#if  LED2?? && LED2 == \"true\"]
              #t#t#tdelay = 500;
    [/#if]
    #t#t#t/* ..... Perform your action ..... */
    #t#t}
    #n
[/#if]";
      fi
      if [ "$Button3" = true ] ; then
echo "[#if BUTTON3 == \"2\"]
    #t#tBSP_LED_Toggle($( echo "LED_$LD3_Color" | tr '[:lower:]' '[:upper:]' ));
    #t#tHAL_Delay(delay);
    #t#tif (BSP_PB_GetState($button3_name) == 1)
    #t#t{
    [#if  LED3?? && LED3 == \"true\"]
              #t#t#tdelay = 1000;
    [/#if]
    #t#t#t/* ..... Perform your action ..... */
    #t#t}
    #n
[/#if]";
      fi
      if [ "$Button4" = true ] ; then
echo "[#if BUTTON4 == \"2\"]
    #t#tBSP_LED_Toggle($( echo "LED_$LD4_Color" | tr '[:lower:]' '[:upper:]' ));
    #t#tHAL_Delay(delay);";
      fi
    fi )
[/#compress]
[/#if]" >> $home_Path/$DB_Path/$ftl_Path/NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )/bsp_common_demo_inside_while.ftl

if [ "$Button" = true ] && [ -z "$Button2" ] && [ -z "$Button3" ] && [ -z "$Button4" ] ; then
  if [ "$LD1" = true ] || [ "$LD2" = true ] || [ "$LD3" = true ] || [ "$LD4" = true ] ; then
echo -e "\n[#macro toggle_Leds]
  [#if (LED1??&& LED1==\"true\") || (LED2??&& LED2==\"true\") || (LED3??&& LED3==\"true\") || (LED4??&& LED4==\"true\") ]
  #t#t#t/* -- Sample board code to toggle leds ---- */
  $(if [ "$LD1" = true ] ; then
  echo "[#if  LED1?? && LED1 == \"true\"]
  #t#t#tBSP_LED_Toggle($( echo "LED_$LD1_Color" | tr '[:lower:]' '[:upper:]' ));
  [/#if]"
  fi )
  $(if [ "$LD2" = true ] ; then
  echo "[#if  LED2?? && LED2 == \"true\"]
      #t#t#tBSP_LED_Toggle($( echo "LED_$LD2_Color" | tr '[:lower:]' '[:upper:]' ));
     [/#if]"
  fi )
  $(if [ "$LD3" = true ] ; then
  echo "[#if  LED3?? && LED3 == \"true\"]
      #t#t#tBSP_LED_Toggle($( echo "LED_$LD3_Color" | tr '[:lower:]' '[:upper:]' ));
    [/#if]"
  fi )
  $(if [ "$LD4" = true ] ; then
   echo "[#if  LED4?? && LED4 == \"true\"]
      #t#t#tBSP_LED_Toggle($( echo "LED_$LD4_Color" | tr '[:lower:]' '[:upper:]' ));
    [/#if]"
  fi )
  #n
  [/#if]
[/#macro] " >> $home_Path/$DB_Path/$ftl_Path/NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )/bsp_common_demo_inside_while.ftl
  fi
fi

}


# Function to generate bsp_common_init.ftl
generate_bsp_common_init(){
generate_bsp_common_ftl bsp_common_init.ftl

echo "[#compress]
$( if [ "$LD1" = true ] || [ "$LD2" = true ] || [ "$LD3" = true ] || [ "$LD4" = true ] ; then
echo "	[#if (LED1??&& LED1==\"true\") || (LED2??&& LED2==\"true\") || (LED3??&& LED3==\"true\") || (LED4??&& LED4==\"true\") ]
		#t/* Initialize leds */
        $( if [ "$LD1" = true ] ; then
  echo "[#if  LED1?? && LED1 == \"true\"]
			#tBSP_LED_Init($( echo "LED_$LD1_Color" | tr '[:lower:]' '[:upper:]' ));
		[/#if]" ;fi )
		 $( if [ "$LD2" = true ] ; then
  echo "[#if  LED2?? && LED2 == \"true\"]
			#tBSP_LED_Init($( echo "LED_$LD2_Color" | tr '[:lower:]' '[:upper:]' ));
		[/#if]" ;fi )
		$( if [ "$LD3" = true ] ; then
  echo "[#if  LED3?? && LED3 == \"true\"]
			#tBSP_LED_Init($( echo "LED_$LD3_Color" | tr '[:lower:]' '[:upper:]' ));
		[/#if]" ;fi )
		$( if [ "$LD4" = true ] ; then
  echo "[#if  LED4?? && LED4 == \"true\"]
			#tBSP_LED_Init($( echo "LED_$LD4_Color" | tr '[:lower:]' '[:upper:]' ));
		[/#if]" ;fi )
	[/#if] " ;fi )
#n
$( if [ "$Button" = true ] && [ -z "$Button2" ] && [ -z "$Button3" ] && [ -z "$Button4" ] ; then
  echo "  [#if BUTTON == \"1\"][#--EXTI--]
    #t/* Initialize USER push-button, will be used to trigger an interrupt each time it's pressed.*/
    #tBSP_PB_Init(BUTTON_USER, BUTTON_MODE_EXTI);
  [#elseif BUTTON == \"2\"]
    #t/* Initialize User push-button without interrupt mode. */
    #tBSP_PB_Init(BUTTON_USER, BUTTON_MODE_GPIO);
  [/#if]";
  else
  echo  "[#if (BUTTON?? && BUTTON == \"1\") || (BUTTON2?? && BUTTON2 == \"1\") || (BUTTON3?? && BUTTON3 == \"1\") || (BUTTON4?? && BUTTON4 == \"1\")][#--GPIO--]
    #t/* Initialize USER push-button, will be used to trigger an interrupt each time it's pressed.*/"
  if [ "$Button" = true ] ; then
  echo "  [#if BUTTON == \"1\"][#--EXTI--]
    #tBSP_PB_Init($button_name, BUTTON_MODE_EXTI);
  [/#if]";
  fi
  if [ "$Button2" = true ] ; then
  echo "  [#if BUTTON2 == \"1\"][#--EXTI--]
    #tBSP_PB_Init($button2_name, BUTTON_MODE_EXTI);
  [/#if]";
  fi
  if [ "$Button3" = true ] ; then
  echo "  [#if BUTTON3 == \"1\"][#--EXTI--]
    #tBSP_PB_Init($button3_name, BUTTON_MODE_EXTI);
  [/#if]";
  fi
  if [ "$Button4" = true ] ; then
  echo "  [#if BUTTON4 == \"1\"][#--EXTI--]
    #tBSP_PB_Init($button4_name, BUTTON_MODE_EXTI);
  [/#if]";
  fi
  echo "#n
[/#if]"

  echo -e "\n[#if (BUTTON?? && BUTTON == \"2\") || (BUTTON2?? && BUTTON2 == \"2\") || (BUTTON3?? && BUTTON3 == \"2\") || (BUTTON4?? && BUTTON4 == \"2\")][#--GPIO--]
    #t/* Initialize User push-button without interrupt mode. */"
  if [ "$Button" = true ] ; then
  echo "  [#if BUTTON == \"2\"]
    #tBSP_PB_Init($button_name, BUTTON_MODE_GPIO);
  [/#if]";
  fi
  if [ "$Button2" = true ] ; then
  echo "  [#if BUTTON2 == \"2\"]
    #tBSP_PB_Init($button2_name, BUTTON_MODE_GPIO);
  [/#if]";
  fi
  if [ "$Button3" = true ] ; then
  echo "  [#if BUTTON3 == \"2\"]
    #tBSP_PB_Init($button3_name, BUTTON_MODE_GPIO);
  [/#if]";
  fi
  if [ "$Button4" = true ] ; then
  echo "  [#if BUTTON4 == \"2\"]
    #tBSP_PB_Init($button4_name, BUTTON_MODE_GPIO);
  [/#if]";
  fi
  echo "#n
[/#if]"
fi)
[/#compress]
#n
[#if VCP == \"true\"]
  /* Initialize COM1 port (115200, 8 bits (7-bit data + 1 stop bit), no parity */
  BspCOMInit.BaudRate   = 115200;
  BspCOMInit.WordLength = COM_WORDLENGTH_8B;
  BspCOMInit.StopBits   = COM_STOPBITS_1;
  BspCOMInit.Parity     = COM_PARITY_NONE;
  BspCOMInit.HwFlowCtl  = COM_HWCONTROL_NONE;
  if (BSP_COM_Init(COM1, &BspCOMInit) != BSP_ERROR_NONE)
  {
    Error_Handler();
  }
[/#if]" >> $home_Path/$DB_Path/$ftl_Path/NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )/bsp_common_init.ftl

}


# Function to generate bsp_common_vars.ftl
generate_bsp_common_vars_ftl(){
generate_bsp_common_ftl bsp_common_vars.ftl

echo "[#if VCP == \"true\"]
COM_InitTypeDef BspCOMInit;
[/#if]
[#if Bsp_Common_DEMO?? && Bsp_Common_DEMO == \"true\"]
$( if [ "$Button" = true ] && [ -z "$Button2" ] && [ -z "$Button3" ] && [ -z "$Button4" ] ; then
echo "__IO uint32_t BspButtonState = BUTTON_RELEASED;"
else
echo "static uint32_t delay = 250;"
fi )
[/#if]" >> $home_Path/$DB_Path/$ftl_Path/NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )/bsp_common_vars.ftl

}


# Function to generate bsp_common_ftl bsp_inc.ftl
generate_bsp_inc_ftl(){
generate_bsp_common_ftl bsp_inc.ftl

echo "[#if instName.toLowerCase()?contains(\"nucleo\")]
#include \"\${FamilyName?lower_case}xx_nucleo.h\"
[#else]
#include \"\${instName.toLowerCase()?replace('-dk','_discovery')}.h\"
[/#if]
[#if VCP == \"true\"]
#include <stdio.h>
[/#if]" >> $home_Path/$DB_Path/$ftl_Path/NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )/bsp_inc.ftl

}

# Function to generate stm32(boardName)xx_nucleo_conf_h.ftl
generate_stm32XXxx_nucleo_conf_h(){

echo -e "[#ftl]
[#list SWIPdatas as SWIP]
[#assign instName = SWIP.ipName]
[#assign fileName = SWIP.fileName]
[#assign version = SWIP.version]

  [#if SWIP.defines??]
    [#list SWIP.defines as definition]
      [#if definition.name==\"VCP\"]
          [#assign VCP = definition.value]
      [/#if]
    [/#list]
  [/#if]
[/#list]
/**
  ******************************************************************************
  * @file    $( echo "$FW" | tr '[:upper:]' '[:lower:]' )$(echo "xx_nucleo_conf.h")
  * @author  MCD Application Team
  * @brief   $( echo "$FW" | tr '[:lower:]' '[:upper:]' )$(echo "xx_Nucleo board configuration file.")
  *          This file should be copied to the application folder and renamed
  *          to $( echo "$FW" | tr '[:upper:]' '[:lower:]' )$(echo "xx_nucleo_conf.h")
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2022 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef $( echo "$FW" | tr '[:lower:]' '[:upper:]' )$(echo "XX_NUCLEO_CONF_H")
#define $( echo "$FW" | tr '[:lower:]' '[:upper:]' )$(echo "XX_NUCLEO_CONF_H")

#ifdef __cplusplus
extern \"C\" {
#endif

/* Includes ------------------------------------------------------------------*/
#include \"$(echo "$FW" | tr '[:upper:]' '[:lower:]' )$(echo "xx_hal.h\"")

/** @addtogroup BSP
  * @{
  */

/** @addtogroup $( echo "$FW" | tr '[:lower:]' '[:upper:]' )$(echo "XX_NUCLEO")
  * @{
  */

/** @defgroup $( echo "$FW" | tr '[:lower:]' '[:upper:]' )$(echo "XX_NUCLEO_CONFIG Config")
  * @{
  */

/** @defgroup STM32C0XX_NUCLEO_CONFIG_Exported_Constants Exported Constants
  * @{
  */
/* Nucleo pin and part number defines */
#define USE_$( echo "$FW" | tr '[:lower:]' '[:upper:]' )$(echo "XX_NUCLEO")

/* COM define */
#define USE_COM_LOG                         [#if VCP == \"true\"]1U[#else]0U[/#if]
#define USE_BSP_COM_FEATURE                 [#if VCP == \"true\"]1U[#else]0U[/#if]

/* IRQ priorities */
$( if [ "$Button" = true ] && [ -z "$Button2" ] && [ -z "$Button3" ] && [ -z "$Button4" ] ; then
echo "#define BSP_BUTTON_USER_IT_PRIORITY         15U";
else
if [ "$Button" = true ] ; then
echo "#define BSP_"$button_name"_IT_PRIORITY         15U";
fi
if [ "$Button2" = true ] ; then
echo "#define BSP_"$button2_name"_IT_PRIORITY         15U";
fi
if [ "$Button3" = true ] ; then
echo "#define BSP_"$button3_name"_IT_PRIORITY         15U";
fi
if [ "$Button4" = true ] ; then
echo "#define BSP_"$button4_name"_IT_PRIORITY         15U";
fi
fi )

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

#ifdef __cplusplus
}
#endif

#endif /* $( echo "$FW" | tr '[:lower:]' '[:upper:]' )$(echo "XX_NUCLEO_CONF_H") */" > $home_Path/$DB_Path/$ftl_Path/NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )/$( echo "$FW" | tr '[:upper:]' '[:lower:]' )xx_nucleo_conf_h.ftl

}



#----------------------------------- Main Programe ------------------------------


check_Arguments
Collect_Data
echo "$(tput sgr0)Create new files under : $home_Path/$DB_Path/$bspPlugins_Path"
echo " ->$(tput sgr0)generate File :$(tput setaf 6) NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )_Modes.xml $(tput sgr0) "
generate_Mode_file

echo " ->$(tput sgr0)generate File :$(tput setaf 6) NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )_Configs.xml $(tput sgr0)"
generate_Config_file

echo -e "\n\t\t\t $(tput setaf 2)---------------\n"

mkdir -p $home_Path/$DB_Path/$ftl_Path/NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )
echo "$(tput sgr0)Create new folder under : $home_Path/$DB_Path/$ftl_Path/$(tput setaf 6)NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )"

echo " $(tput sgr0)->generate File : NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )/$(tput setaf 6)bsp_common_demo_before_while.ftl $(tput sgr0)   "
generate_bsp_common_demo_before_while_ftl
echo " $(tput sgr0)->generate File : NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )/$(tput setaf 6)bsp_common_demo_fct.ftl $(tput sgr0) "
generate_bsp_common_demo_fct
echo " $(tput sgr0)->generate File : NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )/$(tput setaf 6)bsp_common_demo_inside_while.ftl $(tput sgr0)  "
generate_bsp_common_demo_inside_while
echo " $(tput sgr0)->generate File : NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )/$(tput setaf 6)bsp_common_init.ftl $(tput sgr0)  "
generate_bsp_common_init
echo " $(tput sgr0)->generate File : NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )/$(tput setaf 6)bsp_common_vars.ftl $(tput sgr0)  "
generate_bsp_common_vars_ftl
echo " $(tput sgr0)->generate File : NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )/$(tput setaf 6)bsp_inc.ftl $(tput sgr0)  "
generate_bsp_inc_ftl
echo " ->$(tput sgr0)generate File : NUCLEO-$( echo "$Board_Name" | tr '[:lower:]' '[:upper:]' )/$(tput setaf 6)$( echo "$FW" | tr '[:upper:]' '[:lower:]' )xx_nucleo_conf_h.ftl $(tput sgr0) "
generate_stm32XXxx_nucleo_conf_h


