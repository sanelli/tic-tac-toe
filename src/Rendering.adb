with SDL;
with SDL.Video.Surfaces;
with SDL.Video.Windows.Makers;
with SDL.Video.Textures.Makers;
with SDL.Video.Renderers.Makers;
with SDL.Video.Surfaces.Makers;
with Ada.Text_IO; use Ada.Text_IO;

package body Rendering is

   function Create (rendering : in out TRendering) return Boolean
   is
      TmpSurface : SDL.Video.Surfaces.Surface;
      Sizes      : SDL.Sizes;
   begin
      if not SDL.Initialise then
         Put_Line ("Cannot initialize SDL.");
         return False;
      end if;

      SDL.Video.Windows.Makers.Create
         (rendering.Window, "Tic Tac Toe", 10, 10, 300, 300);

      SDL.Video.Renderers.Makers.Create (rendering.Renderer, rendering.Window);

      Sizes.Height := 100;
      Sizes.Width := 100;

      --  Create empty texture
      SDL.Video.Surfaces.Makers.Create (TmpSurface, Sizes, 32, 0, 0, 0, 0);

      SDL.Video.Textures.Makers.Create (
         rendering.EmptyTexture,
         rendering.Renderer,
         TmpSurface);
      SDL.Video.Surfaces.Finalize (TmpSurface);

      --  Create cross texture
      SDL.Video.Surfaces.Makers.Create (TmpSurface, Sizes, 32, 0, 0, 0, 0);
      SDL.Video.Textures.Makers.Create (
         rendering.CrossTexture,
         rendering.Renderer,
         TmpSurface);
      SDL.Video.Surfaces.Finalize (TmpSurface);

      --  Create circle texture
      SDL.Video.Surfaces.Makers.Create (TmpSurface, Sizes, 32, 0, 0, 0, 0);
      SDL.Video.Textures.Makers.Create (
         rendering.CircleTexture,
         rendering.Renderer,
         TmpSurface);
      SDL.Video.Surfaces.Finalize (TmpSurface);

      return True;
   end Create;

   procedure Finalise (rendering : in out TRendering)
   is
   begin
      SDL.Video.Textures.Destroy (rendering.EmptyTexture);
      SDL.Video.Textures.Destroy (rendering.CircleTexture);
      SDL.Video.Textures.Destroy (rendering.CrossTexture);
      SDL.Finalise;
   end Finalise;

   procedure RenderBoard (
      rendering : in out TRendering;
      board : in out TBoard)
   is
   begin
      null;
   end RenderBoard;

   procedure RenderWinner (
      rendering : in out TRendering;
      winner : TBoardContent)
   is
   begin
      null;
   end RenderWinner;

end Rendering;