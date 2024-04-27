with SDL;
with SDL.Events;
with SDL.Events.Events;
with Ada.Text_IO; use Ada.Text_IO;

package body Application is

   function Create (application : in out TApplication) return Boolean
   is
   begin
      application.HaveWinner := False;
      application.Winner := Empty;
      Create (application.Board);
      return Create (application.Rendering);
   end Create;

   procedure ProcessEvent
      (application : in out TApplication; running : out Boolean)
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

   function Run (application : in out TApplication) return Boolean
   is
      Running     : Boolean;
   begin
      Running := True;
      while Running loop
         ProcessEvent (application, Running);

         if application.HaveWinner then
            RenderWinner (application.Rendering, application.Winner);
         else
            RenderBoard (application.Rendering, application.Board);
         end if;

      end loop;

      return True;
   end Run;

   procedure Finalise (application : in out TApplication)
   is
   begin
      Finalise (application.Rendering);
   end Finalise;

end Application;