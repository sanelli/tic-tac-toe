with SDL;                 use SDL;
with SDL.Video.Surfaces;
with SDL.Video.Rectangles;
with SDL.Video.Renderers; use SDL.Video.Renderers;
with SDL.Video.Windows.Makers;
with SDL.Video.Textures.Makers;
with SDL.Video.Renderers.Makers;
with SDL.Video.Surfaces.Makers;
with SDL.TTFs.Makers;
with SDL.Timers;
with Ada.Text_IO;         use Ada.Text_IO;
with Colours;
with RectMaker;

package body Rendering is

   function Create (rendering : in out TRendering) return Boolean is
      TmpSurface         : SDL.Video.Surfaces.Surface;
      TmpSurfaceRenderer : SDL.Video.Renderers.Renderer;
      TileSize           : SDL.Sizes;
      ExternalRectangle  : SDL.Video.Rectangles.Rectangle;
      InternalRectangle  : SDL.Video.Rectangles.Rectangle;
   begin
      rendering.Status := Playing;

      if not SDL.Initialise then
         Put_Line ("Cannot initialize SDL.");
         return False;
      end if;

      if not SDL.TTFs.Initialise then
         Put_Line ("Cannot initialize SDL TTF.");
         return False;
      end if;

      Put_Line ("SDL Initialised.");

      SDL.Video.Windows.Makers.Create
        (rendering.Window, "Tic Tac Toe", 10, 10, 300, 300);
      Put_Line ("Window created.");

      SDL.Video.Renderers.Makers.Create
        (rendering.Renderer, rendering.Window,
         SDL.Video.Renderers.Accelerated or
         SDL.Video.Renderers.Present_V_Sync);
      Put_Line ("Renderer created.");

      --  Common settings
      TileSize.Height   := 100;
      TileSize.Width    := 100;
      ExternalRectangle :=
        RectMaker.MakeRect (0, 0, TileSize.Width, TileSize.Height);
      InternalRectangle := RectMaker.MakeRect (3, 3, 96, 96);

      --  Load font
      SDL.TTFs.Makers.Create
        (rendering.MessageFont, "BebasNeue-Regular.ttf", 26);

      --  Create empty texture
      SDL.Video.Surfaces.Makers.Create (TmpSurface, TileSize, 32, 0, 0, 0, 0);
      SDL.Video.Renderers.Makers.Create (TmpSurfaceRenderer, TmpSurface);
      TmpSurfaceRenderer.Set_Draw_Colour (Colours.Green);
      TmpSurfaceRenderer.Fill (ExternalRectangle);
      TmpSurfaceRenderer.Set_Draw_Colour (Colours.Black);
      TmpSurfaceRenderer.Fill (InternalRectangle);
      SDL.Video.Textures.Makers.Create
        (rendering.EmptyTexture, rendering.Renderer, TmpSurface);
      TmpSurfaceRenderer.Finalize;
      TmpSurface.Finalize;

      --  Create cross texture
      --  TODO: Actually draw a cross
      SDL.Video.Surfaces.Makers.Create (TmpSurface, TileSize, 32, 0, 0, 0, 0);
      SDL.Video.Renderers.Makers.Create (TmpSurfaceRenderer, TmpSurface);
      TmpSurfaceRenderer.Set_Draw_Colour (Colours.Green);
      TmpSurfaceRenderer.Fill (ExternalRectangle);
      TmpSurfaceRenderer.Set_Draw_Colour (Colours.Red);
      TmpSurfaceRenderer.Fill (InternalRectangle);
      SDL.Video.Textures.Makers.Create
        (rendering.CrossTexture, rendering.Renderer, TmpSurface);
      TmpSurfaceRenderer.Finalize;
      TmpSurface.Finalize;

      --  Create circle texture
      --  TODO: Actually draw a circle
      SDL.Video.Surfaces.Makers.Create (TmpSurface, TileSize, 32, 0, 0, 0, 0);
      SDL.Video.Renderers.Makers.Create (TmpSurfaceRenderer, TmpSurface);
      TmpSurfaceRenderer.Set_Draw_Colour (Colours.Green);
      TmpSurfaceRenderer.Fill (ExternalRectangle);
      TmpSurfaceRenderer.Set_Draw_Colour (Colours.Blue);
      TmpSurfaceRenderer.Fill (InternalRectangle);
      SDL.Video.Textures.Makers.Create
        (rendering.CircleTexture, rendering.Renderer, TmpSurface);
      TmpSurfaceRenderer.Finalize;
      TmpSurface.Finalize;

      return True;
   end Create;

   procedure Finalise (rendering : in out TRendering) is
   begin
      rendering.MessageFont.Finalize;
      rendering.EmptyTexture.Finalize;
      rendering.CircleTexture.Finalize;
      rendering.CrossTexture.Finalize;
      rendering.Renderer.Finalize;
      rendering.Window.Finalize;
      SDL.TTFs.Finalise;
      SDL.Finalise;
   end Finalise;

   --  TODO: Only render if something changed
   procedure RenderBoard (rendering : in out TRendering; board : TBoard) is
      procedure RenderBoardCell (row, column : TBoardRange) with
        Inline => True
      is
         TargetRect : SDL.Video.Rectangles.Rectangle;
      begin
         TargetRect :=
           RectMaker.MakeRect
             (SDL.Coordinate ((column - 1) * 100),
              SDL.Coordinate ((row - 1) * 100), 100, 100);

         case board (row, column) is
            when Empty =>
               rendering.Renderer.Copy (rendering.EmptyTexture, TargetRect);
            when Cross =>
               rendering.Renderer.Copy (rendering.CrossTexture, TargetRect);
            when Circle =>
               rendering.Renderer.Copy (rendering.CircleTexture, TargetRect);
         end case;
      end RenderBoardCell;

   begin
      rendering.Status := Playing;

      rendering.Renderer.Set_Draw_Colour (Colours.Black);
      rendering.Renderer.Clear;

      for Row in TBoardRange loop
         for Column in TBoardRange loop
            RenderBoardCell (Row, Column);
         end loop;
      end loop;

      rendering.Renderer.Present;

   end RenderBoard;

   procedure RenderWinner
     (rendering : in out TRendering; board : TBoard; winner : TBoardContent)
   is
      function WinningMessage return String is
      begin
         case winner is
            when Cross =>
               return "X win!";
            when Circle =>
               return "O win!";
            when Empty =>
               return "Tie!";
         end case;
      end WinningMessage;

      TextSurface       : SDL.Video.Surfaces.Surface;
      TextRect          : SDL.Video.Rectangles.Rectangle;
      WinMessageTexture : SDL.Video.Textures.Texture;

   begin
      if rendering.Status /= GameOver then
         RenderBoard (rendering, board);

         SDL.Timers.Wait_Delay (200);

         rendering.Renderer.Set_Draw_Colour (Colours.Black);
         rendering.Renderer.Clear;

         TextSurface :=
           SDL.TTFs.Render_Solid
             (rendering.MessageFont, WinningMessage, Colours.White);

         TextRect.X      :=
           SDL.Coordinate
             ((300 - Integer (TextSurface.Clip_Rectangle.Width)) / 2);
         TextRect.Y      :=
           SDL.Coordinate
             ((300 - Integer (TextSurface.Clip_Rectangle.Height)) / 2);
         TextRect.Width  := TextSurface.Clip_Rectangle.Width;
         TextRect.Height := TextSurface.Clip_Rectangle.Height;

         SDL.Video.Textures.Makers.Create
           (WinMessageTexture, rendering.Renderer, TextSurface);

         TextSurface.Finalize;

         rendering.Renderer.Copy (WinMessageTexture, TextRect);

         rendering.Renderer.Present;
         WinMessageTexture.Finalize;

         rendering.Status := GameOver;
      end if;

   end RenderWinner;

   procedure MouseCoordinateToBoard
     (x, y : SDL.Natural_Coordinate; row, column : out TBoardRange)
   is
   begin
      row    := TBoardRange (Natural (y) / 100 + 1);
      column := TBoardRange (Natural (x) / 100 + 1);
   end MouseCoordinateToBoard;

end Rendering;
