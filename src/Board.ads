package Board is

   type TBoardContent is (Empty, Cross, Circle);
   type TBoardRange is range 1 .. 3;
   type TBoard is array (TBoardRange, TBoardRange) of TBoardContent;

   procedure Create (board : in out TBoard);
   function SetValue (
      board : in out TBoard;
      row, column : TBoardRange;
      item : TBoardContent)
      return Boolean;

   function BoardCompleted (board : TBoard) return Boolean;
   function SomebodyWon (
      board : TBoard;
      winner : out TBoardContent)
      return Boolean;

end Board;