function db_cv = user_change_postal_code(db_cv, user_name, postal_code)
%Change the postal code of "user_name" (a string or his id)
%
%Author: Kevin Müller, 05.04.2020

    id_node = tool_find_node(db_cv, user_name) ;
    
    if isempty(id_node)
        warning('User does not exist') ;
        return ;
    end
    
    db_cv.node.d.('Postal code')(id_node) = postal_code ;
    
end