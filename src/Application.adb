with SDL;
with SDL.Video.Windows.Makers;
with SDL.Events;
with SDL.Events.Events;
with Exceptions; use Exceptions;
with Ada.Text_IO; use Ada.Text_IO;

package body Application is

   function Create (application : in out TApplication) return Boolean
   is
   begin
      Create(application.Board);

      if not SDL.Initialise then
         Put_Line ("Cannot initialize SDL.");
         return False;
      end if;

      SDL.Video.Windows.Makers.Create
         (application.Window, "Tic Tac Toe", 10, 10, 300, 300);

      return True;
   end Create;

   function Run (application : in out TApplication) return Boolean
   is
      Running : Boolean;
      Event   : SDL.Events.Events.Events;
   begin
      Running := True;
      while Running loop
         if SDL.Events.Events.Poll (Event) then 
            case Event.Common.Event_Type is
                  when SDL.Events.Quit =>
                     Put_Line ("Terminating...");
                     Running := False;
                  when others => null;
            end case;
         end if;
      end loop;

      return True;
   end Run;

   procedure Finalise (application : in out TApplication)
   is
   begin
      SDL.Finalise;
   end Finalise;

end Application;