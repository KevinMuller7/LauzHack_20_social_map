function db_cv = user_delete_link(db_cv, user_name, user_name_link)
%Delete a social link from "user_name" (a string or his id) to "user_name_link" (user
%id). The link is deleted only if both side deleted it. Otherwise, it is
%marked as "Deletion pending".
%
%Author: Kevin Müller, 05.04.2020

    if strcmp(user_name, user_name_link)
        warning('Cannot delete a link to oneself') ;
        return ;
    end

    id_node = tool_find_node(db_cv, user_name) ;
    id_node_link = tool_find_node(db_cv, user_name_link) ;
    
    if isempty(id_node) || isempty(id_node_link)
        warning('User or user to delete does not exist') ;
        return ;
    end

    [id_link, num_link] = tool_find_link(db_cv, id_node, id_node_link) ;
    
    if isempty(id_link)
        warning('The link doesn''t exist') ;
    else
        [id_link_2, num_link_2] = tool_find_link(db_cv, id_node_link, id_node) ;
        
        if isempty(id_link_2) ||...
                db_cv.link.d.([num2str(num_link_2), ': Link state'])(id_link_2) == 2 %delete link
            db_cv = delete_link(db_cv, id_node, id_link, num_link) ;
            if ~isempty(id_link_2)
                db_cv = delete_link(db_cv, id_node_link, id_link_2, num_link_2) ;
            end
        else %deletion pending
            db_cv.link.d.([num2str(num_link), ': Link state'])(id_link) = 2 ;
        end
    end
    
end

function db_cv = delete_link(db_cv, id_node, id_link, num_link)

    db_cv.link.d.([num2str(num_link), ': Link state'])(id_link) = 0 ;

    line_empty = true ;
    
    for m1 = 1 : db_cv.g.num_link
        if db_cv.link.d.([num2str(m1), ': Link state'])(id_link) ~= 0 %is a link
            line_empty = false ;
            break ;
        end
    end
    
    if line_empty %delete the line
        id_link_delete = id_link ;
        id_link = db_cv.node.d.('Address to link')(id_node) ;
        
        if id_link == id_link_delete
            db_cv.node.d.('Address to link')(id_node) = db_cv.link.d.('Address to link')(id_link_delete) ;
            db_cv.link = memory_delete_element(db_cv.link, id_link_delete) ;
        else
            id_new_link = id_link ;
            
            while id_new_link ~= id_link_delete
                id_link = id_new_link ;
                id_new_link = db_cv.link.d.('Address to link')(id_link) ;
            end
            
            db_cv.link.d.('Address to link')(id_link) = db_cv.link.d.('Address to link')(id_link_delete) ;
            db_cv.link = memory_delete_element(db_cv.link, id_link_delete) ;
        end
    end

end