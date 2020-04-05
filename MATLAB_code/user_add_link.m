function db_cv = user_add_link(db_cv, user_name, user_name_link)
%Add a social link from "user_name" (a string or his id) to "user_name_link" (a
%number) The link is created only if both side did it. Otherwise, it is
%marked as one-sided.
%
%Author: Kevin Müller, 05.04.2020

    if strcmp(user_name, user_name_link)
        warning('Cannot add oneself') ;
        return ;
    end

    id_node = tool_find_node(db_cv, user_name) ;
    id_node_link = tool_find_node(db_cv, user_name_link) ;
    
    if isempty(id_node) || isempty(id_node_link)
        warning('User or user to add does not exist') ;
        return ;
    end
    
    [id_link, num_link] = tool_find_link(db_cv, id_node, id_node_link) ;
    
    if isempty(id_link)
        %Add link
        [db_cv, id_link, num_link] = add_link(db_cv, id_node) ;
        %Node initialization
        db_cv.link.d.([num2str(num_link), ': Address to node'])(id_link) = id_node_link ;
        db_cv.link.d.([num2str(num_link), ': Last time'])(id_link) = 0 ;
        
        %Check
        [id_link_2, num_link_2] = tool_find_link(db_cv, id_node_link, id_node) ;
        
        if isempty(id_link_2) %one-sided link
            db_cv.link.d.([num2str(num_link), ': Link state'])(id_link) = 1 ;
        else %Validated link
            db_cv.link.d.([num2str(num_link), ': Link state'])(id_link) = 3 ;
            db_cv.link.d.([num2str(num_link_2), ': Link state'])(id_link_2) = 3 ;
        end
    else
        if db_cv.link.d.([num2str(num_link), ': Link state'])(id_link) == 2 %Remove deletion pending
            db_cv.link.d.([num2str(num_link), ': Link state'])(id_link) = 3 ; %Validated link
        else
            warning('Link already added') ;
        end
    end

end

function [db_cv, id_link, num_link] = add_link(db_cv, id_node)

    id_link = db_cv.node.d.('Address to link')(id_node) ;

    if id_link == 0
        [db_cv.link, id_link] = memory_add_element(db_cv.link) ;
        db_cv.node.d.('Address to link')(id_node) = id_link ;
        num_link = 1 ;
    else
        num_link = [] ;

        while isempty(num_link) && id_link ~= 0
            id_prev_link = id_link ;
            
            for m1 = 1 : db_cv.g.num_link
                if db_cv.link.d.([num2str(m1), ': Link state'])(id_link) == 0 %no link
                    num_link = m1 ;
                    break ;
                end
            end

            id_link = db_cv.link.d.('Address to link')(id_prev_link) ;
        end
        
        if isempty(num_link)
            [db_cv.link, id_link] = memory_add_element(db_cv.link) ;
            db_cv.link.d.('Address to link')(id_prev_link) = id_link ;
            db_cv.link.d.('Address to link')(id_link) = 0 ;
            num_link = 1 ;
        else
            id_link = id_prev_link ;
        end
    end

end