function output_social_net(db_cv)
%Create a 3D plot from the database
%
%Author: Kevin Müller, 05.04.2020

    line_width = 1 ;

    %Draw nodes
    num_nodes = db_cv.node.h(1) - 1 ;%Assuming no account deletion
    
    node_pos = rand(num_nodes, 3) ;
    
    cond_state = false(num_nodes, 4) ;
    cond_state(:,1) = db_cv.node.d.('Health state') (1:num_nodes) == 0 ; %Healthy
    cond_state(:,2) = db_cv.node.d.('Health state') (1:num_nodes) == 1 ; %Sick (but not tested to coronavirus)
    cond_state(:,3) = db_cv.node.d.('Health state') (1:num_nodes) == 2 |...
        db_cv.node.d.('Health state') (1:num_nodes) == 3 ; %Tested positive to coronavirus
    cond_state(:,4) = db_cv.node.d.('Health state') (1:num_nodes) == 4 ; %Recovered from the coronavirus
    
    color_plot = {'b', 'y', 'r', 'g'} ;
    
    figure ;
    hold on
    
    for m1 = 1 : 4
        plot3(node_pos(cond_state(:,m1), 1), node_pos(cond_state(:,m1), 2),...
            node_pos(cond_state(:,m1), 3), '.', 'Color', color_plot{m1}, 'MarkerSize', 14)
    end
    
    text(node_pos(:, 1) + 0.01, node_pos(:, 2) + 0.01, node_pos(:, 3) + 0.01, db_cv.user.d.('User name')(1:num_nodes)) ;

    set(gca, 'Visible', 'off')
    
    %Plot link
    for m1 = 1 : num_nodes
        id_link = db_cv.node.d.('Address to link')(m1) ;
        
        while id_link ~= 0

            for m2 = 1 : db_cv.g.num_link
                if db_cv.link.d.([num2str(m2), ': Link state'])(id_link) ~= 0
                    node_id = db_cv.link.d.([num2str(m2), ': Address to node'])(id_link) ;
                    if db_cv.link.d.([num2str(m2), ': Link state'])(id_link) == 1
                        plot3(node_pos([m1,node_id],1), node_pos([m1,node_id],2),...
                                node_pos([m1,node_id],3), '--', 'LineWidth', line_width, 'Color', 'b') ;
                    else
                        if m1 < node_id
                            plot3(node_pos([m1,node_id],1), node_pos([m1,node_id],2),...
                                node_pos([m1,node_id],3), 'LineWidth', line_width, 'Color', 'b') ;
                        end
                    end
                end
            end

            id_link = db_cv.link.d.('Address to link')(id_link) ;
        end
    end
    
end

