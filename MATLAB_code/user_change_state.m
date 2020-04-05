function db_cv = user_change_state(db_cv, user_name, new_state)
%Change the health state of "user_name" (a string or his id)
%healthy(0), sick(1), sick (corona)(2), critical (corona)(3), recovered (4)
%
%Author: Kevin Müller, 05.04.2020

    id_node = tool_find_node(db_cv, user_name) ;
    
    if isempty(id_node)
        warning('User does not exist') ;
        return ;
    end
    
    if new_state < 0 || new_state > 4 %From healthy (0) to recovered (4)
        error('This health state does not exist')
    end
    
    db_cv.node.d.('Health state')(id_node) = new_state ;
    
end