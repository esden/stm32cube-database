$version 6.60

// This is the root component of the entire GUI application.
$rect <20,20,220,60>
$output false
class Application : Core::Root
{
  $rect <820,0,1020,40>
  inherited property Bounds = <0,0,800,480>;

  // To do:
  // 
  // - The simplest way to compose the appearance of the application is to use the \
  // 'Views' and 'Widget Sets' from the Gallery.
  // 
  // - To react to touch or keyboard events use the templates from the Gallery folder \
  // 'Event Handlers'.
  // 
  // - To perform transitions (animations) use the templates from the Gallery folder \
  // 'Effects'.
  // 
  // - To store values use the 'Variable', 'Array' and 'Property' templates available \
  // in the Gallery folder 'Chora'.
  // 
  // - To implement behavior use the 'Method' and 'Slot Method' templates available \
  // in the Gallery folder 'Chora'.
  note legend Note1
  {
    attr Bounds = <10,500,790,700>;
  }

  // This is a filled rectangle view.
  $rect <20,20,160,60>
  object Views::Rectangle Rectangle
  {
    preset Bounds = <-10,0,800,480>;
    preset Color = #000000FF;
  }

  // This is an ordinary text view.
  $rect <20,20,160,60>
  object Views::Text Text
  {
    preset Bounds = <350,220,460,250>;
    preset String = "Hello!";
    preset Font = Application::Font;
  }
}

// To do:
// 
// - Open the 'Application' component for editing. It represents your entire GUI. \
// Use widgets, views, event handlers and effects from the Gallery to assemble there \
// your desired GUI look and feel.
// 
// - Create your own GUI components, widgets, panels, etc. The Gallery folder 'Components' \
// contains for this purpose various templates you can simply add to the unit and \
// thus start your own component development.
// 
// - You can add your own bitmap and font resources to the unit. Use the templates \
// 'Bitmap Resource' and 'Font Resource' from the Gallery folder 'Components' for \
// this purpose.
// 
// - You can add here also constants to store e.g. multilingual text fragments. Use \
// for this purpose the template 'Constant' from the Gallery folder 'Chora'.
// 
// - To add an interface for communication with the target device use the template \
// 'Device Interface' from the Gallery folder 'Device'.
note legend Note1
{
  attr Bounds = <20,80,710,380>;
}

// This is a font resource.
$rect <230,20,430,60>
$output false
resource Resources::Font Font
{
  attr fontname FontName = Arial;
  attr fontheight Height = 32;
  attr fontquality Quality = High;
  attr fontranges Ranges = 0x20-0xFF;
  attr fontaspectratio AspectRatio = 1.0;
  attr fontbold Bold = false;
  attr fontitalic Italic = false;
}
