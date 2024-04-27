with Ada.Text_IO; use Ada.Text_IO;
with SDL;
with SDL.Video.Windows.Makers;
with SDL.Events;
with SDL.Events.Events;

package body Rendering is

   function Create (rendering : in out TRendering) return Boolean
   is
   begin
      if not SDL.Initialise then
         Put_Line ("Cannot initialize SDL.");
         return False;
      end if;

      SDL.Video.Windows.Makers.Create
         (rendering.Window, "Tic Tac Toe", 10, 10, 300, 300);

      return True;
   end Create;

   procedure Finalise (rendering : in out TRendering)
   is
   begin
      SDL.Finalise;
   end Finalise;

   procedure ProcessEvent
      (rendering : in out TRendering; running : out Boolean)
   is
      Event   : SDL.Events.Events.Events;
   begin
      running := True;
      if SDL.Events.Events.Poll (Event) then
         case Event.Common.Event_Type is
               when SDL.Events.Quit =>
                  Put_Line ("Terminating...");
                  running := False;
               when others => null;
         end case;
      end if;
   end ProcessEvent;

end Rendering;