with Application; use Application;
with Ada.Command_Line;

procedure TicTacToe
is
   App : TApplication;
begin
   Create (App);
   if not Run (App) then
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
   end if;
end TicTacToe;
