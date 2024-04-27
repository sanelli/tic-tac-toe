with SDL;
with SDL.Events;
with SDL.Events.Events;
with SDL.Events.Mice; use SDL.Events.Mice;
with SDL.Events.Keyboards;
with Ada.Text_IO; use Ada.Text_IO;

package body Application is

   function Create (application : in out TApplication) return Boolean
   is
   begin
      application.CurrentPlayer := Cross;
      application.HaveWinner := False;
      application.Winner := Empty;
      Create (application.Board);
      return Create (application.Rendering);
   end Create;

   function NextPlayer (currentPlayer : TBoardContent) return TBoardContent
   is
   begin
      case currentPlayer is
         when Cross => return Circle;
         when Circle => return Cross;
         when others => return Empty;
      end case;
   end NextPlayer;

   procedure ProcessEvent
      (application : in out TApplication; running : out Boolean)
   is
      Event       : SDL.Events.Events.Events;
      Row, Column : TBoardRange;
   begin
      running := True;
      if SDL.Events.Events.Poll (Event) then
         case Event.Common.Event_Type is

               --  Quit!
               when SDL.Events.Quit =>
                  Put_Line ("Terminating...");
                  running := False;

               --  Handle keyboard
               when SDL.Events.Keyboards.Key_Up =>

                  case Event.Keyboard.Key_Sym.Key_Code is
                     when SDL.Events.Keyboards.Code_N =>
                        Put_Line ("New game started!");
                        Create (application.Board);
                        application.Winner := Empty;
                        application.HaveWinner := False;
                        application.CurrentPlayer := Cross;
                     when others => null;
                  end case;

               --  Handle mouse
               when SDL.Events.Mice.Button_Up =>

                  if Event.Mouse_Button.Button = Left then

                     if not application.HaveWinner then
                        MouseCoordinateToBoard (
                           Event.Mouse_Button.X,
                           Event.Mouse_Button.Y,
                           Row, Column);

                        --  Move to next player only if cell is empty!
                        if SetValue (
                           application.Board,
                           Row, Column,
                           application.CurrentPlayer)
                        then
                           application.CurrentPlayer :=
                              NextPlayer (application.CurrentPlayer);
                        end if;

                        --  Check if there is a winner
                        application.HaveWinner :=
                           SomebodyWon (application.Board, application.Winner);

                        if application.HaveWinner then
                           if application.Winner = Cross then
                              Put ("X");
                           else
                              Put ("O");
                           end if;
                           Put_Line (" is the winner!");
                        end if;

                        --  If no winner check if the board is completed
                        if not application.HaveWinner
                           and then BoardCompleted (application.Board)
                        then
                              application.Winner := Empty;
                              application.HaveWinner := True;
                              Put_Line ("Game over with no winner!");
                        end if;

                     end if;
                  end if;
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
            RenderWinner (
               application.Rendering,
               application.Board,
               application.Winner);
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