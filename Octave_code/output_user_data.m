function user_data = output_user_data(db_cv, user_name)
%user_data contains all the information the user can see. It includes:
%   - user name
%   - user id (may become hidden to the user)
%   - postal code
%   - health state
%   - the list of relatives/friends
%For each friend, there is the following information:
%   - his/her user name
%   - his/her user id (may become hidden to the user)
%   - his/her health state
%   - your social distance from someone with coronavirus and you through
%   him/her
%
%User_name can also be its id
%
%Author: Kevin Müller, 05.04.2020

    id_node = tool_find_node(db_cv, user_name) ;
    
    if isempty(id_node)
        user_data = [] ;
        return ;
    end
    
    info_link = get_all_link(db_cv, id_node) ;

    user_data.user_name = user_name ;
    user_data.user_id = id_node ;
    user_data.postal_code = db_cv.node.d.('Postal code')(id_node) ;
    user_data.health_state = name_health_state(db_cv.node.d.('Health state')(id_node)) ;
    user_data.links = struct() ;
    
    for m1 = 1 : size(info_link,1)
        user_name_link = db_cv.user.d.('User name'){info_link(m1,1)} ;
        user_data.links.(user_name_link) = struct() ;
        user_data.links.(user_name_link).('User id') = info_link(m1,1) ; %Should not be seen by user
        if info_link(m1,3) == 0
            user_data.links.(user_name_link).('Last time') = 'No given date' ;
        else
            user_data.links.(user_name_link).('Last time') = datestr(info_link(m1,3), 'dd/mm/yyyy') ;
        end
        user_data.links.(user_name_link).('Link state') = name_link_state(info_link(m1,2)) ;
        
        if info_link(m1,2) > 1
            cv_distance = get_link_data(db_cv, info_link(m1,1), [], 1, 3) ;
            if isinf(cv_distance)
                cv_distance = 0 ;
            end
            
            user_data.links.(user_name_link).('Health state') = name_health_state(db_cv.node.d.('Health state')(info_link(m1,1))) ;
            user_data.links.(user_name_link).('Social distance') = name_s_distance(cv_distance) ;
        else
            user_data.links.(user_name_link).('Health state') = 'No information' ;
            user_data.links.(user_name_link).('Social distance') = 'No information' ;
        end
    end

end

function name_state = name_health_state(state_id)

    switch state_id
        case 0 ; name_state = 'Healthy' ;
        case 1 ; name_state = 'Sick' ;
        case 2 ; name_state = 'Sick and positive to coronavirus' ;
        case 3 ; name_state = 'In critical condition and positive to coronavirus' ;
        case 4 ; name_state = 'Recovered from coronavirus' ;
    end

end

function name_state = name_s_distance(state_id)

    switch state_id
        case 0 ; name_state = 'Nobody in his/her social surrounding has the coronavirus' ;
        case 1 ; name_state = 'He/she has the coronavirus' ;
        case 2 ; name_state = 'His/her friend has the coronavirus' ;
        case 3 ; name_state = 'His/her friend knows someone who has the coronavirus' ;
    end

end

function name_state = name_link_state(state_id)

    switch state_id
        case 1 ; name_state = 'One-sided link' ;
        case 2 ; name_state = 'Deletion pending' ;
        case 3 ; name_state = 'Working link' ;
    end
    
end

function info_link = get_all_link(db_cv, id_node)

    %Total number of links
    num_link = 0 ;
    id_link = db_cv.node.d.('Address to link')(id_node) ;
    
    while id_link ~= 0
        for m1 = 1 : db_cv.g.num_link
            if db_cv.link.d.([num2str(m1), ': Link state'])(id_link) ~= 0
                num_link = num_link + 1 ;
            end
        end
        
        id_link = db_cv.link.d.('Address to link')(id_link) ;
    end
    
    info_link = zeros(num_link, 3) ;
    
    num_link = 0 ;
    id_link = db_cv.node.d.('Address to link')(id_node) ;
    
    while id_link ~= 0
        for m1 = 1 : db_cv.g.num_link
            if db_cv.link.d.([num2str(m1), ': Link state'])(id_link) ~= 0
                num_link = num_link + 1 ;
                info_link(num_link, 1) = db_cv.link.d.([num2str(m1), ': Address to node'])(id_link) ;
                info_link(num_link, 2) = db_cv.link.d.([num2str(m1), ': Link state'])(id_link) ;
                info_link(num_link, 3) = db_cv.link.d.([num2str(m1), ': Last time'])(id_link) ;
            end
        end
        
        id_link = db_cv.link.d.('Address to link')(id_link) ;
    end

end

function cv_distance = get_link_data(db_cv, id_node_link, id_ign_node, s_dist, max_dist)

    health_state = db_cv.node.d.('Health state')(id_node_link) ;
    
    if health_state == 2 || health_state == 3 %Has the coronavirus
        cv_distance = s_dist ;
    else
        cv_distance = inf ;
        
        if s_dist ~= max_dist
            info_link = get_all_link(db_cv, id_node_link) ;
            if isempty(id_ign_node)
                info_link = info_link(info_link(:,2) > 1, 1) ; %Validated link
            else
                info_link = info_link(any(info_link(:,1) ~= id_ign_node.', 2) & info_link(:,2) > 1, 1) ;
            end
            id_ign_node = [id_ign_node ; info_link] ;

            for m1 = 1 : length(info_link)
               cv_distance = min(cv_distance, get_link_data(db_cv, info_link(m1), id_ign_node, s_dist + 1, max_dist)) ;
            end
        end
    end

end