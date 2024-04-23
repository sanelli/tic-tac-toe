with SDL;
with SDL.Video.Windows.Makers;
with Exceptions; use Exceptions;

package body Application is

   procedure Create (application : in out TApplication)
   is
   begin
      if not SDL.Initialise then
         raise TException with "Cannot initialize SDL.";
      end if;
      SDL.Video.Windows.Makers.Create
         (application.Window, "Tic Tac Toe", 10, 10, 300, 300);
   end Create;

   function Run (application : in out TApplication) return Boolean
   is
   begin
      return True;
   end Run;

end Application;