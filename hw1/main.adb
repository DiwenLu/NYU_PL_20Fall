with Text_Io;
use Text_Io;

With Msort;
use Msort;

procedure Main is
    A : My_Int_Array;
    package Int_Io is new Integer_Io (Int_Range);
    use Int_Io;

    element: Int_Range;
    sum : Integer;

    -- read in values
    procedure Read is
    begin 
        for i in 1 .. LENGTH loop
            Int_Io.get(element);
            A(i) := element;
        end loop;
    end Read;

    -- computer sum & print sorted array concurrently
    procedure Printer is

        task ComputeSum;
        task PrintSorted is 
            entry sumDone;
        end PrintSorted;

        task body ComputeSum is 
        begin
            sum := 0;
            for i in 1 .. LENGTH
            loop
                sum := sum + Integer(A(i));
            end loop;
            PrintSorted.sumDone;
        end ComputeSum;

        task body PrintSorted is
        begin
            for i in 1 .. LENGTH
            loop
                Put(A(i));
                new_line;
            end loop;
            accept sumDone;
            PUT("Sum is" & Integer'image(sum));
        end PrintSorted;

    begin
        null;
    end Printer; 

begin
    Read;
    MergeSort(A);
    Printer;
end Main; 