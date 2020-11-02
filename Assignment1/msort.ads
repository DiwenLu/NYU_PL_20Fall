package Msort is

    LENGTH: constant Integer := 40;
    type Int_Range is range -300 .. 300;
    type My_Int_Array is array(1 .. LENGTH) of Int_Range;
    procedure MergeSort(A: in out My_Int_Array);

end Msort;
