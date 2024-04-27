package body Application is

   function Create (application : in out TApplication) return Boolean
   is
   begin
      Create (application.Board);
      return Create (application.Rendering);
   end Create;

   function Run (application : in out TApplication) return Boolean
   is
      Running : Boolean;
   begin
      Running := True;
      while Running loop
         ProcessEvent (application.Rendering, Running);
      end loop;

      return True;
   end Run;

   procedure Finalise (application : in out TApplication)
   is
   begin
      Finalise (application.Rendering);
   end Finalise;

end Application;