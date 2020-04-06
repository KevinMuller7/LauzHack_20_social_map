function id_node = tool_find_node(db_cv, user_name)
%Private
%Find the user id from the user name.
%Is empty is not found
%
%Author: Kevin Müller, 05.04.2020

    num_nodes = db_cv.node.h(1) - 1 ;%Assuming no account deletion

    if isscalar(user_name)
        
        if user_name < 1 || user_name > num_nodes
            error('User id is not valid') ;
        end
        
        id_node = user_name ;
    else
        id_node = find(strcmp(db_cv.user.d.('User name')(1 : num_nodes), user_name), 1) ;

        if isempty(id_node)
            warning('User not found') ;
            id_node = [] ;
        end
    end

end