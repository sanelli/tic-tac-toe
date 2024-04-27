with SDL;
with SDL.Video.Rectangles;

package RectMaker is

   function MakeRect
      (x, y : SDL.Coordinate;
       width, height : SDL.Natural_Dimension)
      return SDL.Video.Rectangles.Rectangle;

   function MakeSize
      (width, height : SDL.Dimension)
      return SDL.Sizes;

end RectMaker;