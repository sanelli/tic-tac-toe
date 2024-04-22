with SDL;
with SDL.Video.Windows;
with SDL.Video.Windows.Makers;

procedure TicTacToe
is
   Window : SDL.Video.Windows.Window;
begin
   if not SDL.Initialise then
      null;
   end if;
   SDL.Video.Windows.Makers.Create (Window, "Tic Tac Toe", 10, 10, 300, 300);
end TicTacToe;
