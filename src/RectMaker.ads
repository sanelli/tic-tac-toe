with SDL;
with SDL.Video.Rectangles;

package RectMaker is

   function MakeRect
      (x, y : SDL.Coordinate;
       width, height : SDL.Natural_Dimension)
      return SDL.Video.Rectangles.Rectangle;

end RectMaker;