package body ColoursMaker is

   function MakeRGBColor (
      red, green, blue : SDL.Video.Palettes.Colour_Component)
      return SDL.Video.Palettes.Colour
   is
      Colour : SDL.Video.Palettes.Colour;
   begin
      Colour.Red := red;
      Colour.Green := green;
      Colour.Blue := blue;
      Colour.Alpha := 255;
      return Colour;
   end MakeRGBColor;

end ColoursMaker;