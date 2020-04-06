function [ddata, ind_ele] = memory_add_element(ddata)
%Private
%Add an element and increase the size of the table if necessary

    ind_ele = ddata.h(ddata.c) ;
    field_name = fieldnames(ddata.d) ;
    
    if ind_ele > length(ddata.d.(field_name{1}))
        for m1 = 1 : length(field_name)
            ddata.d.(field_name{m1}) = [ddata.d.(field_name{m1}) ; ddata.d.(field_name{m1})] ;
        end
    end

    if ddata.c == 1
        ddata.h(1) = ddata.h(1) + 1 ;
    else
        ddata.c = ddata.c - 1 ;
    end

end