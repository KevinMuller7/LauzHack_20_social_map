function [ddata, ind_ele] = memory_add_element(ddata)
%Private
%Add an element and increase the size of the table if necessary

    ind_ele = ddata.h(ddata.c) ;
    
    if ind_ele > size(ddata.d,1)
        ddata.d = [ddata.d; ddata.d] ;
    end

    if ddata.c == 1
        ddata.h(1) = ddata.h(1) + 1 ;
    else
        ddata.c = ddata.c - 1 ;
    end

end