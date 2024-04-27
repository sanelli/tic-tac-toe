with SDL.Video.Windows;
--  with SDL.Video.Texture;

package Rendering is

   type TRendering is record
       Window   : SDL.Video.Windows.Window;
   end record;

   function Create (rendering : in out TRendering) return Boolean;
   procedure ProcessEvent
      (rendering : in out TRendering; running : out Boolean);
   procedure Finalise (rendering : in out TRendering);

end Rendering;