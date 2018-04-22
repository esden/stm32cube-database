[#ftl]
[#list parameters as params]
[#assign profile = params.EA_2_in_file1_param1]
[#assign Xsize = params.EA_2_in_file1_param2]
[#assign Ysize = params.EA_2_in_file1_param3]
[#assign ColorFormat = params.EA_2_in_file1_param4]


[/#list]

$version 6.60

// This unit is a part of the Embedded Wizard class library 'Mosaic20'
$rect <40,70,240,110>
unit Core
{
  attr Directory = $Mosaic;
}

// This unit is a part of the Embedded Wizard class library 'Mosaic20'
$rect <40,110,240,150>
unit Resources
{
  attr Directory = $Mosaic;
}

// This unit is a part of the Embedded Wizard class library 'Mosaic20'
$rect <40,150,240,190>
unit Graphics
{
  attr Directory = $Mosaic;
}

// This unit is a part of the Embedded Wizard class library 'Mosaic20'
$rect <40,190,240,230>
unit Effects
{
  attr Directory = $Mosaic;
}

// This unit is a part of the Embedded Wizard class library 'Mosaic20'
$rect <40,230,240,270>
unit Views
{
  attr Directory = $Mosaic;
}

// This is a profile member for the project. This profile controls the code generation \
// for the target system.
$rect <290,100,490,140>
profile STM32 : STM.STM32.${ColorFormat}
{
  attr ScreenSize = <${Xsize},${Ysize}>;
  attr Optimization = High;
  attr ApplicationClass = Application::Application;
  attr ScreenOrientation = Normal;
  attr FormatOfBitmapResources = Compressed;
  attr FormatOfStringConstants = Compressed;
  attr OutputDirectory = ..\GeneratedCode\${ColorFormat};
  attr PostProcess = ew_post_process.cmd;
  attr CleanOutputDirectories = true;

  $rect <10,10,154,50>
  macro Author = "Dipl. Ing. Paul Banach and Dipl. Ing. Manfred Schweyer, Copyright (C) TARA Systems GmbH";
}

// The 'default' Language. Each project has to contain at least one language brick \
// called 'Default'
$rect <540,100,740,140>
language Default;

// This unit is intended to contain the application class and another GUI components.
$rect <290,230,490,270>
unit Application
{
  attr Directory = .\;
}

// Mosaic Framework
note group Note1
{
  attr Bounds = <20,20,260,290>;
}

// Configuration for the target code generation
note group Note2
{
  attr Bounds = <270,20,510,160>;
}

// The default language identifier
note group Note3
{
  attr Bounds = <520,20,760,160>;
}

// To do:
// 
// - Select the profile brick and choose the desired color format of your GUI application \
// within the attribute 'PlatformPackage' (e.g. STM.STM32.RGBA8888, STM.STM32.RGB565, \
// ...)
// 
// - Select the profile brick and set the attribute 'OutputDirectory' to the desired \
// destination folder for the generated code (e.g. within your Build Environment \
// '\Examples\Template\GeneratedCode').
// 
// - Open the unit 'Application'. You will find there the application component (the \
// root component of your GUI). Implement there your desired GUI look and feel.
// 
// - To better structure your project you can add more units here. Use for this purpose \
// the template 'Unit' from the Gallery folder 'Chora'. Afterwards you can open the \
// unit and put there your own GUI components.
// 
// - If you plan to develop a multilingual GUI application, you can add more language \
// members to the project. Use for this purpose the template 'Language' found in \
// the Gallery folder 'Chora'.
note legend Note4
{
  attr Bounds = <20,510,760,810>;
}

// Project Units
note group Note5
{
  attr Bounds = <270,170,760,290>;
}

// Welcome to Embedded Wizard!
// 
// This empty project is prepared to create a GUI application suitable for a STM32F469 \
// Discovery board with a display size of 800x480 pixel (landscape mode).
// 
// In order to get your first Embedded Wizard generated UI application up and running \
// on your STM32 target, we highly recommend to study the following document:
// 
// http://doc.embedded-wizard.de/getting-started-stm32f469-discovery
note legend Note
{
  attr Bounds = <20,300,760,500>;
}
