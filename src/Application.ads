with SDL.Video.Windows;
with Board; use Board;

package Application is
   type TApplication is record
      Board    : TBoard;
      Window   : SDL.Video.Windows.Window;
   end record;

   function Create (application : in out TApplication) return Boolean;
   function Run (application : in out TApplication) return Boolean;
   procedure Finalise (application : in out TApplication);

end Application;