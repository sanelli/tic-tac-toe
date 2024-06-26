with Ada.Text_IO; use Ada.Text_IO;

package body Board is

   procedure Create (board : in out TBoard)
   is
   begin
      for Row in TBoardRange loop
         for Column in TBoardRange loop
            board (Row, Column) := Empty;
         end loop;
      end loop;
   end Create;

   function BoardCompleted (board : TBoard) return Boolean
   is
   begin
      for Row in TBoardRange loop
         for Column in TBoardRange loop
            if board (Row, Column) = Empty then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end BoardCompleted;

   function SomebodyWon (
      board : TBoard;
      winner : out TBoardContent)
      return Boolean
   is

      function InspectRow (
         row : TBoardRange;
         winner : out TBoardContent)
         return Boolean
      is
      begin
         winner := Empty;
         if board (row, 1) = board (row, 2) and then
            board (row, 1) = board (row, 3) and then
            board (row, 1) /= Empty
         then
            winner := board (row, 1);
            return True;
         end if;
         return False;
      end InspectRow;

      function InspetColumn (
         column : TBoardRange;
         winner : out TBoardContent)
         return Boolean
      is
      begin
         winner := Empty;
         if board (1, column) = board (2, column) and then
            board (1, column) = board (3, column) and then
            board (1, column) /= Empty
         then
            winner := board (1, column);
            return True;
         end if;
         return False;
      end InspetColumn;

      function InspetDiagonal (winner : out TBoardContent) return Boolean
      is
      begin
         winner := Empty;
         if board (2, 2) = board (1, 1) and then
            board (2, 2) = board (3, 3) and then
            board (2, 2) /= Empty
         then
            winner := board (2, 2);
            return True;
         end if;

         if board (2, 2) = board (3, 1) and then
            board (2, 2) = board (1, 3) and then
            board (2, 2) /= Empty
         then
            winner := board (2, 2);
            return True;
         end if;

         return False;
      end InspetDiagonal;

      Result : Boolean;
   begin

      Result :=
         InspectRow (1, winner) or else
         InspectRow (2, winner) or else
         InspectRow (3, winner) or else
         InspetColumn (1, winner) or else
         InspetColumn (2, winner) or else
         InspetColumn (3, winner) or else
         InspetDiagonal (winner);
      return Result;

   end SomebodyWon;

   function SetValue (
      board : in out TBoard;
      row, column : TBoardRange;
      item : TBoardContent)
      return Boolean
   is
   begin
      --  Prevent overring existing value;
      if board (row, column) /= Empty then
         return False;
      end if;

      board (row, column) := item;
      return True;
   end SetValue;

end Board;