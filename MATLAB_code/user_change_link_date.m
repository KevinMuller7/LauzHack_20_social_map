function db_cv = user_change_link_date(db_cv, user_name, user_name_link, meeting_date)
%Change the date of the last meeting of "user_name" (string or user id)
%with "user_name_link" (string or user id). The format of the meeting date
%is dd/mm/yyyy
%
%Author: Kevin Müller, 05.04.2020

    if strcmp(user_name, user_name_link)
        warning('Link between same users doesn''t exist') ;
        return ;
    end

    id_node = tool_find_node(db_cv, user_name) ;
    id_node_link = tool_find_node(db_cv, user_name_link) ;
    
    if isempty(id_node) || isempty(id_node_link)
        warning('User or user to delete does not exist') ;
        return ;
    end
    
    [id_link, num_link] = tool_find_link(db_cv, id_node, id_node_link) ;
    
    db_cv.link.d.([num2str(num_link), ': Last time'])(id_link) =...
        datenum(meeting_date, 'dd/mm/yyyy') ;

end

