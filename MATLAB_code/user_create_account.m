function db_cv = user_create_account(db_cv, user_name, postal_code)
%Create an account. The health state is set to healthy.
%
%Author: Kevin Müller, 05.04.2020

    [db_cv.user, ind_user] = memory_add_element(db_cv.user) ;
    [db_cv.node, ind_node] = memory_add_element(db_cv.node) ;
    
    if ind_user ~= ind_node
        error('Indices issue') ;
    end
    
    db_cv.user.d.('User name')(ind_node) = user_name ;
    
    db_cv.node.d.('Postal code')(ind_node) = postal_code ;
    db_cv.node.d.('Health state')(ind_node) = 0 ; %Healthy
    db_cv.node.d.('Address to link')(ind_node) = 0 ;

end