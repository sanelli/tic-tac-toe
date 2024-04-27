with Board; use Board;
with Rendering; use Rendering;

package Application is
   type TApplication is record
      Board         : TBoard;
      Rendering     : TRendering;
      HaveWinner    : Boolean;
      Winner        : TBoardContent;
      CurrentPlayer : TBoardContent;
   end record;

   function Create (application : in out TApplication) return Boolean;
   function Run (application : in out TApplication) return Boolean;
   procedure Finalise (application : in out TApplication);

end Application;