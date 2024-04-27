with SDL; use SDL;
with SDL.Video.Surfaces;
with SDL.Video.Rectangles;
with SDL.Video.Palettes;
with SDL.Video.Windows.Makers;
with SDL.Video.Textures.Makers;
with SDL.Video.Renderers.Makers;
with SDL.Video.Surfaces.Makers;
with Ada.Text_IO; use Ada.Text_IO;

package body Rendering is

   function Create (rendering : in out TRendering) return Boolean is
      TmpSurface         : SDL.Video.Surfaces.Surface;
      TmpSurfaceRenderer : SDL.Video.Renderers.Renderer;
      Sizes              : SDL.Sizes;
      ExternalRectangle  : SDL.Video.Rectangles.Rectangle;
      InternalRectangle  : SDL.Video.Rectangles.Rectangle;
      GreenColour        : SDL.Video.Palettes.Colour;
      BlackColour        : SDL.Video.Palettes.Colour;
   begin
      if not SDL.Initialise then
         Put_Line ("Cannot initialize SDL.");
         return False;
      end if;

      Put_Line ("SDL Initialised.");

      SDL.Video.Windows.Makers.Create
        (rendering.Window, "Tic Tac Toe", 10, 10, 300, 300);
      Put_Line ("Window created.");

      SDL.Video.Renderers.Makers.Create (rendering.Renderer, rendering.Window);
      Put_Line ("Renderer created.");

      --  Common settings
      GreenColour.Alpha        := 255;
      GreenColour.Green        := 255;
      BlackColour.Alpha        := 255;
      Sizes.Height             := 100;
      Sizes.Width              := 100;
      ExternalRectangle.X      := 0;
      ExternalRectangle.Y      := 0;
      ExternalRectangle.Width  := Sizes.Width;
      ExternalRectangle.Height := Sizes.Height;
      InternalRectangle.X      := 3;
      InternalRectangle.Y      := 3;
      InternalRectangle.Width  := 94;
      InternalRectangle.Height := 94;

      --  Create empty texture
      SDL.Video.Surfaces.Makers.Create (TmpSurface, Sizes, 32, 0, 0, 0, 0);
      SDL.Video.Renderers.Makers.Create (TmpSurfaceRenderer, TmpSurface);
      TmpSurfaceRenderer.Set_Draw_Colour (GreenColour);
      TmpSurfaceRenderer.Fill (ExternalRectangle);
      TmpSurfaceRenderer.Set_Draw_Colour (BlackColour);
      TmpSurfaceRenderer.Fill (InternalRectangle);
      SDL.Video.Textures.Makers.Create
        (rendering.EmptyTexture, rendering.Renderer, TmpSurface);
      TmpSurfaceRenderer.Finalize;
      TmpSurface.Finalize;

      --  Create cross texture
      SDL.Video.Surfaces.Makers.Create (TmpSurface, Sizes, 32, 0, 0, 0, 0);
      SDL.Video.Textures.Makers.Create
        (rendering.CrossTexture, rendering.Renderer, TmpSurface);
      TmpSurface.Finalize;

      --  Create circle texture
      SDL.Video.Surfaces.Makers.Create (TmpSurface, Sizes, 32, 0, 0, 0, 0);
      SDL.Video.Textures.Makers.Create
        (rendering.CircleTexture, rendering.Renderer, TmpSurface);
      TmpSurface.Finalize;

      return True;
   end Create;

   procedure Finalise (rendering : in out TRendering) is
   begin
      rendering.EmptyTexture.Finalize;
      rendering.CircleTexture.Finalize;
      rendering.CrossTexture.Finalize;
      SDL.Finalise;
   end Finalise;

   --  TODO: Only render if something changed
   procedure RenderBoard (rendering : in out TRendering; board : TBoard)
   is
      procedure RenderBoardCell (row, column : TBoardRange)
      with Inline => True
      is
         TargetRect : SDL.Video.Rectangles.Rectangle;
      begin
         TargetRect.X := SDL.Coordinate ((column - 1) * 100);
         TargetRect.Y := SDL.Coordinate ((row - 1) * 100);
         TargetRect.Width := 100;
         TargetRect.Height := 100;

         case board (row, column) is
            when Empty =>
               rendering.Renderer.Copy
                  (rendering.EmptyTexture, TargetRect);
            when Cross =>
               rendering.Renderer.Copy
                  (rendering.CrossTexture, TargetRect);
            when Circle =>
               rendering.Renderer.Copy
                  (rendering.CircleTexture, TargetRect);
         end case;
      end RenderBoardCell;

      BlackColour : SDL.Video.Palettes.Colour;
   begin
      BlackColour.Alpha := 255;
      BlackColour.Red := 0;
      BlackColour.Green := 0;
      BlackColour.Blue := 0;
      rendering.Renderer.Set_Draw_Colour (BlackColour);
      rendering.Renderer.Clear;

      for Row in TBoardRange loop
         for Column in TBoardRange loop
            RenderBoardCell (Row, Column);
            null;
         end loop;
      end loop;

      rendering.Renderer.Present;

   end RenderBoard;

   procedure RenderWinner
     (rendering : in out TRendering; winner : TBoardContent)
   is
   begin
      null;
   end RenderWinner;

end Rendering;
