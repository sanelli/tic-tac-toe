with SDL.Video.Windows;

package Application is

   type TBoardContent is (Empty, Cross, Square);
   type TBoard is array (1 .. 3, 1 .. 3) of TBoardContent;

   type TApplication is record
      Board    : TBoard;
      Window   : SDL.Video.Windows.Window;
   end record;

   function Create (application : in out TApplication) return Boolean;
   function Run (application : in out TApplication) return Boolean;
   procedure Finalise (application : in out TApplication);

end Application;