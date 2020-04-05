function [id_link, num_link] = tool_find_link(db_cv, id_node, id_node_link)
%Private
%Find the social link from "id_node" to "id_node_link"
%id_link and num_link is empty if not found
%
%Author: Kevin Müller, 05.04.2020

    id_link = [] ;
    num_link = [] ;
    
    id_new_link = db_cv.node.d.('Address to link')(id_node) ;

    while isempty(num_link) && id_new_link ~= 0
        id_link = id_new_link ;
        
        for m1 = 1 : 5
            if db_cv.link.d.([num2str(m1), ': Link state'])(id_link) ~= 0 &&...
                    db_cv.link.d.([num2str(m1), ': Address to node'])(id_link) == id_node_link
                num_link = m1 ;
                break ;
            end
        end
        
        id_new_link = db_cv.link.d.('Address to link')(id_link) ;
    end
    
    if isempty(num_link)
        id_link = [] ;
    end

end