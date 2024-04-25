package body Board is

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

      function InspetLine (
         line : TBoardRange;
         winner : out TBoardContent)
         return Boolean
      is
      begin
         winner := Empty;
         if board (line, 1) = board (line, 2) and then
            board (line, 1) = board (line, 3) and then
            board (line, 1) /= Empty
         then
            winner := board (line, 1);
            return True;
         end if;
         return False;
      end InspetLine;

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
         if board (1, 1) = board (2, 2) and then
            board (2, 2) = board (3, 3) and then
            board (2, 2) /= Empty
         then
            winner := board (2, 2);
            return True;
         end if;

         if board (1, 3) = board (2, 2) and then
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

      Result := InspetLine (1, winner) or else
               InspetLine (2, winner) or else
               InspetLine (3, winner) or else
               InspetColumn (1, winner) or else
               InspetColumn (2, winner) or else
               InspetColumn (3, winner) or else
               InspetDiagonal (winner);
      return Result;

   end SomebodyWon;

end Board;