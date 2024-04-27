with SDL.Video.Windows;
with SDL.Video.Textures;
with SDL.Video.Renderers;
with SDL.TTFs;

with Board; use Board;

package Rendering is

   type TTRenderingStatus is (Playing, GameOver);

   type TRendering is record
      Window            : SDL.Video.Windows.Window;
      Renderer          : SDL.Video.Renderers.Renderer;
      CrossTexture      : SDL.Video.Textures.Texture;
      CircleTexture     : SDL.Video.Textures.Texture;
      EmptyTexture      : SDL.Video.Textures.Texture;
      MessageFont       : SDL.TTFs.Fonts;
      Status            : TTRenderingStatus;
   end record;

   function Create (rendering : in out TRendering) return Boolean;
   procedure Finalise (rendering : in out TRendering);
   procedure RenderBoard (
      rendering : in out TRendering;
      board : TBoard);
   procedure RenderWinner (
      rendering : in out TRendering;
      board : TBoard;
      winner : TBoardContent);

   procedure MouseCoordinateToBoard (
      x, y : SDL.Natural_Coordinate;
      row, column : out TBoardRange);

end Rendering;