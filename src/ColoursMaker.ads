with SDL.Video.Palettes;

package ColoursMaker is

   function MakeRGBColor
      (red, green, blue : SDL.Video.Palettes.Colour_Component)
      return SDL.Video.Palettes.Colour;

end ColoursMaker;