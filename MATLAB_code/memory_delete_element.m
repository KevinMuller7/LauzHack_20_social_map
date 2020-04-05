function ddata = memory_delete_element(ddata, ind_ele)
%Private
%Delete an element and store the info that there is a space for anew
%element there
    
    ddata.c = ddata.c + 1 ;
    
    if ddata.c > length(ddata.h)
        ddata.h = [ddata.h ; ddata.h] ;
    end
    
    ddata.h(ddata.c) = ind_ele ;

end