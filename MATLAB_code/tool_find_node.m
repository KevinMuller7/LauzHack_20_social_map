function id_node = tool_find_node(db_cv, user_name)
%Private
%Find the user id from the user name.
%Is empty is not found
%
%Author: Kevin Müller, 05.04.2020

    if isscalar(user_name)
        num_nodes = db_cv.node.h(1) - 1 ;%Assuming no account deletion
        if user_name < 1 || user_name > num_nodes
            error('User id is not valid') ;
        end
        
        id_node = user_name ;
    else
        id_node = find(strcmp(db_cv.user.d.('User name'), user_name)) ;

        if isempty(id_node)
            warning('User not found') ;
            id_node = [] ;
        elseif length(id_node) > 2
            error('Multiple user with the same name') ;
        end
    end

end