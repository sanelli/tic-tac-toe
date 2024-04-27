with SDL.Video.Palettes;
with ColoursMaker; use ColoursMaker;

package Colours is

   Red   : constant SDL.Video.Palettes.Colour := MakeRGBColor (255, 0, 0);
   Green : constant SDL.Video.Palettes.Colour := MakeRGBColor (0, 255, 0);
   Blue  : constant SDL.Video.Palettes.Colour := MakeRGBColor (0, 0, 255);
   Black : constant SDL.Video.Palettes.Colour := MakeRGBColor (0, 0, 0);
   White : constant SDL.Video.Palettes.Colour := MakeRGBColor (255, 255, 255);

end Colours;