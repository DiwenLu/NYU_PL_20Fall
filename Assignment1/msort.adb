package body Msort is

    procedure MergeSort(A: in out My_Int_Array) is

        procedure Merge(left : Integer; mid : Integer; right : Integer) is
            -- merge the elements of A from left to mid with the elements from mid+1 to right
            merged_array: My_Int_Array;
            left_index: Integer;
            right_index: Integer;
            local_index: Integer;
        begin
            -- fill space holder merged_array
            merged_array := A;

            -- initilize iteration index
            left_index := left;
            right_index := mid + 1;
            local_index := left;

            -- start filling placeholder
            while left_index <= mid and right_index <= right loop
                if A(left_index) <= A(right_index) then
                    merged_array(local_index) := A(left_index);
                    local_index := local_index + 1;
                    left_index := left_index + 1;
                else
                    merged_array(local_index) := A(right_index);
                    local_index := local_index + 1;
                    right_index := right_index + 1;
                end if;
            end loop;

            while left_index <= mid loop
                merged_array(local_index) := A(left_index);
                local_index := local_index + 1;
                left_index := left_index + 1;
            end loop;

            while right_index <= right loop
                merged_array(local_index) := A(right_index);
                local_index := local_index + 1;
                right_index := right_index + 1;
            end loop;

            -- fill back
            A := merged_array;
        end Merge;

        procedure Sort(left : Integer; right : Integer) is
            -- sort concurrently
            procedure DoTasks(mid: Integer) is

                task LeftTask;
                task RightTask;

                task body LeftTask is
                begin
                    if mid - left > 0 then
                        Sort(left, mid);
                    end if;
                end LeftTask;

                task body RightTask is
                begin
                    if right - mid - 1 > 0 then
                        Sort(mid + 1, right);
                    end if;
                end RightTask;
            begin
                null;
            end DoTasks;

        begin
            DoTasks((left + right) / 2);
            Merge(left, (left + right) / 2, right);
        end Sort;

    begin 
        Sort(1, LENGTH);
    end MergeSort;

end Msort;
