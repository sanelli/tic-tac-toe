with Application; use Application;
with Ada.Command_Line;

procedure TicTacToe
is
   App      : TApplication;
   Success  : Boolean;
begin
   Success := Create (App) and then Run(App);

   if Success then
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
   end if;

   Finalise (App);
end TicTacToe;
