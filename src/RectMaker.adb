package body RectMaker is

   function MakeRect
      (x, y : SDL.Coordinate;
       width, height : SDL.Natural_Dimension)
      return SDL.Video.Rectangles.Rectangle
   is
      rect : SDL.Video.Rectangles.Rectangle;
   begin
      rect.X := x;
      rect.Y := y;
      rect.Width := width;
      rect.Height := height;
      return rect;
   end MakeRect;

end RectMaker;